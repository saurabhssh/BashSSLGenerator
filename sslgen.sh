#do not uncomment any line
# MAIL To saurabhrocker28@gmail.com if the script doesnt work.

if [ -z "$1"  ] ;
then 
	echo -e "[\e[31m#\e[0m]Provide Common Name to script"
else
####Path Validation############

#if [[ "$plot" == "*.com" ]] 
#then 
	pd=$(pwd)
	if  [ "$pd" == "$HOME/ssls" ] 
	then
#echo "${a##*:}"

splot="${1##*/}" #remove content before first '/'

plot=${splot%} 
echo "Name Passed : $plot"

if [[ $plot = *".key"* ]]
then	
	plot=${splot%.key}

elif [[ $plot = *".csr"* ]]
then    
	plot=${splot%.csr}

elif [[ $plot = *".crt"* ]]
then
	plot=${splot%.crt}
fi

echo "New Name : $plot"
# To checkk if folder  exists  of not

if [ ! -d "ssl.key" ]; then
   mkdir ssl.key 
fi

if [ ! -d "ssl.csr" ]; then
   mkdir ssl.csr 
fi

if [ ! -d "ssl.crt" ]; then
   mkdir ssl.crt 
fi
a=0
while [ "$a" -lt 10 ]
do
echo -e "\n"
echo -e "\e[32m[********************* Options **********************]\e[0m"
echo -e "Taking Common Name as : \e[32m$plot\e[0m"
echo -e "\n 0.Check if Key, CSR & CERT Exist"
echo -e "\n 1.Generate Private key and CSR"
echo -e "\n 2.Validate Key, CSR & CERT"
echo -e "\n 3.Decode CSR & CERT"
echo -e "\n 4.Validate Intermediate & Server CERT"
echo -e "\n 5.Exit"
echo -e "\n"
read -p "Enter choice: " number
case "$number" in
   "0")
	cd ssl.key
	apath=$(pwd)
	if [ -f "$plot.key" ]; then
	  echo -e "\n"
 	  echo -e "[\e[32m#\e[0m]FILE :: $apath :: $plot.key \e[32mexist\e[0m" 
	else
	  echo -e "\n"
   	  echo -e "[\e[31m#\e[0m]FILE :: $apath :: $plot.key \e[31mdoesn't exist\e[0m"
	fi
	cd ..

	cd ssl.csr
	bpath=$(pwd)
	if [ -f "$plot.csr" ]; then
 	  echo -e "[\e[32m#\e[0m]FILE :: $bpath :: $plot.csr \e[32mexist\e[0m" 
	else
   	  echo -e "[\e[31m#\e[0m]FILE :: $bpath :: $plot.csr \e[31mdoesn't exist\e[0m"
	fi
	cd ..

	cd ssl.crt
	cpath=$(pwd)
	if [ -f "$plot.crt" ]; then
 	  echo -e "[\e[32m#\e[0m]FILE :: $cpath :: $plot.crt \e[32mexist\e[0m" 
	else
   	  echo -e "[\e[31m#\e[0m]FILE :: $cpath :: $plot.crt \e[31mdoesn't exist\e[0m"
	fi
	cd ..
;;

   "1") 
dlf=0
while [ "$dlf" -lt 10 ]
do
echo -e "\n"
echo -e "\e[32m[**************** Options ****************]\e[0m"
echo -e "\n 1. Normal CSR"
echo -e "\n 2. SAN CSR"
echo -e "\n 3. Exit"
echo -e "\n"
read -p "Enter choice: " founter

case "$founter" in
   
