#!/bin/bash
# Mon script de post installation serveur Debian 
# Compatible Debian 8 JEssie / Debian 9 Stretch
# Geoholz - 03/2018
# GPL
#
# Syntaxe: # su - -c "./debian-postinstall.sh"
# Syntaxe: or # sudo ./debian-postinstall.sh
VERSION="0.3"

#=============================================================================
# Liste des applications ànstaller: A adapter a vos besoins
LISTE="fail2ban vim zsh curl cheat"
#=============================================================================

# Test que le script est lance en root
if [ $EUID -ne 0 ]; then
  echo -e "\nLe script doit être lancé avec l'utilisateur root: # sudo $0" 1>&2
  exit 1
fi


# Mise a jour de la liste des depots
#-----------------------------------

# Update 
echo -e "\n### Mise a jour de la liste des depots\n"
apt update

# Upgrade
echo -e "\n### Mise a jour du systeme\n"
apt -y upgrade

# Installation
echo -e "\n### Installation des logiciels suivants: $LISTE\n"
apt -y install $LISTE

# Configuration
#--------------

echo -e "\n### Recuperation des fichiers de configuration sur http://formation-debian.via.ecp.fr/shell.html \n"
cd /tmp
wget http://formation-debian.via.ecp.fr/fichiers-config.tar.gz
tar xzf fichiers-config.tar.gz
rm fichiers-config.tar.gz
cd /tmp/fichiers-config

echo -e "\n### Configuration de ZSH et VIM \n"
# ZSH
cd /tmp/fichiers-config
mv zshrc zshenv zlogin zlogout /etc/zsh/
mv dir_colors /etc/
curl https://raw.githubusercontent.com/GeoHolz/Extract/master/extract.sh >> /etc/zsh/zshrc
sed -i 's/bash/zsh/g' /etc/passwd


# VIM
cp /tmp/fichiers-config/vimrc /etc/vim/


echo -e -n "\n### Entrez l'adresse mail pour les rapports de securite: "
read MAIL 

# fail2ban
sed -i 's/destemail = root@localhost/destemail = '$MAIL'/g' /etc/fail2ban/jail.conf



echo -e "\n### Configuration finit. Il faut vous dénnecter/rconnecter pour que les modifications prennents effets"
echo "### Lors de la premié connexion, il est prérable de choisir l'option 2 pour ZSH."
# Fin du script
