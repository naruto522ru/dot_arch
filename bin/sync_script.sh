#!/usr/bin/env bash

PATH_DOWNLOAD=./
USER_AGENT="curl/8.10.1"

# json status mirrors
NAME_SCRIPT=json
URL=https://archlinux.org/mirrors/status
if [[ $(curl -x http://"$SUPER_SECRET1":"$SUPER_SECRET2" -U "$SUPER_SECRET3":"$SUPER_SECRET4" -is -H "$USER_AGENT" -4s --max-time 90 --retry-delay 3 --retry 5 ${URL}/${NAME_SCRIPT}/ | head -n 2 | grep -i HTTP | awk '{print $2}') == 200 ]]; then
    echo "Скрипт ${NAME_SCRIPT} доступен. Скачиваем его на GitHub!"
    curl -x http://"$SUPER_SECRET1":"$SUPER_SECRET2" -U "$SUPER_SECRET3":"$SUPER_SECRET4" -H "$USER_AGENT" -4s --max-time 90 --retry-delay 3 --retry 5 ${URL}/${NAME_SCRIPT}/ > ${PATH_DOWNLOAD}/${NAME_SCRIPT}
else
    echo "$(date +"%d.%m.%y %H:%M:%S"): Скрипт ${NAME_SCRIPT} недоступен. Не скачиваем его на GitHub,оставляем старый\!"
fi
# Условие проверяет не пуст ли сам файл. Дело в том, что файл может существовать на удаленном сервере, но может быть пустым от такого первое if не спасает. Если такой будет, то делаем git restore , чтобы не закоммить в git пустой файл.
if [[ -s ${PATH_DOWNLOAD}${NAME_SCRIPT} ]]; then echo "No empty $NAME_SCRIPT" && cat ${PATH_DOWNLOAD}${NAME_SCRIPT} > ${NAME_SCRIPT}_jq;else echo -e "\e[1;33mEmpty\033[0m $NAME_SCRIPT" && git restore ./$NAME_SCRIPT; fi
exit 0
