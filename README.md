# dweb

Dependency errors 
/usr/bin/ld: cannot find -lpq
/usr/bin/ld: cannot find -lsqlite3
/usr/bin/ld: cannot find -lmysqlclient

Add lib in front and -dev at the end
Ex:
sudo apt-get install libmysqlclient-dev