
#This script is to aggreate results for further analysis

if [ $# -lt 2 ] 
    then
        echo "USAGE: $0 ROOT_DIR REGREX SKIP_NR"
        exit
fi

ROOT_DIR=$1
REGREX=$2

if [ $# -eq 3 ]
    then
        SKIP_NR=$3
    else
        SKIP_NR=6
fi

echo "ROOT: " ${ROOT_DIR}
echo "REGREX: " ${REGREX}
echo "SKIP_NR: " ${SKIP_NR}
echo "rate(tuple/s)	mean(ms)	99%ile(ms)	99.9%ile(ms)	cores	mem(MB)"

for file in "$ROOT_DIR"/*
do
  case "$file" in 
  *${REGREX}*)
#echo $file
     awk -v skip="$SKIP_NR" 'NR >=skip { 
                   count++;
                   rate += $3;
                   mean += $4;
                   ile99 += $5;
                   ile999 += $6;
                   core += $7;
                   mem += $8
                 } 
                 END {
                    print rate/count  "\t"  mean/count  "\t" ile99/count  "\t" ile999/count  "\t" core/count  "\t" mem/count
                 }' $file

    ;;
   esac  
done





