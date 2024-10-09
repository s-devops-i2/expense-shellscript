source common.sh

print_heading "disable nodejs"
dnf module disable nodejs -y &>>/tmp/data.log
echo $?
print_heading  "enable nodejs"
dnf module enable nodejs:20 -y &>>/tmp/data.log
print_status $?

print_heading  "install nodejs"
dnf install nodejs -y &>>/tmp/data.log
print_status $?


print_heading  "Add application User"
id expense &>>/tmp/data.log
if [ $? -ne 0 ]; then
useradd expense
fi

print_heading  "setup an app directory."
if [ ! -d /app  ]; then
mkdir /app
fi


print_heading  "copy Backend Service"
cp backend.service /etc/systemd/system/backend.service

print_heading  "Download the application code to created app directory."

curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/data.log
print_status $?
cd /app
app_dir=/app
if [ -z "${app_dir}" ]; then
unzip /tmp/backend.zip &>>/tmp/data.log
fi
print_status $?

print_heading  "download the dependencies."

cd /app
npm install &>>/tmp/data.log
print_status $?

print_heading  "Load the service."

systemctl daemon-reload
print_status $?
print_heading  "enable the service."

systemctl enable backend &>>/tmp/data.log
print_status $?
print_heading  "Start the service."
systemctl start backend
print_status $?
print_heading  "install mysql client"
dnf install mysql -y &>>/tmp/data.log
print_status $?
print_heading  "Load Schema"

mysql -h 172.31.31.229 -uroot -pExpenseApp@1 < /app/schema/backend.sql
print_status $?
