##
## '''
## Copyright (c) 2022, salesforce.com, inc.
## All rights reserved.
## SPDX-License-Identifier: BSD-3-Clause
## For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
## '''##
code_path=outputs/warmup_codes/
output_path=outputs/warmup_test_results/
test_path=data/APPS/train/

example_tests=0 # 0: run hidden unit tests; 1: run example unit tests
start=0
end=5000
threads=10

if [ ! -d $output_path ]
then
    echo "Directory DOES NOT exists."
    mkdir $output_path
fi

index=0
for (( i=$start;i<$end;i++ )) ; do
    echo 'testing sample index #' ${i}
    ((index++))
    (
    python gen_test_one_solution.py \
        --code_path ${code_path} \
        --output_path ${output_path} \
        --test_path $test_path \
        --example_tests $example_tests \
        --i $i
    ) &
    if (( $index % $threads == 0 )); then wait; fi
done

wait
