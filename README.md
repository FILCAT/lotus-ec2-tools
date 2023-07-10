# state-invariants-check

to set up the commander node:

1. in util run create_instance.bash
2. on the new node run aws configure
3. set up pem in ~/.ssh/aws.pem
4. add following to ~/.ssh/config:
```
Host *
  StrictHostKeyChecking no
```
5. `crontab -e` to add the `crontab` file to the crontab


To run a task like the snapshot state summary run the command:

./run_task.bash snapshot_state_summary
