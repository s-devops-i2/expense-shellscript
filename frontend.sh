
echo Install Nginx

dnf install nginx -y &>>/tmp/data.log

echo Remove old content
rm -rf /usr/share/nginx/html/*

echo Create Nginx Reverse Proxy Configuration.
cp expense.conf /etc/nginx/default.d/expense.conf

echo Download frontend content
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>/tmp/data.log

echo Extract the frontend content.
cd /usr/share/nginx/html &>>/tmp/data.log

unzip /tmp/frontend.zip &>>/tmp/data.log

echo Enable nginx
systemctl enable nginx &>>/tmp/data.log
echo Start nginx
systemctl start nginx
