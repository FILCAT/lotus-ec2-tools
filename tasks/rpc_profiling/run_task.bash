#!/bin/bash
set -eux
export LOTUS_PATH=/mnt/lotus-data
lotus_dir=/mnt/lotus


#set fevm rpc = true in lotus config
sed -i 's/^[[:space:]]*#*[[:space:]]*EnableEthRPC[[:space:]]*=[[:space:]]*false/  EnableEthRPC = true/gI' $LOTUS_PATH/config.toml


#todo/note this isn't totally correct, we could fully sync and then run tests while it is continuing to sync in a normal way
#such that will match production. however, here what we are doing is starting up a somewhat behind lotus node
#such that lotus is syncing as fast as it can to the current network head, however in practice there would be less syncing
#this is potentially more helpful in that it somewhat unfairly gives weight to network message processing over rpc commands
#so this is a more pessimistic case than normal production
$lotus_dir/lotus daemon &
pid=$!
sleep 5s


# Address to use for testing methods requiring an Ethereum address
ETH_ADDRESS="0xd4c70007F3F502f212c7e6794b94C06F36173B36"

# Define the Ethereum methods to test
eth_methods=(
"eth_accounts"
"eth_blockNumber"
"eth_getBlockTransactionCountByNumber"
"eth_getBlockTransactionCountByHash"
"eth_getBlockByHash"
"eth_getBlockByNumber"
"eth_getTransactionByHash"
"eth_getTransactionCount"
"eth_getTransactionReceipt"
"eth_getTransactionByBlockHashAndIndex"
"eth_getTransactionByBlockNumberAndIndex"
"eth_getCode"
"eth_getStorageAt"
"eth_getBalance"
"eth_chainId"
"eth_syncing"
"eth_feeHistory"
"eth_protocolVersion"
"eth_maxPriorityFeePerGas"
"eth_gasPrice"
"eth_sendRawTransaction"
"eth_estimateGas"
"eth_call"
"eth_getLogs"
"eth_getFilterChanges"
"eth_getFilterLogs"
"eth_newFilter"
"eth_newBlockFilter"
"eth_newPendingTransactionFilter"
"eth_uninstallFilter"
"eth_subscribe"
"eth_unsubscribe"
"net_version"
"net_listening"
"web3_clientVersion"
)

# Perform stress testing on each method
for method in "${eth_methods[@]}"
do
    # Use the Ethereum address for testing methods that require it
    if [[ "$method" == "eth_getBalance" || "$method" == "eth_getTransactionCount" || "$method" == "eth_getCode" || "$method" == "eth_getStorageAt" ]]; then
        echo "Stress testing $method for address $ETH_ADDRESS..."
        $lotus_dir/lotus-bench rpc --duration=10s --method="$method:10:2000:[\"$ETH_ADDRESS\", \"latest\"]"
    elif [[ "$method" == "eth_estimateGas" ]]; then
        echo "Testing $method for address $ETH_ADDRESS..."
        $lotus_dir/lotus-bench rpc --method="$method:1:1:[{\"to\": \"$ETH_ADDRESS\"}]" --duration=5s
    else
        echo "Stress testing $method using default options..."
        $lotus_dir/lotus-bench rpc --method=$method
    fi
done

echo "Test suite completed."

kill $pid
