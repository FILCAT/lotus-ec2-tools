# state-invariants-check

to set up the commander node:

1. in util run create_instance.bash
2. on the new node run aws configure
3. set up pem in ~/.ssh/aws.pem
4. add following to ~/.ssh/config:

Host *
  StrictHostKeyChecking no
