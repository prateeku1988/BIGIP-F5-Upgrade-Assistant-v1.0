#!/bin/bash
##
#################################################################################################################
##
## Author : Prateek Upadhyay
##
## Title  : BigIP F5 Objects Upgrade Assistant
##
## Date   : 03.12.2018
##
## Objective : Below snippet will show the total no of objects, their availability status , states
## 	       before and after upgrade . Any change in all of those parameters will displayed over
##	       the terminal screen . Also it will mention what changed and reason for it in side by side
##	       pattern
##
## Version Control : 1.0
####################################################################################################################

while  [ 1 ]
do


HEIGHT=20
WIDTH=80
CHOICE_HEIGHT=8
BACKTITLE="BigIP F5 Upgrade Assistantv1.0"
TITLE="Upgrade Assistantv1.0"
MENU="Please select the Menu options as below:"

OPTIONS=(1 "Run this tool before upgrade."
         2 "Run this tool after upgrade."
         3 "Comparison between Pre-Upgrade & Post-Upgrade state of BigIP F5 Objects."
	 4 "Bye!!")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
      		1)

                        echo "This script will run silently , Please be patient with me!!!"

					a="\nTotal Virtuals"

                        b=$(tmsh -c 'cd /;show ltm virtual recursive' | grep  'Availability' | wc -l | sed -e 'G;G')   ### It will show the total virtuals from all partitions

