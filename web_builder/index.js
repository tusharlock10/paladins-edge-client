// download credentials from AWS

const { S3 } = require('@aws-sdk/client-s3');
const fs = require('fs');
const { PE_PRIVATE_AWS_ACCESS_KEY_ID, PE_EBS_AWS_SECRET_ACCESS_KEY, AWS_REGION, ENV_FILE, PE_PRIVATE_AWS_BUCKET_NAME } = process.env;

const streamToString = async (stream) => {
  return await new Promise((resolve, reject) => {
    const chunks = [];
    stream.on('data', (chunk) => chunks.push(chunk));
    stream.on('error', reject);
    stream.on('end', () => resolve(Buffer.concat(chunks).toString('utf-8')));
  });
}

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

  const data = await streamToString(response.Body)

  fs.writeFileSync("paladins-edge.env", data)
};

getCredentials()