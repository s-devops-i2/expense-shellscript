echo disable nodejs
dnf module disable nodejs -y &>>/tmp/data.log
echo enable nodejs
dnf module enable nodejs:20 -y &>>/tmp/data.log

echo install nodejs
dnf install nodejs -y &>>/tmp/data.log


echo Add application User

useradd expense

echo Lets setup an app directory.

mkdir /app

echo Download the application code to created app directory.

curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/data.log
cd /app
unzip /tmp/backend.zip &>>/tmp/data.log

echo Setup SystemD Expense Backend Service

cp backend.service /etc/systemd/system/backend.service

echo Lets download the dependencies.

cd /app
npm install


echo Load the service.

systemctl daemon-reload

echo enable the service.

systemctl enable backend &>>/tmp/data.log

echo Start the service.
systemctl start backend

echo install mysql client
dnf install mysql -y &>>/tmp/data.log

echo Load Schema

mysql -h 172.31.31.229 -uroot -pExpenseApp@1 < /app/schema/backend.sql

