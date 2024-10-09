echo Install MySQL Server 8.0.x

dnf install mysql-server -y &>>/tmp/data.log
echo $?
echo Start MySQL Service

systemctl enable mysqld &>>/tmp/data.log
echo $?
systemctl start mysqld
echo $?
echo Next, We need to change the default root password in order to start using the database service. Use password ExpenseApp@1 or any other as per your choice.

mysql_secure_installation --set-root-pass ExpenseApp@1
echo $?
