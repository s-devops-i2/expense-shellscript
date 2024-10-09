
echo Install Nginx

dnf install nginx -y &>>tmp.log

echo Remove old content
rm -rf /usr/share/nginx/html/*

echo Create Nginx Reverse Proxy Configuration.
cp expense.conf /etc/nginx/default.d/expense.conf

echo Download frontend content
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>tmp.log

echo Extract the frontend content.
cd /usr/share/nginx/html

unzip /tmp/frontend.zip

systemctl enable nginx
systemctl restart nginx
