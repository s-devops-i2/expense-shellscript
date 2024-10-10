source common.sh

mysql_root_password=$1
if [ -z "${mysql_root_password}" ]; then
  echo -e "\e[31mInput is missing\e[0m"
  exit 1
    
fi
print_heading  "Install MySQL Server 8.0.x"

dnf install mysql-server -y &>>/tmp/data.log
print_status $?
print_heading  "Start MySQL Service"

systemctl enable mysqld &>>/tmp/data.log
print_status $?
systemctl start mysqld
print_status $?
print_heading "Change the default root password"

echo 'show databases' | mysql -h 3.90.190.179 -uroot -pExpenseApp@1
if [ $? -ne 0 ]; then
mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOG
fi
print_status $?
