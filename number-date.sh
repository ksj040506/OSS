#!/bin/bash

# 잘못된 입력값 판별하기

# 인수는 2개 전달되어야 함. 종료 코드 설정할 것
if [ $# -ne 2 ] ; then
  echo "인수 개수 오류"
  exit 1
fi

# 번호가 숫자일 경우만 실행한다.
# 전화번호는 하이픈(-)으로 연결해서 저장한다.
if [[ ! $2 =~ ^[0-9]{2,3}-[0-9]{4}-[0-9]{4}$ ]] ; then
  echo "입력 형식 오류"
  exit 1
fi

# 지역번호 구현하기

#지역번호는 자유롭게 구현하되 최소 5개 있을 것
local_number=$(cut -d "-" -f1 <<< $2)

case $local_number in

  02) region="서울" ;;

  031) region="경기" ;;

  032) region="인천" ;;

  051) region="부산" ;;

  053) region="대전" ;;

  *) ;;
  
esac

# 전화번호를 저장할 때 지역번호에 따라 "이름 전화번호 지역" 으로 저장한다.

#예: 홍길동 02-2222-2222 서울
full_number="$1 $2 $region"
echo "$full_number"

# 전화번호부가 없다면 만든다.
if [ ! -e number.txt ] ; then
  touch number.txt
fi

# 검색

# 입력된 이름으로 전화번호부를 검색한다.
search=$(grep -w "$1" number.txt)

# 존재하면 전화번호 비교한다. 동일하면 메시지 프린트하고 프로그램 종료
if [ -n "$search" ] ; then
  IFS=' ' 
  while read -r line ; 
  do
    stored_number=$(echo "$line" | cut -d " " -f2)
    if [ "$2" = "$stored_number" ] ; then
      echo "전화번호가 기존에 존재합니다."
      exit 0
    fi 
  done <<< "$search"
fi

# 다르면 새로운 전화번호로 추가하고 이름순으로 정렬한다.
echo "$full_number" >> number.txt
sort -o number.txt number.txt
echo "새 전화번호가 추가되었습니다."
exit 0


  

