headings=$1
print_heading(){
  echo $1

}

print_status(){
  if [ $? -eq 0 ]; then
      echo -e "\e[32mSuccess\e[0m"
  else
      echo -e "\[31mFailed\e[0m"
  fi

}