# debian-postinstall.sh

Script a utiliser apres une installation de Debian.
Compatible Debian 8 Jessie et Debian 9 Stretch.

Le script installe le shell Zsh, l'editeur de texte Vim et les configure grace au site http://formation-debian.via.ecp.fr/

Le script ajoute aussi la fonction extract qui permet d'extraire n'importe quel archive. ( https://github.com/xvoland/Extract )

# dumpSQL.sh

Permet de faire une sauvegarde de toutes les bases de données d'une instance MySQL

Le paramètre RETENTION permet de définir le nombre de sauvegarde à garder.
Le paramètre EXCLUSIONS permet de définir des bases à exclure de la sauvegarde ( de base information_schema|performance_schema )

Le script créé un fichier sql.gz par base de donnée dans le répertoire DATADIR

GeoHolz

