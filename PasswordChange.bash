#!/bin/bash
#This script was written to change password accounts for in a configuration file
#
Account=Test
TIMESTAMP=`date +%Y%m%d%H%M%s`
LOGFILE=/log/$Account/log
Home=/root

# $1: Parameter file
# $2: LoginID
# $3: Old PW
# $4: New PW
# $5: IP Addr
ChangePW( )	{
	if [ -s "$1" ]; then
		cp "$1" "${1}.${TIMESTAMP}"
		echo "`date +%Y%m%d%H%M%s`	$1 is found. Making the change.." >> $LOGFILE

		grep LOGIN $1 | grep $2 | grep $5
		if [ $? -ne 0 ]; then
		echo "`date +%Y%m%d%H%M%s` Alert: ID as $2 and/or IPAdress as $5 is not present in the file $1. Exiting.."
		echo "`date +%Y%m%d%H%M%s` Alert: ID as $2 and/or IPAdress as $5 is not present in the file $1. Exiting.." >> $LOGFILE
		return 4
	else 
		echo "`date +%Y%m%d%H%M%s`	$1 is empty or absent. >> $LOGFILE

	return 5
		fi
	sed -i "s/$3/$4/g" $1 

}	

cd ${HOME}/etc
for ETCDIR in LOG
do
	for APPDIR in `ls ${HOME}/etc/${ETCDIR}`
	 do 
		 change=${HOME}/etc/${ETCDIR}/${APPDIR}/config${APPDIR}
		 if [ -s $change ]; then
			 echo "Found: $change"
		 elif [ -f $change ]; then
			 echo "Alert: $change is empty but not expected"
		 else 
			 echo "Alert: $change is expected but absent" 
			 continue
	fi

	PWSPACE="`grep '^PW=' $change`"
	ChangePW $change ABC123 "$PWSPACE" "PW='abc123'"
	echo "Changing the password of the account ABC123" >> $LOGFILE
	echo " "
	done
done



	
