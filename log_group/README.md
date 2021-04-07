unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
export AWS_PAGER=""
export AWS_REGION=us-east-1
export AWS_DEFAULT_REGION=us-east-1
export AWS_ACCESS_KEY_ID=$(sed -n 2p ~/vpn/HMG-accessKeys.csv | awk -F',' '{print $1}' | tr -d '[:space:]')
export AWS_SECRET_ACCESS_KEY=$(sed -n 2p ~/vpn/HMG-accessKeys.csv | awk -F',' '{print $2}' | tr -d '[:space:]')