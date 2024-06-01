#!/bin/bash

# 인수가 3개가 아닐 경우 종료 코드로 프로그램 끝낸다.
if [ $# -ne 3 ]; then
  echo "입력값 오류"
  exit 1
fi

# 월(month)을 대문자로 변환할 것: may -> May
# 월은 다음의 형태가 모두 가능할 것: feb / february / 2 => Feb

case $1 in

  jan|january|1) month="Jan" ;;

  feb|february|2) month="Feb" ;;

  mar|march|3) month="Mar" ;;

  apr|april|4) month="Apr" ;;
    
  may|5) month="May" ;;
    
  jun|june|6) month="Jun" ;;
    
  jul|july|7) month="Jul" ;;
    
  aug|august|8) month="Aug" ;;
    
  sep|september|9) month="Sep" ;;
    
  oct|october|10) month="Oct" ;;
    
  nov|november|11) month="Nov" ;;
    
  dec|december|12) month="Dec" ;;

# 월(month)의 형식과 범위가 유효한지 확인한다.
  *)
  if [[ $1 =~ ^[0-9]+$ ]]; then
  echo "월(month) 범위 오류 $1는 유효하지 않습니다." 
  else
  echo "월(month) 문자 오류 $1는 유효하지 않습니다."
  fi
  exit 1 
  ;;

esac

#윤년인지 판별할 것:
#4로 나뉘지 않으면 윤년이 아니다.
#4로 나뉘고 400으로 나뉘면 윤년이다.
#4로 나뉘지만 400으로 나뉘지 않을 경우, 100으로 나뉘면 윤년이 아니다. 
#그외 4로 나뉘면 윤년이다.

if [ $(($3 % 4)) -eq 0 ] && [ $(($3 % 400)) -eq 0 ] || [ $(($3 % 100)) -ne 0 ]; then
  leap_year=0
else 
  leap_year=1
fi

#각 달의 일(date) 수를 설정한다. 윤년일 경우, 2월은 29일까지 존재한다.

case $month in

  Jan|Mar|May|Jul|Aug|Oct|Dec) day_max=31 ;;
  
  Apr|Jun|Sep|Nov) day_max=30 ;;

  Feb) 
  if [ $leap_year -eq 0 ]; then
    day_max=29 
  else
    day_max=28
  fi
  ;;

esac

# 유효한 날짜인지 확인한다.

#년(year)의 형식이 유효한지 확인한다.
if [[ ! $3 =~ ^[0-9]+$ ]]; then
echo "년(year) 형식 오류 $3는 유효하지 않습니다."
exit 1
fi

#날(day)의 형식이 유효한지 확인한다.
if [[ ! $2 =~ ^[0-9]+$ ]]; then
echo "날(day) 형식 오류 $2는 유효하지 않습니다."
exit 1
fi

#날(day)의 범위가 유효한지 확인한다. 
if [ $2 -ge 1 ] && [ $2 -le $day_max ]; then
  echo "$month $2 $3"
else
  echo "날(day) 범위 오류 $2는 유효하지 않습니다."
  exit 1
fi
  


  
  



  
  


