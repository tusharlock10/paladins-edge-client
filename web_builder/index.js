// download credentials from AWS

const { S3 } = require('@aws-sdk/client-s3');
const fs = require('fs');
const { PE_PRIVATE_AWS_ACCESS_KEY_ID, PE_EBS_AWS_SECRET_ACCESS_KEY, AWS_REGION, ENV_FILE, PE_PRIVATE_AWS_BUCKET_NAME } = process.env;


const getCredentials = async () => {
  const client = new S3({
    region: AWS_REGION, credentials: {
      accessKeyId: PE_PRIVATE_AWS_ACCESS_KEY_ID,
      secretAccessKey: PE_EBS_AWS_SECRET_ACCESS_KEY
    }
  });
  const response = await client.getObject({
    Bucket: PE_PRIVATE_AWS_BUCKET_NAME,
    Key: `credentials/client/${ENV_FILE}`
  });

  fs.writeFileSync("paladins-edge.env", response.Body)
};

getCredentials()