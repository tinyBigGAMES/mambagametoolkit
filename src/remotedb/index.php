<?php
/******************************************************************************
                     __  __               _
                    |  \/  | __ _  _ __  | |__  __ _
                    | |\/| |/ _` || '  \ | '_ \/ _` |
                    |_|  |_|\__,_||_|_|_||_.__/\__,_|
                              Game Toolkit™

                 Copyright © 2024-present tinyBigGAMES™ LLC
                          All Rights Reserved.

                    Website: https://tinybiggames.com
                    Email  : support@tinybiggames.com

                 See LICENSE file for license information
-------------------------------------------------------------------------------
Based on:
  https://github.com/telecube/mysql-api
  
******************************************************************************/
// this definition can be checked in the required scripts to ensure they
// aren't called directly.
define('MAIN_INCLUDED', 1);

// --- Config ---------------------------------------------------------------
class Config
{
	// master detail
	private $master_db_host;
	private $master_db_port;
	private $master_db_user;
	private $master_db_pass;
	
	// apikey
	private $apikey;

	public function __construct(){
		// modify this to point to your config script that should be
		// outside of your visible www folder
		include("/home/username/remotedb/config.php");

		// master detail
		$this->master_db_host 	= $master_db_host; 
		$this->master_db_port 	= $master_db_port; 
		$this->master_db_user 	= $master_db_user; 
		$this->master_db_pass 	= $master_db_pass; 

		// apikey
		$this->apikey 			    = $apikey;
    }       

	public function get($varname){
		return isset($this->$varname) ? $this->$varname : false;
	}
}

// --- Common ---------------------------------------------------------------
class Common
{
	public static function requested_keyspace(){
		if(isset($_REQUEST['keyspace']) && !empty($_REQUEST['keyspace'])){
			return $_REQUEST['keyspace'];
		}else{
			header("HTTP/1.1 400 Bad Request");
			echo json_encode(array("query_status"=>"ERROR","response"=>"You must set a keyspace!"));
			exit();
		}
	}

	public static function requested_query(){
		if(isset($_REQUEST['query']) && !empty($_REQUEST['query'])){
			return $_REQUEST['query'];
		}else{
			header("HTTP/1.1 400 Bad Request");
			echo json_encode(array("query_status"=>"ERROR","response"=>"You must set a query!"));
			exit();
		}
	}
}

//--- Auth -----------------------------------------------------------------
class Auth
{
	public static function api_check_key()
  {
		global $Config;

		// get the apikey from config
		$apikey = $Config->get("apikey");
		// check the api key
		if(!isset($_REQUEST["apikey"]) || $_REQUEST["apikey"] != $apikey){
			header('HTTP/1.0 401 Unauthorized');
			echo json_encode(array("query_status"=>"ERROR","response"=>"Unauthorized request."));
			exit();
		}
	}
}

//--- Db ----------------------------------------------------------------------
class Db
{
	//public static function pdo_query($q,$data=array(),$link){
	public static function pdo_query($link, $q, $data = array()){	
		$rq_type = substr(strtolower($q), 0, 6);

	    try{
			$res = array();
	    	
	    	$rec = $link->prepare($q);  
	    	
	    	if($rq_type == "select"){
	    		$rec->execute($data); 
				$rec->setFetchMode(\PDO::FETCH_ASSOC);  
				while($rs = $rec->fetch()){
					$res[] = $rs;
				}
	    	}else{
	    		$res = $rec->execute($data); 
	    	}

			$rec->closeCursor();
			return $res;

	    }catch(\PDOException $ex){
			return $ex->getMessage();
	    } 
	}
}

// --- Main -----------------------------------------------------------------
$Config = new Config;
$Common = new Common;
$Auth 	= new Auth;
$Db     = new Db;

// check the apikey is set and valid
$Auth->api_check_key();

$query_start = microtime(true);

// get the keyspace/database
$keyspace 		= $Common->requested_keyspace();
// get the query
$query 			= $Common->requested_query();
$query 			= trim($query);
// get the data
$data       = [];

// pdo db connection
try{
	$dbPDO = new PDO('mysql:dbname='.$Common->requested_keyspace().';host='.$Config->get("master_db_host").';port='.$Config->get("master_db_port"), $Config->get("master_db_user"), $Config->get("master_db_pass"));
} catch(PDOException $ex){
	exit( 'Connection failed: ' . $ex->getMessage() );
}
$dbPDO->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );

// test the query type
$query_type = substr(strtolower($query), 0, 6);
//$response = $Db->pdo_query($query,$data,$dbPDO,$query_type);
$response = $Db->pdo_query($dbPDO, $query, $data,$query_type);

$query_status = "OK";

$query_end = microtime(true);
$query_time = $query_end - $query_start;

$response_length = strlen(json_encode($response));

// echo the response
echo json_encode(array("query_status"=>$query_status,"query_time"=>$query_time,"response_length"=>$response_length,"response"=>$response));

?>