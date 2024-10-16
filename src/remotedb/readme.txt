=============================================================================
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
-----------------------------------------------------------------------------
Based on:
  https://github.com/telecube/mysql-api
  
=============================================================================

RemoteDB - PHP Interface for Remote MySQL Database

1. If you are using cPanel, ensure that both php_mysql and pdo_mysql
   extensions are enabled.
2. Update the config.php file to set your MySQL configuration.
3. In the Config class within index.php, adjust the path to correctly
   reference your config.php script.
4. Ensure that config.php is stored outside of the publicly accessible HTTP
   directory for security reasons.
