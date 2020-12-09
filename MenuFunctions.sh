#### THIS IS MY SHELL SCRIPT THAT PERFORMS THE FUCNTIONS AND MENU OPERATIONS OF THE APPLICATION
#THE INDENTATION DID NOT COPY OVER, YOU CAN SEE I HAVE ITS THERE IN THE TUTORIAL VIDEO
#myScript.sh


#! /bin/bash

#User details
name=$(whoami)
uid=$(id -u)
time=$(date)


#Functions to run menu options

#Option 1, edit a file ---------------------
editFile(){
	echo "Running Edit File"
	echo "Press 'j' for Javascript or 'c' for CSS"
	read key

if [ "$key" == "c" ]; then
	echo "CSS File"
	sudo echo "$name (id:$uid) opened CSS file to edit at $time" >> /home/sam/Documents/Reports/AuditLog.txt
	sudo vim /var/www/html/Intranet/MainCSS.css

elif [ "$key" == "j" ]; then
	echo "Javascript File"
	sudo echo "$name (id:$uid) opened Javascript file to edit at $time" >> /home/sam/Documents/Reports/AuditLog.txt
	sudo vim /var/www/html/Intranet/Java.js

else
	echo "Invalid, try a suggested letter"

fi
}



#Option 2, view Javascript file ---------------------
javaFile(){
	echo "Running Java.js"
	echo "Sales file"
	sudo echo "$name (id:$uid) opened Javascript file at $time" >> /home/sam/Documents/Reports/AuditLog.txt
	sudo nl /var/www/html/Intranet/Java.js
}



#Option 3, view CSS file ---------------------
cssFile(){
	echo "Running CSS file"
	echo "Inventory file"
	sudo echo "$name (id:$uid) opened CSS file at $time" >> /home/sam/Documents/Reports/AuditLog.txt
	sudo nl /var/www/html/Intranet/MainCSS.css
}



#Option 4, view logs ---------------------
logFile(){
	echo "Running Audit Log"
	echo "Audit Log"
	sudo ausearch -f /var/www/html/Intranet/ | aureport -f -i >> /home/sam/Documents/Reports/AuditLog.txt
	sudo ausearch -f /var/www/html/Intranet/ | aureport -f -i >> /home/sam/Documents/Reports/ManualLog.txt
	sudo nl /home/sam/Documents/Reports/AuditLog.txt
	sudo nl /home/sam/Documents/Reports/ManualLog.txt
}



#Option 5, generate system health check ---------------------
systemCheck(){
	echo "Running System Check"
	sudo echo "$name (id:$uid) checked the Systems Health at $time" >> /home/sam/Documents/Reports/AuditLog.txt
	echo "----- System Health at $time -----"
	echo "----- Systems name and description -----"
	sudo uname -a
	echo "----- Memory Information at $time -----"
	sudo cat /proc/meminfo
	echo "----- Systems preformance at $time-----"
	sudo vmstat
}



#Option 6, perform manual backup/transfer ---------------------
manualTasks(){
	echo "Press 'b' for Backup or 't' for Transfer"
	read key

if [ "$key" == "b" ]; then
	sudo chmod -R 555  /var/www/html/Intranet/
	sudo echo "Manual Backup performed by $name ($uid) at $time" >> /home/sam/Documents/Reports/ManualLog.txt
	sudo echo "Manual Backup performed by $name ($uid) at $time" >> /home/sam/Documents/Reports/AuditLog.txt
	sudo rsync -aP --delete /var/www/html/Intranet/ /home/sam/Documents/BackUp/"$time-IntraBackUp".txt >> /home/sam/Documents/Reports/Manual.txt
	sudo chmod -R 777  /var/www/html/Intranet/

elif [ "$key" == "t" ]; then
	sudo chmod -R 555  /var/www/html/Intranet/
	sudo echo "Manual Transfer of Intranet to Live site performed by $name ($uid) at $time" >> /home/sam/Documents/Reports/ManualLog.txt
	sudo echo "Manual Transfer of Intranet to Live site performed by $name ($uid) at $time" >> /home/sam/Documents/Reports/AuditLog.txt
	sudo rsync -zaP --delete /var/www/html/Intranet/ /var/www/html/Live/ >> /home/sam/Documents/Reports/ManualLog.txt
	sudo chmod -R 777  /var/www/html/Intranet/

else
	echo "Invalid, use a suggested letter"

fi
}



#Option 7, view backup/trasnfer schedlue ---------------------
scheduledTasks(){
	echo "Running Backup / Transfer Schedule"
	sudo crontab -l
}



#Function to clear and refresh screen ---------------------
clearScreen(){
	clear
}


#User menu and user input ---------------------
USER_INPUT=""

while [ "$USER_INPUT" != "quit" ]
	do
	clearScreen
	echo "Hi $name ($uid)! Please select an option:"
	echo  "---------------------------"
	echo "1)Edit a file"
	echo "2)View the Javascript file"
	echo "3)View the CSS file"
	echo "4)View Logs"
	echo "5)View the health of the system"
	echo "6)Perform Manual Backup/Transfer"
	echo "7)View the schedule for daily tasks"

	echo "Type 'quit' to exit!"


	read USER_INPUT
	case $USER_INPUT in
	1) editFile;;
	2) javaFile;;
	3) cssFile;;
	4) logFile;;
	5) systemCheck;;
	6) manualTasks;;
	7) scheduledTasks;;

	esac
	echo "Press any key to continue"
	read key

done
