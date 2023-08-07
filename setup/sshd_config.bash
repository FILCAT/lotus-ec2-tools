#!/bin/bash

# Declare an array of environment variables
declare -a ENV_VARS=("LOTUS_GIT_BRANCH" "INSTANCE_TYPE")

for ENV_VAR in "${ENV_VARS[@]}"; do
    # Check if the variable is already in sshd_config
    grep -q "AcceptEnv $ENV_VAR" /etc/ssh/sshd_config
    
    # If it's not in the file, append it
    if [ $? -ne 0 ]; then
        echo "AcceptEnv $ENV_VAR" | sudo tee -a /etc/ssh/sshd_config
    else
        echo "Variable $ENV_VAR already accepted in sshd_config."
    fi
done

# Restart the SSH server
sudo systemctl restart sshd

echo "SSH server restarted."


