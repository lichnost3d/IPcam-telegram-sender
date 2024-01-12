# IPcam-telegram-sender
service for automatically sending photos from IP cameras to telegram
logic of the service:
The IP camera sends the photo to the FTP server based on movement, our service is triggered on the server and starts a neural network search for people in the photo, if there are people, the photo is sent via a telegram bot

required for the service to work:
ftp server (proftpd), inotify-tools, darknet YOLOv4
1) Install inotify-tools 
2) Install proftpd
3) Install darknet YOLOv4
4) Set up an FTP server and create a folder to receive photos from cameras into it (example /var/ftp_1c)
5) We configure the cameras to send photos to the FTP server based on movement in the frame
6) We write in the ipcam_alarms.sh file the token of our telegram bot, as well as the darknet installation path and the path to the folder (example /var/ftp_1c)
7) Copy file ipcam_alarms.sh into /usr/local/bin
8) Copy file ipcam-alarms.service into /etc/systemd/system
9) Activate service "systemctl enable ipcam-alarms" and start service "systemctl start ipcam-alarms"
