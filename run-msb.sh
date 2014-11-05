#!/usr/bin/env bash
set -eu

query=$(echo $1 | tr 'vs-' ' ' | cut -f 1 -d ' ')
db=$(echo $1 | tr 'vs-' ' ' | cut -f 5 -d ' ')

which MuSeqBox
MuSeqBox -i blastp-${query}-vs-${db} -q -l 24 > msb-${query}-vs-${db}
egrep no_hit msb-${query}-vs-${db} | cut -d ' ' -f 1 > ID-${query}-not-${db}
egrep ${db}PRT msb-${query}-vs-${db} | cut -c26- | cut -d ' ' -f 1 | sort -u > ID-${db}-hitby-${query}
diff ID-${query}PRT ID-${query}-not-${db} | egrep '^<' | cut -c3- > ID-${query}-hits2-${db}