"1")
cd ssl.key

	if [ -f "$plot.key" ]
	then
		echo -e "\n"	
		echo -e "[\e[31m#\e[0m]FILE :: $plot.key \e[31malready exist\e[0m"
	else
	echo -e "\n"
	echo -e "\e[32m[*********** Generating Private KEY & CSR ***********]\e[0m"
		echo -e "\n"	 	
		read -p "Enter Passphrase: " passphrase
		read -p "Country: " b
		read -p "State/province: " c 
		read -p "City/locality: " d
		read -p "Organization: " e
		read -p "Organizational unit: " f

 	#openssl genrsa -des3 2048 > encrypted."$plot.key"
	#openssl rsa -in encrypted."$plot.key" -out "$plot.key"
	openssl genrsa -des3 -passout pass:$passphrase 2048 > encrypted."$plot.key" 
	openssl rsa -passin pass:$passphrase -in encrypted."$plot.key" -out "$plot.key" 
	echo -e "\n"	
	if [ -f "$plot.key" ]
	then
	echo -e "\e[32mPrivate Key Generated Successfully\e[0m"
	fi
	
	fi
	cd ..
	#Generate CSR using private key

if [ -f ssl.key/"$plot.key" ] #Warning msg 
	then
		
	#if [ -f ssl.key/"$plot.key" ] 
	#then
	echo -e "\e[32mKey Path \e[0m"
	ls -lhtr ssl.key/"$plot.key"
	ls -lhtr ssl.key/encrypted."$plot.key"

	cd ssl.csr
	if [ -f "$plot.csr" ]
	then
	  echo -e "\n"
	  echo -e "[\e[31m#\e[0m]FILE :: $plot.csr \e[31malready exist\e[0m"
	else

nplot=${plot#*.} #removes "wildcard" 

if [ "$plot" == "wildcard.$nplot" ]
then
newcn="*.$nplot" 		
openssl req -new -sha256 -subj "/C=$b/ST=$c/L=$d/O=$e/OU=$f/CN=$newcn" -key "../ssl.key/$plot.key" > "$plot.csr"
else
openssl req -new -sha256 -subj "/C=$b/ST=$c/L=$d/O=$e/OU=$f/CN=$plot" -key "../ssl.key/$plot.key" > "$plot.csr"
fi
	

	echo -e "\n"	
	echo -e "\e[32mCSR Generated Successfully\e[0m"
		#openssl req -new -sha256 -key ../ssl.key/"$plot.key" > "$plot.csr"
	fi
	cd ..
	
	#Manual command for generating CERTIFICATE	
#openssl x509 -signkey ssl.key/"$plot.key" -in ssl.csr/"$plot.csr" -req -days 365 -out ssl.crt/"$plot.crt"

#**************************GENERATION CONDITION*****************	

if [ -f ssl.csr/"$plot.csr" ] 
then
echo -e "\e[32mCSR Path \e[0m"
ls -lhtr ssl.csr/$plot.csr
else 
echo -e "\e[31mCSR not generated\e[0m"
fi
#*************************************************************
else
echo -e "\e[31m***********************************\e[0m"
echo -e "\e[31mWARNING::First Generate Private Key\e[0m"
echo -e "\e[31m***********************************\e[0m"
fi


	
;;

"2") #***********************SAN CSR*************************** 
cd ssl.key

	if [ -f "$plot.key" ]
	then
		echo -e "\n"	
		echo -e "[\e[31m#\e[0m]FILE :: $plot.key \e[31malready exist\e[0m"
	else
	echo -e "\n"
	echo -e "\e[32m[*********** Generating Private KEY & CSR ***********]\e[0m"
		echo -e "\n"	 	
		read -p "Enter Passphrase: " passphrase
		echo -e "\e[32mAssuming cnf config file is stored in ssls folder\e[0m"
		read -p "Enter cnf Config File Name: " sanfilename
	
	openssl genrsa -des3 -passout pass:$passphrase 2048 > encrypted."$plot.key" 
	openssl rsa -passin pass:$passphrase -in encrypted."$plot.key" -out "$plot.key" 
	echo -e "\n"	
	if [ -f "$plot.key" ]
	then
	echo -e "\e[32mPrivate Key Generated Successfully\e[0m"
	fi
	
	fi
	cd ..
	#Generate CSR using private key

