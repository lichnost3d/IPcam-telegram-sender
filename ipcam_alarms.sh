#!/bin/bash

TARGET=/var/ftp_1c/ip_cam
BotToken=XXXXXXX:XXXXXXXXXXXXXXXX
chatid=XXXXXXXXXXX
chatid2=XXXXXXXXXX

inotifywait -m -r -e create -e moved_to --format "%w%f" $TARGET \
        | while read FILE
                do
                sendedFile="$FILE"
                read -t 1 -p "timeout 1 sec"
                fName="$(basename $sendedFile)"
                findedAi="/var/ftp_1c/"
                findedAi+=$fName
                echo "-----finded AI------"
                echo "$findedAi"
                cd /opt/darknet/darknet
                #/opt/darknet/darknet/darknet detect /opt/darknet/darknet/cfg/yolov3.cfg /opt/darknet/darknet/yolov3.weights $sendedFile -out $findedAi > /var/ftp_1c/find.txt
                /opt/darknet/darknet/darknet detect /opt/darknet/darknet/cfg/yolov3-tiny.cfg /opt/darknet/darknet/yolov3.weights $sendedFile -out $findedAi > /var/ftp_1c/find.txt
                findedAi+=".jpg"
                if grep "person" /var/ftp_1c/find.txt; then
                    curl -s -X POST -H "Content-Type:multipart/form-data" -F chat_id=""$chatid"" -F photo=@\"$sendedFile\" https://api.telegram.org/bot"$BotToken"/sendPhoto
                    curl -s -X POST -H "Content-Type:multipart/form-data" -F chat_id=""$chatid2"" -F photo=@\"$sendedFile\" https://api.telegram.org/bot"$BotToken"/sendPhoto
                else
                    echo "humans not find"
                fi
                rm $sendedFile
                echo "----remove finded AI----"
                echo "$findedAi"
                rm $findedAi
                done
