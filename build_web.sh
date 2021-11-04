git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

flutter --doctor

sudo pip3 install awscli --upgrade
aws configure set aws_access_key_id $PE_PRIVATE_AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $PE_EBS_AWS_SECRET_ACCESS_KEY
aws configure set default.region $AWS_REGION

aws s3 cp s3://paladinsedge-private/credentials/client/$ENV_FILE ./paladins-edge.env

cat paladins-edge.env

flutter packages pub get
flutter config --enable-web
flutter build web --release