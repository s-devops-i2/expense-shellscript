source common.sh

component=frontend
app_dir=/usr/share/nginx/html


print_heading "Install Nginx"
print_status $?
dnf install nginx -y &>>$LOG
print_status $?


print_heading  "Copy expense nginx configuration"
cp expense.conf /etc/nginx/default.d/expense.conf
print_status $?

App_PreReq

print_heading  "Start nginx"
systemctl start nginx
print_heading  "Enable nginx"
systemctl enable nginx &>>$LOG
print_status $?
print_heading  "retart nginx"
systemctl restart nginx
print_status $?
