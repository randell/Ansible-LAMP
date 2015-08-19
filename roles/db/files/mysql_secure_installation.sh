#!/bin/bash

NEW_ROOT_PWD=$1

# Set root password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('$NEW_ROOT_PWD') WHERE User = 'root';"
# Disable root remote connection
mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
# Delete the anonymous users
mysql -e "DELETE FROM mysql.user WHERE User='';"
# Drop test database
mysql -e "DROP DATABASE test;"
mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"

# Make our changes take effect
mysql -e "FLUSH PRIVILEGES;"
# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

