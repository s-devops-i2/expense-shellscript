headings=$1
print_heading(){
  echo $1

}

print_status(){
  if [ $? -eq 0 ]; then
      echo -e "\[32mSuccess\[0m"
  else
      echo -e "\[31mFailed\[0m"
  fi

}