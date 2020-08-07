if [ -z "$1" ]
then
    echo "Usage $0 [NUM_POINTS [NUM_POINTS...]]"
    exit -1
fi
for NUM_POINTS in $@
do
    echo "Generating $NUM_POINTS point tests..."
    ./gen_gpdb_perf_tests.sh $NUM_POINTS > run${NUM_POINTS}.sql
done

for NUM_POINTS in $@
do
    LOGFILE="logs/dbscan-${NUM_POINTS}-$(date).log"
    echo "Running $NUM_POINTS point tests..."
    psql dbscan -v ON_ERROR_STOP=1 -f run${NUM_POINTS}.sql |& tee "$LOGFILE"
done | grep -E 'Time|Query'