if [ -f ssl.key/"$plot.key" ] #Warning msg 
	then
		
	#if [ -f ssl.key/"$plot.key" ] 
	#then
	echo -e "\e[32mKey Path \e[0m"
	ls -lhtr ssl.key/"$plot.key"
	ls -lhtr ssl.key/encrypted."$plot.key"

	cd ssl.csr
	if [ -f "$plot.csr" ]
	then
	  echo -e "\n"
	  echo -e "[\e[31m#\e[0m]FILE :: $plot.csr \e[31malready exist\e[0m"
	else
#Generate CSR
openssl req -new -sha256 -key "../ssl.key/$plot.key" > "$plot.csr" -config ../"$sanfilename"
	
	echo -e "\n"	
	echo -e "\e[32mCSR Generated Successfully\e[0m"
	
	fi
	cd ..
	
	

#**************************GENERATION CONDITION*****************	

if [ -f ssl.csr/"$plot.csr" ] 
then
echo -e "\e[32mCSR Path \e[0m"
ls -lhtr ssl.csr/$plot.csr
else 
echo -e "\e[31mCSR not generated\e[0m"
fi
#*************************************************************
else
echo -e "\e[31m***********************************\e[0m"
echo -e "\e[31mWARNING::First Generate Private Key\e[0m"
echo -e "\e[31m***********************************\e[0m"
fi



	
;;

"3")
break	
;;

esac #
done #



;; #1 end
			
   "2") #validation


#****************************KEY and CSR**********************
cd ssl.key
if [ -f "$plot.key" ]
then
 wes1=$(openssl rsa -noout -modulus -in "$plot.key" | openssl md5)
 echo -e "\n"
 echo "KEY = $wes1"
else
 echo -e "$plot.key \e[31mnot found\e[0m"
fi

cd ..

cd ssl.csr

if [ -f "$plot.csr" ]
then
 wes2=$(openssl req -noout -modulus -in "$plot.csr" | openssl md5) 
 echo "CSR = $wes2"
else
 echo -e "$plot.csr \e[31mnot found\e[0m"
fi

cd ..

#**********Matching*************

if [ -z "$wes1" ] || [ -z "$wes2"  ];
then
 echo -e "Private Key and CSR \e[31mdoesn't match\e[0m"

elif [ "$wes1" == "$wes2" ]; 
then
echo -e "Private Key and CSR \e[32mmatched SUCCESSFULLY\e[0m"
			
fi

#****************************  cert and key   **********************************
cd ssl.key
if [ -f "$plot.key" ]
then
 res1=$(openssl rsa -noout -modulus -in "$plot.key" | openssl md5)
 echo -e "\nKEY = $res1"
else
 echo -e "\n$plot.key \e[31mnot found\e[0m"
fi

cd ..

cd ssl.crt

if [ -f "$plot.crt" ]
then 
 res2=$(openssl x509 -noout -modulus -in "$plot.crt" | openssl md5)
 echo "CERT = $res2"
else
 echo -e "$plot.crt \e[31mnot found\e[0m"
fi

cd ..

#**********Matching*************

if [ -z "$res1" ] || [ -z "$res2"  ];
then
echo -e "Private Key and Cert \e[31mdoesn't match\e[0m"

elif [ "$res1" == "$res2" ]; 
then
echo -e "Private Key and Cert \e[32mmatched SUCCESSFULLY\e[0m"
			
fi

#****************************** cert and csr************************

cd ssl.csr
if [ -f "$plot.csr" ]
then
 tes2=$(openssl req -noout -modulus -in "$plot.csr" | openssl md5)
 echo -e "\nCSR = $tes2"
else
 echo -e "\n$plot.csr \e[31mnot found\e[0m"
fi

cd ..

cd ssl.crt

if [ -f "$plot.crt" ]
then 
 tes1=$(openssl x509 -noout -modulus -in "$plot.crt" | openssl md5)
 echo "CERT = $tes1"
else
 echo -e "$plot.crt \e[31mnot found\e[0m"
fi

