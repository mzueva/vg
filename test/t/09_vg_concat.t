#!/usr/bin/env bash

BASH_TAP_ROOT=../deps/bash-tap
. ../deps/bash-tap/bash-tap-bootstrap

PATH=../bin:$PATH # for vg

plan tests 1

vg construct -r small/x.fa -v small/x.vcf.gz >x.vg

num_nodes=$(vg view -g x.vg | grep ^S | wc -l)

#echo $num_nodes

is $(vg concat x.vg x.vg | vg view -g - | grep ^S | wc -l) $(echo "$num_nodes * 2" | bc) "concat doubles the number of nodes"

rm -f x.vg
