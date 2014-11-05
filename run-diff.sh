#!/usr/bin/env bash
set -eu

query=${1}
db1=${2}
db2=${3}

cat ID-${query}-hits2-${db1} ID-${query}-hitby-${db1} | sort -u > tmpID-${query}${db1}
cat ID-${query}-hits2-${db2} ID-${query}-hitby-${db2} | sort -u > tmpID-${query}${db2}
cat tmpID-${query}${db1} tmpID-${query}${db2} | sort    > tmp1-${query}
cat tmpID-${query}${db1} tmpID-${query}${db2} | sort -u > tmp2-${query}
diff tmp1-${query} tmp2-${query} | egrep '^<' | cut -c3- > vID-${query}${db1}${db2}
diff tmpID-${query}${db1} vID-${query}${db1}${db2} | egrep '^<' | cut -c3- > vID-${query}${db1}
diff tmpID-${query}${db2} vID-${query}${db1}${db2} | egrep '^<' | cut -c3- > vID-${query}${db2}
cat vID-${query}${db1}${db2} vID-${query}${db1} vID-${query}${db2} | sort -u > tmp1-${query}
diff ID-${query}PRT tmp1-${query} | egrep '^<' | cut -c3- > vID-${query}
rm tmp1-${query} tmp2-${query} tmpID-${query}*