(
			echo "10" ; sleep 1

			c="\nVirtuals exist in Available,Offline & Unknown State"

                        d=$(tmsh -c 'cd /;show ltm virtual recursive' | grep 'Availability' | awk -F : '{ print $2 }' | sort | uniq -c | sed -e 'G;G')  ### It will show you the no of virtuals that are available , offline and unknown

			cd="\nVirtuals exist in Disabled State"

                        vds=$(tmsh -c 'cd /;show ltm virtual recursive' | grep 'State' | awk -F : '{ print $2 }' | grep 'disabled' | sort | uniq -c  | (grep 'disabled' &&  echo '' || echo '0') | sed -e 'G') ### It will show you the no of virtuals that are in disabled state

			echo "XXX" ; echo "This script will run silently" ; echo "\\n" ; echo "just bear with me for moment!!!"; echo "XXX"

			e="\nTotal Pools"

			f=$(tmsh -c 'cd /;show ltm pool recursive' | grep  'Availability' | wc -l | sed -e 'G;G')     ### It will show the total pools from all partitions

			echo "20" ; sleep 1

			g="\nPools exist in Available,Offline & Unknown State"

			h=$(tmsh -c 'cd /;show ltm pool recursive' | grep  'Availability' | awk -F : '{ print $2 }' | sort | uniq -c | sed -e 'G;G')  ### It will show the no of pools that are available , offline and unknown

			gh="\nPools exist in Disabled State"

			pds=$(tmsh -c 'cd /;show ltm pool recursive' | grep 'State' | awk -F : '{ print $2 }' | grep 'disabled' | sort | uniq -c  | (grep 'disabled' &&  echo '' || echo '0') | sed -e 'G') ### It will show you the no pools that are in disabled state

			i="\nTotal Pool Members"

			j=$(tmsh -c 'cd /;show ltm pool recursive members' | grep -B 3 'Availability' | grep 'Pool Member' | sort -u | wc -l | sed -e 'G;G') ### It will show the total pool members from all partitions

			k="\nPool Members exist in Available , Offline & Unknown State"

			l=$(tmsh -c 'cd /;show ltm pool recursive members' | grep -A 3 'Pool Member' |  awk -F : '{ print $2 }' | sort | uniq -c | sed '1d' | sed -e 'G;G') ### It will show the no of pool members that are availble , offline

			kl="\nPool Members exist in Disabled State"

			pmds=$(tmsh -c 'cd /;show ltm pool recursive members' | grep 'State' | awk -F : '{ print $2 }' | grep 'disabled' | sort | uniq -c  | (grep 'disabled' &&  echo '' || echo '0') | sed -e 'G') ### It will show you the no of pool members in disabled state

			echo "50" ; sleep 1

			m="\nTotal Nodes"

			foo=$(tmsh -c 'cd /;show ltm node recursive' | grep 'Availability' | wc -l| sed -e 'G;G')  ### It will show the tool nodes from all partitions

			o="\nNodes exist in Available , Offline & Unknown State"

			p=$(tmsh -c 'cd /;show ltm node recursive' | grep 'Availability' | awk -F : '{ print $2 }' | sort | uniq -c| sed -e 'G;G') ### It will show the no of nodes that are available , offline

			op="\nNodes exist in Disabled State"

			nds=$(tmsh -c 'cd /;show ltm node recursive' | grep 'State' | awk -F : '{ print $2 }' | grep 'disabled' | sort | uniq -c  | (grep 'disabled' &&  echo '' || echo '0') | sed -e 'G') ## It will show you the no of nodes in disabled state.

			echo "75" ; sleep 1

  			q="\nReason For Change in states of Virtual Servers"

			r=$(tmsh -c 'cd /;show ltm virtual recursive' | grep -E -B 4 -A 2 'unknown'| sed -e 'G;G' | fold -w 49)

			s=$(tmsh -c 'cd /;show ltm virtual recursive' | grep -E -B 4 -A 2 'offline'| sed -e 'G;G'| fold -w 49)

			rs=$(tmsh -c 'cd /;show ltm virtual recursive' | grep -E -B 4 -A 2 ': available'| sed -e 'G;G'| fold -w 49)

 			t="\nReason for Change in States of Pools"

			u=$(tmsh -c 'cd /;show ltm pool recursive' |  grep -E -B 4 -A 2 'unknown'| sed -e 'G;G'| fold -w 49)

			tu=$(tmsh -c 'cd /;show ltm pool recursive' |  grep -E -B 4 -A 2 'offline'| sed -e 'G;G'| fold -w 49)

			tuu=$(tmsh -c 'cd /;show ltm pool recursive' |  grep -E -B 4 -A 2 'available'| sed -e 'G;G'| fold -w 49)

			v="\nReason for change in States of Pool Members"

			w=$(tmsh -c 'cd /;show ltm pool recursive members' |  grep -E -B 4 -A 2 'unknown'| sed -e 'G;G; s/|//' | fold -w 49)

			vw=$(tmsh -c 'cd /;show ltm pool recursive members' |  grep -E -B 4 -A 2 'offline'| sed -e 'G;G; s/|//; s/ deadline.*/ deadline./' | fold -w 49)

			vww=$(tmsh -c 'cd /;show ltm pool recursive members' |  grep -E -B 4 -A 2 'available'| sed -e 'G;G; s/|//' | fold -w 49)

			x="\nReason for change in States of Nodes"

			y=$(tmsh -c 'cd /;show ltm node recursive' | grep -E -B 4 -A 2 'unknown' | sed -e 'G;G; s/|//' |  fold -w 49)

			xy=$(tmsh -c 'cd /;show ltm node recursive' | grep -E -B 4 -A 2 'offline' | sed -e 'G;G; s/|//; s/ deadline.*/ deadline./' | fold -w 49)

			xyy=$(tmsh -c 'cd /;show ltm node recursive' | grep -E -B 4 -A 2 'available' | sed -e 'G;G; s/|//' | fold -w 49)

			z="$a\n$b\n$c\n$d\n$cd\n$vds\n$e\n$f\n$g\n$h\n$gh\n$pds\n$i\n$j\n$k\n$l\n$kl\n$pmds\n$m\n$foo\n$o\n$p\n$op\n$nds\n$q\n$r\n$s\n$rs\n$t\n$u\n$tu\n$tuu\n$v\n$w\n$vw\n$vww\n$x\n$y\n$xy\n$xyy\n"

			echo -e "$z" >> Results_BeforeUpgrade.csv

			echo "100" ; sleep 1
) |
dialog --title "Parsing BigIP F5 objects" --gauge "Checking Objects before Upgrade" 10 60
			;;

		2)

			echo "This script will run silently , Please be patient with me!!!"

		a="\nTotal Virtuals"

                        b=$(tmsh -c 'cd /;show ltm virtual recursive' | grep  'Availability' | wc -l | sed -e 'G;G')   ### It will show the total virtuals from all partitions

