if [[ -z "$1" ]] || [[ -z "$2" ]]; then
    echo "Please input filename and size"
    echo "$0  <filename> <size in bytes>"
    exit 1;
fi

if [[ "$3" -gt 0 ]]; then
 echo "The file will be in $3 GB"

openssl rand -out $filename -base64 $(($3 * 2**30 * 3/4 ))
else
filename=$1
size=$2
size_cal=$(echo "$size * 3/4  " | bc -l);

openssl rand -out $filename -base64 $size_cal
fi
