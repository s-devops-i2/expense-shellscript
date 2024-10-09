LOG=/tmp/data.log
print_heading(){
  echo $1

}

print_status(){
  if [ $? -eq 0 ]; then
      echo -e "\e[32mSuccess\e[0m"
  else
      echo -e "\e[31mFailed\e[0m"
      exit 2
  fi
}

App_PreReq() {
  Print_heading "Clean the Old Content"
  rm -rf ${app_dir} &>>$LOG
  Check_Status $?

  Print_heading "Create App Directory"
  mkdir ${app_dir} &>>$LOG
  Check_Status $?

  Print_heading "Download App Content"
  curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/expense-${component}-v2.zip &>>$LOG
  Check_Status $?

  Print_heading "Extract App Content"
  cd ${app_dir} &>>$LOG
  unzip /tmp/${component}.zip &>>$LOG
  Check_Status $?
}