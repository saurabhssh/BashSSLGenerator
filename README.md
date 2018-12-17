# BashSSLGenerator
A bash shell script to generate private key, CSR &amp; Self Signed Certificates and cross validate it and various features.

Uncommment line number 175 to generate self signed certificates.

Execution Steps:

1.First Verify that 'ssls' folder exist in your HOME Directory & 'cd ssls' to move into ssls folder.Make sure you also move your script to ssls folder.

	chmod 777 sslgen.sh

	./sslgen.sh <common_Name>

  Common name is mandatory, as script wont run without it.
  Extensions like .key , .csr & .crt will be taken care by script. Please do not enter it with common name.
	eg: ./sslgen.sh matrix.test.sabre.com 
	
 It uses HOME Variable for path validation.
 For eg, my HOME variable is set to location "/home/saurabh" my present working directory should be "/home/saurabh/ssls" before execution. 
	
2. Next, the script will check for three main folders i.e. ssl.key,ssl.csr & ssl.crt, if these 3 folders do not exist script 
   will create them  for you in background. 
   It will provide you "options" in never ending loop untill you hit exit option. '

3. For generating the self signed certificate just uncomment the line below the sentence: "#Manual command for generating CERTIFICATE"