cd ..
#**********Matching*************

if [ -z "$tes1" ] || [ -z "$tes2"  ];
then
echo -e "CSR and a Cert \e[31mdoesn't match\e[0m"
	

elif [ "$tes1" == "$tes2" ]; 
then
echo -e "CSR and a Cert \e[32mmatched SUCCESSFULLY\e[0m"

fi

;;


"3") #*****************Decode CSR****************

if [ -f ssl.csr/"$plot.csr"  ]
then 
deco=$(openssl req -in ssl.csr/"$plot.csr" -noout -text | grep -w "Subject:")	
deco1=$(openssl req -in ssl.csr/"$plot.csr" -noout -text | grep -w "Signature Algorithm:")
deco2=$(openssl req -in ssl.csr/"$plot.csr" -noout -text | grep -w "Public Key Algorithm:")
deco3=$(openssl req -in ssl.csr/"$plot.csr" -noout -text | grep -w "Public-Key:")

deco4=$(openssl req -in ssl.csr/"$plot.csr" -noout -text | grep -e "DNS:")

echo -e "\n"
echo -e "\e[32m[******************* Decoded CSR ********************]\e[0m"
echo -e "\n"
echo -e "\e[32m[1]\e[0m"$deco3 
echo -e "\n"
echo -e "\e[32m[2]\e[0m"$deco1 
echo -e "\n"
echo -e "\e[32m[3]\e[0m"$deco2 
echo -e "\n"
echo -e "\e[32m[4]\e[0m"$deco
echo -e "\n"
if [ -z "$deco4" ] 
then
    echo ""
else
echo -e "\e[32m[5]\e[0m"$deco4
fi

else
echo -e "\e[31m$plot.csr not found\e[0m"
fi

#***************Decode CERT******************

if [ -f ssl.crt/"$plot.crt" ] 
then
#crd=$(openssl x509 -in ssl.crt/"$plot.crt" -text -noout)
crd=$(openssl x509 -in ssl.crt/"$plot.crt" -text -noout | grep -w "Subject:")	
crd1=$(openssl x509 -in ssl.crt/"$plot.crt" -text -noout | grep -m 1 -w "Signature Algorithm:")
crd2=$(openssl x509 -in ssl.crt/"$plot.crt" -text -noout | grep -w "Public Key Algorithm:")
crd3=$(openssl x509 -in ssl.crt/"$plot.crt" -text -noout | grep -w "Issuer:")
crd4=$(openssl x509 -in ssl.crt/"$plot.crt" -text -noout | grep -w "Not Before:")
crd5=$(openssl x509 -in ssl.crt/"$plot.crt" -text -noout | grep -w "Not After :")
crd6=$(openssl x509 -in ssl.crt/"$plot.crt" -text -noout | grep -e "DNS:")

echo -e "\n"
echo -e "\e[32m[******************* Decoded CERT ********************]\e[0m"
echo -e "\n"
echo -e "\e[32m[1]\e[0m"$crd
echo -e "\n"
echo -e "\e[32m[2]\e[0m Subject Alternative Name:"$crd6 
echo -e "\n"
echo -e "\e[32m[3]\e[0m"$crd1 
echo -e "\n"
echo -e "\e[32m[4]\e[0m"$crd2 
echo -e "\n"
echo -e "\e[32m[5]\e[0m"$crd3
echo -e "\n"
echo -e "\e[32m[6]\e[0m"$crd4
echo -e "\n"
echo -e "\e[32m[7]\e[0m"$crd5
 	

else 
echo -e "\n"
echo -e "\n"
echo -e "\e[31m$plot.crt not found\e[0m"	
fi

;; 



   "4")
lp=0
while [ "$lp" -lt 10 ]
do
echo -e "\n"
echo -e "\e[32m[*********** Validating Intermediate Cert ***********]\e[0m"
echo -e "\n 1. GS - SHA2"
echo -e "\n 2. GS - FUll SHA2"
echo -e "\n 3. 3'rd Party"
echo -e "\n 4. Exit"
echo -e "\n"
read -p "Enter choice: " counter

