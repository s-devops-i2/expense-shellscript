source common.sh

print_heading  "Install MySQL Server 8.0.x"

dnf install mysql-server -y &>>/tmp/data.log
echo $?
print_heading  "Start MySQL Service"

systemctl enable mysqld &>>/tmp/data.log
echo $?
systemctl start mysqld
echo $?
print_heading "Change the default root password"

mysql_secure_installation --set-root-pass ExpenseApp@1
echo $?
