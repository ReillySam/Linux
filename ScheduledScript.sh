### THIS IS MY SCHEDULED DAILY TASK SCRIPT, Scripts2.sh
#AGAIN INDENTATION DID NOT COPY OVER, PLS CHECK TUTORIAL

#! /bin/bash
#Script for scheduled daily tasks (backup/transfer)

#User details
name=$(whoami)
uid=$(id -u)
time=$(date)


#BACK UP ---------------------
#Locking permissions for backup
sudo chmod -R 555 /var/www/html/Intranet/

#Sync Intranet to a backup
echo "Details of daily backup; $name-$uid-$time" >> /home/ubuntus1/Documents/Reports/AuditLog.txt

sudo rsync -aP /var/www/html/Intranet/ /home/ubuntus1/Documents/BackUp/"$time-IntraBackUp".txt >> /home/ubuntus1/Documents/Reports/AuditLog.txt

sudo ausearch -f /var/www/html/Intranet/ | aureport -f -i >> /home/ubuntus1/Documents/Reports/AuditLog.txt

#Unlocking permissions after backup is done
sudo chmod -R 774 /var/www/html/Intranet/



#TRANSFER ---------------------
#Locking permissions for transfer
sudo chmod -R 555 /var/www/html/Intranet/

#Sync Intranet to Live site
echo "Details of daily transfer to live; - $name-$uid-$time" >> /home/ubuntus1/Documents/Reports/AuditLog.txt

sudo rsync -zaP /var/www/html/Intranet/ /var/www/html/Live/ >> /home/ubuntus1/Documents/Reports/AuditLog.txt

sudo ausearch -f /var/www/html/Intranet/ | aureport -f -i >> /home/ubuntus1/Documents/Reports/AuditLog.txt

#Unlocking permissions after transfer is done
sudo chmod -R 774 /var/www/html/Intranet/


#rsync and its options (-aP) sync all contents from Intranet to the backup directory, the -a is an archive, enusure no duplication and also recursive setting.
#This means only updated/new content will be synced. 
#The P is to retrieve the systems progress on doing this task.

#rsync options -zaP have the same settings as above but the added -z option here compresses the file providing extra space for transfer and on the server. 
#This is requested as files can be 5000+ on the live sit
