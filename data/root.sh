!#bin/bash
function init_mysql_db_table(){
usersvr=$(cat ./db.sql)
sudo docker exec -it mysql-docker bash -c "mysql -uroot -pasd1314lxc -e  '$usersvr'"

}
init_mysql_db_table