case "$counter" in
   
"1")
#read -p "Enter Server Cert Name[$HOME/ssls/ssl.crt]: " fver	
if [ -f ssl.crt/"$plot.crt" ]
then 
 gen=$(openssl verify -verbose -purpose sslserver -CAfile ssl.crt/gs-intermediate-root-bundle-2018.crt ssl.crt/"$plot.crt")
	
if [ "$gen" == "ssl.crt/$plot.crt: OK" ]
then 
echo -e "\n"
echo -e "\e[32mMatched Successfully\e[0m   "
echo $gen
else
echo -e "\n"
echo -e "\e[31mDoesn't Match\e[0m"
fi

else
 echo -e "\n"
 echo -e "$plot.crt \e[31mnot found\e[0m"
fi	
;;

"2") 
#read -p "Enter Server Cert Name[$HOME/ssls/ssl.crt]: " sver	
if [ -f ssl.crt/"$plot.crt" ]
then 
 gen1=$(openssl verify -verbose -purpose sslserver -CAfile ssl.crt/gs-intermediate-root-full-sha256-bundle-2018.crt ssl.crt/"$plot.crt")

if [ "$gen1" == "ssl.crt/$plot.crt: OK" ]
then
echo -e "\n" 
echo -e "\e[32mMatched Successfully\e[0m   "
echo $gen1
else
echo -e "\n"
echo -e "\e[31mDoesn't Match\e[0m"
fi

else
 echo -e "\n" 
 echo -e "$plot.crt \e[31mnot found\e[0m"
fi	
;;

"3")

kpi=0
while [ "$kpi" -lt 10 ]
do
echo -e "\n"
echo -e "\e[32m[**************** Options ****************]\e[0m"
echo -e "\e[32mAssuming that all CERT's are in ssl.crt folder\e[0m"
echo -e "\n 1. Intermediate bundle"
echo -e "\n 2. Seperate Intermediate & Root"
echo -e "\n 3. Exit"
echo -e "\n"
read -p "Enter choice: " founter

case "$founter" in
   

"1")

read -p "Intermediate Cert Fullname:" inter
if [ -f ssl.crt/"$plot.crt" ]
then
pen2=$(openssl verify -verbose -purpose sslserver -CAfile ssl.crt/$inter ssl.crt/"$plot.crt")
if [ "$pen2" == "ssl.crt/$plot.crt: OK" ]
then
	echo -e "\n"
	echo -e "\e[32mMatched Successfully\e[0m"
	echo $pen2
else
echo -e "\e[31mDoesn't Match\e[0m"
fi	

else
echo -e "\e[31mSome File Missing\e[0"
fi
;;

"2") 
#assuming the we kept server, root and intermediate in ssl.crt folder
read -p "Intermediate Cert FullName[/ssl.crt]: " inter
read -p "Root Cert FullName[/ssl.crt]: " roots

if [ -f ssl.crt/"$plot.crt" ]
then
gen2=$(openssl verify -verbose -purpose sslserver -CAfile <(cat ssl.crt/$roots ssl.crt/$inter) ssl.crt/"$plot.crt")

	if [ "$gen2" == "ssl.crt/$plot.crt: OK" ]
	then 
	echo -e "\n"
	echo -e "\e[32mMatched Successfully\e[0m"
	echo $gen2
	
	else 
	echo -e "\e[31mDoesn't Match\e[0m"
	fi	

else
echo -e "\e[31mSome File Missing\e[0"
fi
;;	

"3")
break
;;

esac #
done #
;;


"4")
break	
;;
esac #
done #
;; 

"5") 
	exit
;; 
esac
done
#####################PATH VALIDATION#########################
else
  echo -e " Path is different, Move this script to \e[32m$HOME/ssls\e[0m folder "
fi 

#else # extensionchek 
#	echo "Provide .com extension"
#fi 
fi #nullcheck

