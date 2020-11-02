certdate=`
echo                                                        | \
openssl s_client -servername $1 -connect $1:443 2>/dev/null | \
openssl x509 -noout -dates                                  | \
tail -n 1                                                   | \
cut -d= -f2`
certsec=`date +%s -d "$certdate"`
nowsec=`date +%s`
days=`echo "($certsec-$nowsec) / ( 60*60*24 )" | bc`

echo "$1: $days"

if [ ! -n "$2" ]; then
	echo done
	exit 0
fi

echo -n "Lasts longer then $2 days? "

if (($days>$2)); then
	echo Yes.
else
	echo NO!!!!!!!!!!!!!!
	exit 1
fi
