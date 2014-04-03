# bash fixbmsql
# Add drop all tables command to backup_migrate sql file.


CMD="drop schema tfat3; create schema tfat3; use tfat3;\n"
cd ~/Downloads
gunzip "$1"
GZ=".gz"
SPACE=""
MYSQL="${1/$GZ/$SPACE}"
echo $MYSQL
sed -i "7s/^/$CMD/" $MYSQL
gzip $MYSQL
