#!/bin/bash
set -eux

INSTANCE_PUBLIC_DNS="$1"

new_file="check-invariants-`date +"%Y-%m-%d-%H-%M-%S"`.out"
ssh -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS bash /mnt/data/state-invariants-check/tasks/state_invariants_check/run_state_invariants_check.bash $new_file
scp -i  ~/.ssh/aws.pem  ubuntu@$INSTANCE_PUBLIC_DNS:/mnt/data/$new_file .

# Count the number of lines in the file
line_count=$(wc -l < "$new_file")

# Check if the line count is greater than 3 meaning errors were printed
if [[ $line_count -gt 3 ]]; then




	#ping slack
	slack_file=$(mktemp)
	python3 /mnt/data/state-invariants-check/tasks/state_invariants_check/format_for_slack.py <(cat $new_file |grep 'got the following error' | cut -f2,3,4 -d: | sed -E 's/[[:alpha:]]*[[:digit:]]+[[:alpha:]]*|#+/#####/g'  | sed -E 's/#+/#/g' |sort |uniq -c|sort -nr) >  $slack_file
	curl -X POST -H 'Content-type: application/json' -d @$slack_file $SLACK_HOOK_URL
	rm -rf $slack_file
fi
