#!/bin/bash

#인수 개수 확인
if [ $# -ne 1 ]; then
  echo "입력오류"
  exit 1
fi

user=$( who | grep -w $1 )
until $user
do
  echo "$1 로그인 안됨!"
  sleep 60
done

echo "$1 로그인 함!"



