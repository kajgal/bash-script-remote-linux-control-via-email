#!/bin/bash
VALIDMAIL="XXX"
while true
do
	# pobranie mailow z poczty
	getmail &> /dev/null
	# przejscie do folderu z mailami (MIME)
	cd ~/pathABC
	# konwercja MIME na czytelny format, stworzenie pliku _headers_ z ktorego zostanie wyabstrahowany mail
	ripmime -i * -e
	cat textfile0 &> /dev/null
	if [ $? -eq 0 ]; then
		grep From:  _headers_ > nadawca
		cat nadawca | awk -F "[<>]" '{print $2}' > mail_nadawcy.txt
		read email_nadawcy < mail_nadawcy.txt
		if [ $email_nadawcy = $VALIDMAIL ]; then
			echo '#!/bin/bash' >> merged.sh
			cat textfile[:13579] >> merged.sh
			cp merged.sh /home/kajetan
			rm *
			cd
			bash merged.sh &> rezultat.txt
			mail -s "Executed via E-mail" $email_nadawcy < rezultat.txt
		else	
			cat textfile[:13579] >> notAuthorized.txt
			cp notAuthorized.txt /home/kajetan
			rm *
			cd
			mail -s "Not authorized try to execute command" $VALIDMAIL < notAuthorized.txt 

		fi
	fi
done

# wersja cronowa, wersja cicha
