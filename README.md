
# Configuration

## Set deploy configurations as environment variables

- use LOTUS_GIT_BRANCH to set what git branch to use for lotus
- use INSTANCE_TYPE to set what instance type to use
- use LOTUS_NETWORK with either calibnet or mainnet to configure the netowrk


The defaults are: 

```
LOTUS_NETWORK=mainnet LOTUS_GIT_BRANCH=master INSTANCE_TYPE='i4i.2xlarge' ./run_task.bash TASKNAME
```

this would be equvalent to:

```
./run_task.bash TASKNAME
```

a non standard usage of the args to test state invariants on calibnet would be:

```
LOTUS_NETWORK=calibnet LOTUS_GIT_BRANCH=asr/unbork-calibnet ./run_task.bash state_invariants_check
```

running a script to create a dump file using lotus using a very large machine:

```
LOTUS_GIT_BRANCH=my/dev/branch INSTANCE_TYPE='i4i.16xlarge' ./run_task.bash lotus_snapshot
```




# Tutorial: Using the `add_task.sh` script

## Prerequisites

- Access to an EC2 instance with the necessary environment set up.
- Basic understanding of bash scripting.

## Steps

**Step 1:** Open a terminal window and navigate to the `lotus-ec2-tools/tasks` directory:

```bash
cd ~/dev/FILCAT/lotus-ec2-tools/tasks
```

**Step 2:** Execute the `add_task.sh` script:

```bash
bash add_task.sh
```

At this point, you might encounter a warning about missing version information for `libtinfo.so.6`. You can ignore this warning for now; it's not critical to the task creation process.

**Step 3:** The script will prompt you to enter a task name. Enter a name for your task, such as `profile_message_execution`, and press `Enter`.

**Step 4:** The script will create a new directory with the same name as the task you entered. This directory contains two files: `run.bash` and `run_task.bash`. You can navigate to this directory with the following command:

```bash
cd profile_message_execution
```

**Step 5:** You can view the contents of the `run.bash` and `run_task.bash` scripts by using the `cat` command:

```bash
cat run.bash
cat run_task.bash
```

**Step 6:** Edit the `run_task.bash` script to include the actual task you want to execute on the EC2 instance. You can use a text editor like `nano` or `vim` to edit this file:

```bash
nano run_task.bash
```

Replace the line `echo 'do stuff here'` with the command to execute your task. Save and exit the file when you're done.

**Step 7:** When you're ready to execute your task, you can do so by using the `run.bash` script, passing in the public DNS of your EC2 instance and the task name as arguments:

```bash
bash run.bash <INSTANCE_PUBLIC_DNS> <task_name>
```

The `run.bash` script will ssh into your EC2 instance, execute the `run_task.bash` script there, and store the output in a file on your local machine.

---

# lotus-ec2-tools

to set up the commander node:

1. in ec2 run create_instance.bash
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


---

