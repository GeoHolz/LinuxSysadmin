#!/bin/bash
## Paramètres
USER='user'
PASS='password'
RETENTION=15
#date du jour
DATE=`date +%d_%m_%y`
# Exclure des bases
EXCLUSIONS='(information_schema|performance_schema)'
# Répertoire de stockage des sauvegardes
DATADIR="/rsome/where/"

# On place dans un tableau le nom de toutes les bases de données du serveur
databases="$(mysql -u $USER -p$PASS -Bse 'show databases' | grep -v -E $EXCLUSIONS)"


#on boucle sur chaque base
for SQL in $databases

do
    #echo $SQL
    mysqldump -u $USER -p$PASS --quick --add-locks --lock-tables --extended-insert $SQL --skip-lock-tables | gzip > ${DATADIR}/$SQL"_"$DATE.sql.gz
done

#echo "Suppression des vieux backup : "
find ${DATADIR} -name "*.gz" -mtime +${RETENTION} -print -exec rm {} \;
