source common.sh

print_heading "Install Nginx"
print_status $?
dnf install nginx -y &>>/tmp/data.log
print_status $?
print_heading  "Remove old content"
rm -rf /usr/share/nginx/html/*
print_status $?

print_heading  "Create Nginx Reverse Proxy Configuration."
cp expense.conf /etc/nginx/default.d/expense.conf
print_status $?

print_heading  "Download frontend content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>/tmp/data.log
print_status $?

print_heading  "Extract the frontend content."
cd /usr/share/nginx/html &>>/tmp/data.log
print_status $?

unzip /tmp/frontend.zip &>>/tmp/data.log
print_status $?

print_heading  "Enable nginx"
systemctl enable nginx &>>/tmp/data.log
print_status $?
print_heading  "Start nginx"
systemctl start nginx
print_status $?
