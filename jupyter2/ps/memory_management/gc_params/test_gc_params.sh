S=20000
M=1000
N=10000

# Add necessary parameters or environment variables as necessary for testing different GC parameters
/usr/bin/time ${exe} ${S} ${M} ${N} 2>&1