(
			echo "10" ; sleep 1

			c="\nVirtuals exist in Available,Offline & Unknown State"

                        d=$(tmsh -c 'cd /;show ltm virtual recursive' | grep 'Availability' | awk -F : '{ print $2 }' | sort | uniq -c | sed -e 'G;G')  ### It will show you the no of virtuals that are available , offline and unknown

			cd="\nVirtuals exist in Disabled State"

                        vds=$(tmsh -c 'cd /;show ltm virtual recursive' | grep 'State' | awk -F : '{ print $2 }' | grep 'disabled' | sort | uniq -c  | (grep 'disabled' &&  echo '' || echo '0') | sed -e 'G') ### It will show you the no of virtuals that are in disabled state

			echo "XXX" ; echo "This script will run silently" ; echo "\\n" ; echo "just bear with me for moment!!!"; echo "XXX"

			e="\nTotal Pools"

			f=$(tmsh -c 'cd /;show ltm pool recursive' | grep  'Availability' | wc -l | sed -e 'G;G')     ### It will show the total pools from all partitions

			echo "20" ; sleep 1

			g="\nPools exist in Available,Offline & Unknown State"

			h=$(tmsh -c 'cd /;show ltm pool recursive' | grep  'Availability' | awk -F : '{ print $2 }' | sort | uniq -c | sed -e 'G;G')  ### It will show the no of pools that are available , offline and unknown

			gh="\nPools exist in Disabled State"

			pds=$(tmsh -c 'cd /;show ltm pool recursive' | grep 'State' | awk -F : '{ print $2 }' | grep 'disabled' | sort | uniq -c  | (grep 'disabled' &&  echo '' || echo '0') | sed -e 'G') ### It will show you the no pools that are in disabled state

			i="\nTotal Pool Members"

			j=$(tmsh -c 'cd /;show ltm pool recursive members' | grep -B 3 'Availability' | grep 'Pool Member' | sort -u | wc -l | sed -e 'G;G') ### It will show the total pool members from all partitions

			k="\nPool Members exist in Available , Offline & Unknown State"

			l=$(tmsh -c 'cd /;show ltm pool recursive members' | grep -A 3 'Pool Member' |  awk -F : '{ print $2 }' | sort | uniq -c | sed '1d' | sed -e 'G;G') ### It will show the no of pool members that are availble , offline

			kl="\nPool Members exist in Disabled State"

			pmds=$(tmsh -c 'cd /;show ltm pool recursive members' | grep 'State' | awk -F : '{ print $2 }' | grep 'disabled' | sort | uniq -c  | (grep 'disabled' &&  echo '' || echo '0') | sed -e 'G') ### It will show you the no of pool members in disabled state

			echo "50" ; sleep 1

			m="\nTotal Nodes"

			foo=$(tmsh -c 'cd /;show ltm node recursive' | grep 'Availability' | wc -l| sed -e 'G;G')  ### It will show the tool nodes from all partitions

			o="\nNodes exist in Available , Offline & Unknown State"

			p=$(tmsh -c 'cd /;show ltm node recursive' | grep 'Availability' | awk -F : '{ print $2 }' | sort | uniq -c| sed -e 'G;G') ### It will show the no of nodes that are available , offline

			op="\nNodes exist in Disabled State"

			nds=$(tmsh -c 'cd /;show ltm node recursive' | grep 'State' | awk -F : '{ print $2 }' | grep 'disabled' | sort | uniq -c  | (grep 'disabled' &&  echo '' || echo '0') | sed -e 'G') ## It will show you the no of nodes in disabled state.

			echo "75" ; sleep 1

  			q="\nReason For Change in states of Virtual Servers"

			r=$(tmsh -c 'cd /;show ltm virtual recursive' | grep -E -B 4 -A 2 'unknown'| sed -e 'G;G' | fold -w 49)

			s=$(tmsh -c 'cd /;show ltm virtual recursive' | grep -E -B 4 -A 2 'offline'| sed -e 'G;G'| fold -w 49)

			rs=$(tmsh -c 'cd /;show ltm virtual recursive' | grep -E -B 4 -A 2 ': available'| sed -e 'G;G'| fold -w 49)

 			t="\nReason for Change in States of Pools"

			u=$(tmsh -c 'cd /;show ltm pool recursive' |  grep -E -B 4 -A 2 'unknown'| sed -e 'G;G'| fold -w 49)

			tu=$(tmsh -c 'cd /;show ltm pool recursive' |  grep -E -B 4 -A 2 'offline'| sed -e 'G;G'| fold -w 49)

			tuu=$(tmsh -c 'cd /;show ltm pool recursive' |  grep -E -B 4 -A 2 'available'| sed -e 'G;G'| fold -w 49)

			v="\nReason for change in States of Pool Members"

			w=$(tmsh -c 'cd /;show ltm pool recursive members' |  grep -E -B 4 -A 2 'unknown'| sed -e 'G;G; s/|//'| fold -w 49)

			vw=$(tmsh -c 'cd /;show ltm pool recursive members' |  grep -E -B 4 -A 2 'offline'| sed -e 'G;G; s/|//; s/ deadline.*/ deadline./' | fold -w 49)

			vww=$(tmsh -c 'cd /;show ltm pool recursive members' |  grep -E -B 4 -A 2 'available'| sed -e 'G;G; s/|//' | fold -w 49)

			x="\nReason for change in States of Nodes"

			y=$(tmsh -c 'cd /;show ltm node recursive' | grep -E -B 4 -A 2 'unknown' | sed -e 'G;G; s/|//'| fold -w 49)

			xy=$(tmsh -c 'cd /;show ltm node recursive' | grep -E -B 4 -A 2 'offline' | sed -e 'G;G; s/|//; s/ deadline.*/ deadline./' | fold -w 49)

			xyy=$(tmsh -c 'cd /;show ltm node recursive' | grep -E -B 4 -A 2 'available' | sed -e 'G;G; s/|//'| fold -w 49)

			z="$a\n$b\n$c\n$d\n$cd\n$vds\n$e\n$f\n$g\n$h\n$gh\n$pds\n$i\n$j\n$k\n$l\n$kl\n$pmds\n$m\n$foo\n$o\n$p\n$op\n$nds\n$q\n$r\n$s\n$rs\n$t\n$u\n$tu\n$tuu\n$v\n$w\n$vw\n$vww\n$x\n$y\n$xy\n$xyy\n"

			echo -e "$z" >> Results_AfterUpgrade.csv

			echo "100" ; sleep 1
) |
dialog --title "Parsing BigIP F5 objects" --gauge "Checking Objects after Upgrade" 10 60
			;;
	     3)
			echo "Checking it Now!!!"
			diff -q  Results_BeforeUpgrade.csv Results_AfterUpgrade.csv
			output=$?
			if [ $output -eq 0 ]
		then
			echo "Both the Pre-Upgrade and Post-Upgrade files are same"
			echo "Do you want to see Pre-Upgrade and Post-Upgrade files? Press [Y,n]"
       			read input
			if [[ $input == "Y" || $input == "y" ]]; then
			echo "[PRE-UPGRADE]                                                ||        [POST-UPGRADE] ";echo "";diff -y -W 130  Results_BeforeUpgrade.csv Results_AfterUpgrade.csv | less -R
		else
	exit
			fi
			elif [ $output -eq 1 ]
		then
			echo "Both the Pre-Upgrade and Post-Upgrade files differ"
			echo "Do you want to see Pre-Upgrade and Post-Upgrade files? Press [Y,n]"
			read input
			if [[ $input == "Y" || $input == "y" ]]; then
			echo "[PRE-UPGRADE]                                                ||        [POST-UPGRADE] ";echo "";diff -y -W 135  Results_BeforeUpgrade.csv Results_AfterUpgrade.csv |  awk '/^Total /,/Reason/' | GREP_COLOR='1;5' grep -i --color=always -F -A5000 -B1000 '|' | sed '$d' | sed 's/|/>>/'

			echo "[PRE-UPGRADE]                                                ||        [POST-UPGRADE] ";echo "";diff -y -W 135  Results_BeforeUpgrade.csv Results_AfterUpgrade.csv | awk '/^Reason For Change in states of Virtual Servers/,/^Reason for Change in States of Pools/' | GREP_COLOR='1;5' grep -i --color=always -F -A5000 -B1000 '|' | sed -e 's/,//g; s/<//' | sed '$d' | sed 's/|/>>/' | less -R

			echo "[PRE-UPGRADE]                                                ||        [POST-UPGRADE] ";echo "";diff -y -W 135  Results_BeforeUpgrade.csv Results_AfterUpgrade.csv | awk '/^Reason for Change in States of Pools/,/^Reason for change in States of Pool Members/' | GREP_COLOR='1;5' grep -i --color=always -F -A5000 -B1000 '|' | sed -e 's/,//g; s/<//' | sed '$d' | sed 's/|/>>/' | less -R

			echo "[PRE-UPGRADE]                                                ||        [POST-UPGRADE] ";echo "";diff -y -W 135  Results_BeforeUpgrade.csv Results_AfterUpgrade.csv | awk '/^Reason for change in States of Pool Members/,/^Reason for change in States of Nodes/' | sed -e 's/| Ltm/  Ltm/g; s/| Status/  Status/g; s/|   Availability/    Availability/g; s/|   Reason/    Reason/g; s/|   State/    State/g' |  GREP_COLOR='1;5' grep -i --color=always -F -A5000 -B1000 '|' | sed '$d' | sed 's/|/>>/' | less -R

			echo "[PRE-UPGRADE]                                                ||        [POST-UPGRADE] ";echo "";diff -y -W 135  Results_BeforeUpgrade.csv Results_AfterUpgrade.csv | grep -A10000 'Reason for change in States of Nodes' | GREP_COLOR='1;5' grep -i --color=always -F -A5000 -B1000 '|' | sed '$d' | sed 's/|/>>/' | less -R

		else
	exit
			fi
        break
			else
 			echo "There was something wrong"
			fi
        break
                         ;;


	  4) exit


esac

done
