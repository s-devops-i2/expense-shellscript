source common.sh

component=backend
app_dir=/app

print_heading "disable nodejs"
dnf module disable nodejs -y &>>$LOG
echo $?
print_heading  "enable nodejs"
dnf module enable nodejs:20 -y &>>$LOG
print_status $?

print_heading  "install nodejs"
dnf install nodejs -y &>>$LOG
print_status $?


print_heading  "Add application User"
id expense &>>$LOG
if [ $? -ne 0 ]; then
useradd expense
fi

print_heading  "copy Backend Service file"
cp backend.service /etc/systemd/system/backend.service

App_PreReq

print_heading  "download the dependencies."

cd /app
npm install &>>$LOG
print_status $?

print_heading  "Load the service."

systemctl daemon-reload
print_status $?
print_heading  "enable the service."

systemctl enable backend &>>$LOG
print_status $?
print_heading  "Start the service."
systemctl start backend
print_status $?
print_heading  "install mysql client"
dnf install mysql -y &>>$LOG
print_status $?
print_heading  "Load Schema"

mysql -h 172.31.31.229 -uroot -pExpenseApp@1 < /app/schema/backend.sql
print_status $?
