source common.sh

print_heading "Install Nginx"
echo $?
dnf install nginx -y &>>/tmp/data.log
echo $?
print_heading  Remove old content
rm -rf /usr/share/nginx/html/*
echo $?

print_heading  Create Nginx Reverse Proxy Configuration.
cp expense.conf /etc/nginx/default.d/expense.conf
echo $?

print_heading  Download frontend content
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>/tmp/data.log
echo $?

print_heading  Extract the frontend content.
cd /usr/share/nginx/html &>>/tmp/data.log
echo $?

unzip /tmp/frontend.zip &>>/tmp/data.log
echo $?

print_heading  Enable nginx
systemctl enable nginx &>>/tmp/data.log
echo $?
print_heading  Start nginx
systemctl start nginx
echo $?
