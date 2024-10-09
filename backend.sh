echo disable nodejs
dnf module disable nodejs -y &>>/tmp/data.log
echo $?
echo enable nodejs
dnf module enable nodejs:20 -y &>>/tmp/data.log
echo $?

echo install nodejs
dnf install nodejs -y &>>/tmp/data.log
echo $?


echo Add application User
id expense &>>/tmp/data.log
if [ $? -ne 0 ]; then
useradd expense
fi

echo setup an app directory.
if [ ! -d /app  ]; then
mkdir /app
fi


echo Setup SystemD Expense Backend Service
cp backend.service /etc/systemd/system/backend.service

echo Download the application code to created app directory.

curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/data.log
echo $?
cd /app
unzip /tmp/backend.zip &>>/tmp/data.log
echo $?


echo download the dependencies.

#cd /app
npm install &>>/tmp/data.log
echo $?

echo Load the service.

systemctl daemon-reload
echo $?
echo enable the service.

systemctl enable backend &>>/tmp/data.log
echo $?
echo Start the service.
systemctl start backend
echo $?
echo install mysql client
dnf install mysql -y &>>/tmp/data.log
echo $?
echo Load Schema

mysql -h 172.31.31.229 -uroot -pExpenseApp@1 < /app/schema/backend.sql
echo $?
