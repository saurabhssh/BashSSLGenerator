#Beware of indentation, do not put space in it
import os
import argparse
import sys

argdatalen = len(sys.argv)
try :
 if argdatalen == 2:
        argdata = sys.argv[1]
        print argdata
        cname=argdata 
	hv = os.popen("echo $HOME")
	hv1 = hv.readline()
	hv.close()
	hv2= " ".join(hv1.split())

	homepath = hv2

	#argdatalen = len(sys.argv)
	#try :
	# if argdatalen == 2:
	#  argdata = sys.argv[1]
	# else:
	#  print "Please Provide Common Name"
	#except:
	# pass



	#cname = raw_input("Hey, what's the Common name?\n")
	class bcolors:
	     HEADER = '\033[95m'
	     OKBLUE = '\033[94m'
	     OKGREEN = '\033[92m'
	     WARNING = '\033[93m'
	     FAIL = '\033[91m'
	     ENDC = '\033[0m'
	     BOLD = '\033[1m'
	     UNDERLINE = '\033[4m'


	def main():
	    
	    

	#print bcolors.OKGREEN + "Warning: No active frommets remain. Continue?"+ bcolors.ENDC
	    language = 0

	   # intro()
	    menu()

	    language = input("\nEnter Choice: ")
	    print language

	    if language == 1:
		check_Data()
	    elif language == 2:
		gen_key_csr()
	    elif language == 3:
		validateData()
	    elif language == 4:
		decodeData()
	    elif language == 5:    
		validateIntemediate()
	    elif language == 6:
		exit()
		exit
	
	    else: #validate selection
		print("That is not a valid selection, please type the correct number\n")
		main() #call the main and start the loop again
	    while language == 5:
	       break #exits out of the program
	    else:
	   	     replayMenu()
	    

	#def intro():
	#    print("Welcome to my SSL Generator Program!\n")
	    

	def menu():
	    
	    
	#    print("[********************* Options **********************]")
	    print bcolors.OKGREEN + "[********************* Options **********************]"+ bcolors.ENDC 
	    print("\nTaking Common Name as : %s" % (cname))
	    print("\n1. Check if Key, CSR & CERT Exist")
	    print("\n2. Generate Private key and CSR")
	    print("\n3. Validate Key, CSR & CERT")
	    print("\n4. Decode CSR & CERT")
	    print("\n5. Validate Intermediate & Server CERT")
	    print("\n6. Exit")


	def replayMenu():
		main()

	def check_Data():
	  
	    PATH = "%s/ssls/ssl.key/%s.key" % (homepath,cname)    #need to change path
	    PATH1 = "%s/ssls/ssl.csr/%s.csr" % (homepath,cname)
	    PATH2 = "%s/ssls/ssl.crt/%s.crt" % (homepath,cname)

	    #keycheck
	    if os.path.isfile(PATH):
	     print bcolors.OKGREEN + "File :: %s.key exists" % (cname) + bcolors.ENDC
	    else:
	     print bcolors.FAIL + "File :: %s.key doesn't exists" % (cname) + bcolors.ENDC

	    #csr check
	    if os.path.isfile(PATH1):
	     print bcolors.OKGREEN + "File :: %s.csr exists" % (cname) + bcolors.ENDC
	    else:
	     print bcolors.FAIL + "File :: %s.csr doesn't exists" % (cname) + bcolors.ENDC

	    #cert check
	    if os.path.isfile(PATH2):
	     print bcolors.OKGREEN + "File :: %s.crt exists" % (cname) + bcolors.ENDC
	    else:
	     print bcolors.FAIL + "File :: %s.crt doesn't exists" % (cname) + bcolors.ENDC

	       
	def gen_key_csr():
	    #if 
	    print("Generating key")
	    APATH = "%s/ssls/ssl.key/%s.key" % (homepath,cname)    #need to change path
	    PATH1 = "%s/ssls/ssl.csr/%s.csr" % (homepath,cname)

	    if os.path.isfile(APATH):
	     print bcolors.FAIL + "Key with name %s already exists" % (cname) + bcolors.ENDC
	    elif os.path.isfile(PATH1):    
	      print bcolors.FAIL + "CSR with name %s already exists" % (cname) + bcolors.ENDC
	    else:    
	     pprase = raw_input("Hey, what's the Passphrase?\n")
	    #gen key
	     os.system("openssl genrsa -des3 -passout pass:'%s' 2048 > ssl.key/encrypted.'%s'.key" %(pprase,cname))

	     kname = cname
	     os.system("openssl rsa -passin pass:'%s' -in ssl.key/encrypted.'%s'.key -out ssl.key/'%s'.key" %(pprase,cname,kname))
	     csname = cname
	    #gen csr
	     os.system("openssl req -new -sha256 -key ssl.key/'%s'.key > ssl.csr/'%s'.csr" %(kname,csname))
	#GENERATE MANUAL CERT
	     #crtname=cname
	     #os.system("openssl x509 -signkey ssl.key/'%s.'key -in ssl.csr/'%s'.csr -req -days 365 -out ssl.crt/'%s'.crt" %(kname,csname,crtname))

	def validateData():
	#Key and CSR
	     print bcolors.OKGREEN + "[*******************Matching Data*******************]" + bcolors.ENDC
	     print bcolors.WARNING + "\n----> KEY & CSR:"+ bcolors.ENDC
	     vkeypath = "%s/ssls/ssl.key/%s.key" % (homepath,cname)
	     if os.path.isfile(vkeypath):
	      
	      pva = os.popen("openssl rsa -noout -modulus -in ssl.key/'%s'.key | openssl md5 "  % (cname))
	      sva = pva.readline()
	      pva.close()
	      senva= " ".join(sva.split())
	      print "\nKEY = %s" %(senva)
	     else: 
	      print "\n%s.key doesnt exist" % (cname)

	     vcsrpath = "%s/ssls/ssl.csr/%s.csr" % (homepath,cname)
	     if os.path.isfile(vcsrpath):
	      
	      pva2 = os.popen("openssl req -noout -modulus -in ssl.csr/'%s'.csr | openssl md5" % (cname))
	      sva2 = pva2.readline()
	      pva2.close()
	      senva2= " ".join(sva2.split())
	      print "\nCSR = %s" %(senva2)
	     else:
	      print "\n%s.csr doesnt exists" % (cname)
	 

	     try:
	      if senva==senva2:	
		print bcolors.OKGREEN + "\nKEY and CSR Matched" + bcolors.ENDC
	     except:
	      pass

	#key and cert

	#vkeypath = "/home/saurabh/%s.key" % (cname)
	     print bcolors.WARNING + "\n----> KEY & CERT:"+ bcolors.ENDC
	     if os.path.isfile(vkeypath):
	      
	      pva3 = os.popen("openssl rsa -noout -modulus -in ssl.key/'%s'.key | openssl md5"  % (cname))
	      sva3 = pva3.readline()
	      pva3.close()
	      senva3= " ".join(sva3.split())
	      print "\nKEY = %s" %(senva3)
	     else: 
	      print "\n%s.key doesnt exist" % (cname)

	     vcrtpath = "%s/ssls/ssl.crt/%s.crt" % (homepath,cname)
	     if os.path.isfile(vcrtpath):
	      
	      pva4 = os.popen("openssl x509 -noout -modulus -in ssl.crt/'%s'.crt | openssl md5" % (cname))
	      sva4 = pva4.readline()
	      pva4.close()
	      senva4= " ".join(sva4.split())
	      print "\nCERT = %s" %(senva4)
	     else:
	      print "\n%s.crt doesnt exists" % (cname)

	     try: 
	      if senva3==senva4:	
		print bcolors.OKGREEN + "\nKEY and CERT Matched" + bcolors.ENDC
	     except:
	      pass

	# CERT and CSR.
	     print bcolors.WARNING + "\n----> CSR & CERT:"+ bcolors.ENDC

	     if os.path.isfile(vcsrpath):
	      
	      pva5 = os.popen("openssl req -noout -modulus -in ssl.csr/'%s'.csr | openssl md5" % (cname))
	      sva5 = pva5.readline()
	      pva5.close()
	      senva5= " ".join(sva5.split())
	      print "\nCSR = %s" %(senva5)
	     else: 
	      print "\n%s.csr doesnt exist" % (cname)


	     if os.path.isfile(vcrtpath):
	      
	      pva6 = os.popen("openssl x509 -noout -modulus -in ssl.crt/'%s'.crt | openssl md5" % (cname))
	      sva6 = pva6.readline()
	      pva6.close()
	      senva6= " ".join(sva6.split())
	      print "\nCERT = %s" %(senva6)
	     else:
	      print "\n%s.crt doesnt exists" % (cname)

	     try:
	      if senva5==senva6:	
		print bcolors.OKGREEN + "\nCSR and CERT Matched" + bcolors.ENDC
	     except:
	      pass




	def decodeData():
	    
	   csrpath = "%s/ssls/ssl.csr/%s.csr" % (homepath,cname)
	   if os.path.isfile(csrpath):
	      
	      print bcolors.OKGREEN + "[*******************Decoded CSR*******************]" + bcolors.ENDC 
	      p = os.popen("openssl req -in ssl.csr/%s.csr -noout -text | grep -w 'Subject:'" % (cname))
	      s = p.readline()
	      p.close()
	      sen= " ".join(s.split())
	      print "\n%s" %(sen)

	      p1 = os.popen("openssl req -in ssl.csr/%s.csr -noout -text | grep -w 'Signature Algorithm:'" % (cname))
	      s1 = p1.readline()
	      p1.close()
	      sen1= " ".join(s1.split())
	      print "\n%s" %(sen1)

	      p2 = os.popen("openssl req -in ssl.csr/%s.csr -noout -text | grep -w 'Public Key Algorithm:'" % (cname))
	      s2 = p2.readline()
	      p2.close()
	      sen2= " ".join(s2.split())
	      print "\n%s" %(sen2)

	      p3 = os.popen("openssl req -in ssl.csr/%s.csr -noout -text | grep -w 'Public-Key:'" % (cname))
	      s3 = p3.readline()
	      p3.close()
	      sen3= " ".join(s3.split())
	      print "\n%s" %(sen3)

	      p4 = os.popen("openssl req -in ssl.csr/%s.csr -noout -text | grep -e 'DNS:'" % (cname))
	      s4 = p4.readline()
	      p4.close()
	      sen4= " ".join(s4.split())
	      print "%s" %(sen4)

	   else:
	      print "%s.csr doesn't exists" % (cname)

	   crtpath = "%s/ssls/ssl.crt/%s.crt" % (homepath,cname)
	   if os.path.isfile(crtpath):

	     print bcolors.OKGREEN + "[*******************Decoded CERT*******************]" + bcolors.ENDC
	     pa = os.popen("openssl x509 -in ssl.crt/%s.crt -text -noout | grep -w 'Subject:'" %(cname))
	     sa = pa.readline()
	     pa.close()
	     sena= " ".join(sa.split())
	     print "\n%s" %(sena)

	     pa1 = os.popen("openssl x509 -in ssl.crt/%s.crt -text -noout | grep -m 1 -w 'Signature Algorithm:'" %(cname))
	     sa1 = pa1.readline()
	     pa1.close()
	     sena1= " ".join(sa1.split())
	     print "\n%s" %(sena1)
	 
	 
	     pa2 = os.popen("openssl x509 -in ssl.crt/%s.crt -text -noout | grep -w 'Public Key Algorithm:'" %(cname))
	     sa2 = pa2.readline()
	     pa2.close()
	     sena2= " ".join(sa2.split())
	     print "\n%s" %(sena2)

	     pa3 = os.popen("openssl x509 -in ssl.crt/%s.crt -text -noout | grep -w 'Issuer:'" %(cname))
	     sa3 = pa3.readline()
	     pa3.close()
	     sena3= " ".join(sa3.split())
	     print "\n%s" %(sena3)

	 
	     pa4 = os.popen("openssl x509 -in ssl.crt/%s.crt -text -noout | grep -w 'Not Before:'" %(cname))
	     sa4 = pa4.readline()
	     pa4.close()
	     sena4= " ".join(sa4.split())
	     print "\n%s" %(sena4)

	     pa5 = os.popen("openssl x509 -in ssl.crt/%s.crt -text -noout | grep -w 'Not After :'" %(cname))
	     sa5 = pa5.readline()
	     pa5.close()
	     sena5= " ".join(sa5.split())
	     print "\n%s" %(sena5)

	     pa6 = os.popen("openssl x509 -in ssl.crt/%s.crt -text -noout | grep -e 'DNS:'" %(cname))
	     sa6 = pa6.readline()
	     pa6.close()
	     sena6= " ".join(sa6.split())
	     print "\n%s" %(sena6)
	  
	   else:
	     print "%s.crt doesnt exist" % (cname)

	def validateIntemediate():
	 
	 def main2():
	   
	  language1 = 0
	  Intermenu()

	  language1 = input("\nEnter Choice: ")
	  print language1

	  if language1 == 1:
	   SHA2()
	  elif language1 == 2:
	   FULLSHA2()
	  elif language1 == 3:
	   Intermediate()
	  elif language1 == 4:
	   exit()
	   exit
	
	  else: #validate selection
	   print("That is not a valid selection, please type the correct number\n")
	   main2() #call the main and start the loop again
	  while language1 == 4:
	   break #exits out of the program
	  else:
	   InterreplayMenu()
	  
	 def Intermenu():
	    
	  print "[********************* Options **********************]"
	  print "Assuming that all CERT's are in ssl.crt folder"
	  print "\n 1. GS - SHA2"
	  print "\n 2. GS - FUll SHA2"
	  print "\n 3. 3'rd Party"
	  print "\n 4. Exit"

	 def InterreplayMenu():
	  main2()

	#GS SHA 2
	 def SHA2():

	  vvcrtpath = "%s/ssls/ssl.crt/%s.crt" % (homepath,cname)

	  if os.path.isfile(vvcrtpath):    
	   iva = os.popen("openssl verify -verbose -purpose sslserver -CAfile ssl.crt/gs-intermediate-root-bundle-2018.crt ssl.crt/'%s'.crt" % (cname))
	   va = iva.readline()
	   iva.close()
	   enva= " ".join(va.split())
	   print "\n%s" %(enva)
	  else: 
	   print "%s.crt doesnt exist" % (cname)
	 
	  try:
	   if "%s.crt: OK" % (cname) in enva :
	    print bcolors.OKGREEN + "Status: Matched"+ bcolors.ENDC
	   else:
	    print bcolors.FAIL + "Status: Not Matched"+ bcolors.ENDC
	  except:
	    pass

	#" GS - FUll SHA2"
	 def FULLSHA2():
	  vvcrtpath = "%s/ssls/ssl.crt/%s.crt" % (homepath,cname)
	  print " GS - FUll SHA2"
	  if os.path.isfile(vvcrtpath):
	      
	   iva1 = os.popen("openssl verify -verbose -purpose sslserver -CAfile ssl.crt/gs-intermediate-root-full-sha256-bundle-2018.crt ssl.crt/'%s'.crt" % (cname))
	   va1 = iva1.readline()
	   iva1.close()
	   enva1= " ".join(va1.split())
	   print "\n%s" %(enva1)
	  else: 
	   print "%s.crt doesnt exist" % (cname)
	 
	  try:
	   if "%s.crt: OK" % (cname) in enva1 :
	    print bcolors.OKGREEN + "Status: Matched"+ bcolors.ENDC
	   else:
	    print bcolors.FAIL + "Status: Not Matched"+ bcolors.ENDC
	  except:
	    pass

	#1. Intermediate :
	 def Intermediate():
	  def main3():

	   language2 = 0

	      # intro()
	   Intermenu1()

	   language2 = input("\nEnter Choice: ")
	   print language2

	   if language2 == 1:
	    BundleInter()
	   elif language2 == 2:
	    BundleInterSep()
	   elif language2 == 3:
	    exit()
	    exit
	
	   else: #validate selection
	    print("That is not a valid selection, please type the correct number\n")
	    main3() #call the main and start the loop again
	   while language2 == 3:
	    break #exits out of the program
	   else:
	    InterreplayMenu1()
	     

	  def Intermenu1():
	    
	   print "[********************* Options **********************]"
	   print "Assuming that all CERT's are in ssl.crt folder"
	   print "\n 1. Intermediate bundle"
	   print "\n 2. Seperate Intermediate & Root"
	   print "\n 3. Exit"

	  def InterreplayMenu1():
	   main3()

	  def BundleInter():
	   print "\nIntermedaite"
	   vvcrtpath = "%s/ssls/ssl.crt/%s.crt" % (homepath,cname)
	   if os.path.isfile(vvcrtpath):
	    inter= raw_input("What's the Intermediate name?\n")
	    iva2 = os.popen("openssl verify -verbose -purpose sslserver -CAfile ssl.crt/'%s' ssl.crt/'%s'.crt" % (inter,cname))
	    va2 = iva2.readline()
	    iva2.close()
	    enva2= " ".join(va2.split())
	    print "\n%s" %(enva2)
	   else: 
	    print "%s.crt doesnt exist" % (cname)
	 
	   try:

	    if "%s.crt: OK" % (cname) in enva2 :
	     print bcolors.OKGREEN + "Status: Matched"+ bcolors.ENDC
	    else:
	     print bcolors.FAIL + "Status: Not Matched"+ bcolors.ENDC
	   except:
	    pass

	  def BundleInterSep():
	   print "\nIntermedaite"
	   vvcrtpath = "%s/ssls/ssl.crt/%s.crt" % (homepath,cname)
	  
	   if os.path.isfile(vvcrtpath):
	    inter= raw_input("What's the Intermediate name?\n")
	    interroot = raw_input("What's the Root name?\n")
	#("openssl verify -verbose -purpose sslserver -CAfile <(cat ssls/ssl.crt/'%s' ssls/ssl.crt/'%s') '%s'.crt" % (interroot,inter,cname))
            os.system(" cat ssl.crt/%s ssl.crt/%s >> ssl.crt/DemoFile  "  % ( interroot,inter))
            filename="DemoFile"

            iva9 = os.popen("openssl verify -verbose -purpose sslserver -CAfile ssl.crt/%s ssl.crt/%s.crt" % ( filename,cname ))

	    va9 = iva9.readline()
	    iva9.close()
	    enva9= " ".join(va9.split())
	    print "\n%s" %(enva9)
	    os.system("rm -rf ssl.crt/DemoFile")
	   else: 
	    print "%s.crt doesnt exist" % (cname)
	 
	   try:

	    if "%s.crt: OK" % (cname) in enva9 :
	     print bcolors.OKGREEN + "Status: Matched"+ bcolors.ENDC
	    else:
	     print bcolors.FAIL + "Status: Not Matched"+ bcolors.ENDC
	   except:
	    pass

	  
	    
	  main3()

	 main2()
	   
	   


	main() #main menu

 else:
  print "Please Provide One Common Name"
except:
 pass


#replayMenu()
