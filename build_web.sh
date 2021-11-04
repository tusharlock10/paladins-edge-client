
echo "Installing AWS Cli"
pip3 install --upgrade --user awscli
export PATH=$HOME/.local/bin:$PATH
source ~/.bash_profile

echo "Printing AWS Version"
aws --version

echo "Downloading credentials from AWS"
aws configure set aws_access_key_id $PE_PRIVATE_AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $PE_EBS_AWS_SECRET_ACCESS_KEY
aws configure set default.region $AWS_REGION

aws s3 cp s3://paladinsedge-private/credentials/client/$ENV_FILE ./paladins-edge.env

echo "Cloning flutter"
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

flutter --doctor

echo "Printing env file"
cat paladins-edge.env

echo "Building web app"
flutter packages pub get
flutter config --enable-web
flutter build web --release