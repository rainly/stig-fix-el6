#!/bin/bash
######################################################################
#By Tummy a.k.a Vincent C. Passaro		                     #
#Vincent[.]Passaro[@]gmail[.]com				     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22574
#Group Title: GEN008360
#Rule ID: SV-26961r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008360
#Rule Title: If the system is using LDAP for authentication or account information, the LDAP TLS key file must not have an extended ACL.
#
#Vulnerability Discussion: LDAP can be used to provide user authentication and account information, which are vital to system security. The LDAP client configuration must be protected from unauthorized modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Determine the key file.
# grep -i '^tls_key' /etc/ldap.conf
#Check the permissions.
# ls -lL <keypath>
#If the permissions of the file contains a '+', an extended ACL is present. This is a finding.
#
#Fix Text: Remove the extended ACL from the key file.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008360

#Start-Lockdown
if [ -e /etc/ldap.conf ]; then
	echo '==================================================='
	echo ' Patching GEN008280: Remove ACLs from LDAP TLS Key'
	echo '==================================================='
	TLSKEY=$(  grep -i '^tls_key' /etc/ldap.conf | awk '{print $2}' ) 
	for line in $TLSKEY; do
		if [ -a $TLSKEY ]; then
			ACLOUT=`getfacl --skip-base $TLSKEY 2>/dev/null`;
			if [ "$ACLOUT" != "" ]; then
				setfacl --remove-all $TLSKEY
			fi
		fi
	done
fi
