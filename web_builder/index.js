// download credentials from AWS

const { S3 } = require('@aws-sdk/client-s3');
const fs = require('fs');
const {
  PROD_ENV_FILE,
  STAGE_ENV_FILE,
  PE_PRIVATE_AWS_ACCESS_KEY_ID,
  PE_PRIVATE_AWS_SECRET_ACCESS_KEY,
  PE_AWS_REGION,
  PE_PRIVATE_AWS_S3_BUCKET_NAME,

  CONTEXT
} = process.env;

const ENV_FILE = CONTEXT === "production" ? PROD_ENV_FILE : STAGE_ENV_FILE;

const streamToString = async (stream) => {
  return await new Promise((resolve, reject) => {
    const chunks = [];
    stream.on('data', (chunk) => chunks.push(chunk));
    stream.on('error', reject);
    stream.on('end', () => resolve(Buffer.concat(chunks).toString('utf-8')));
  });
};

const getCredentials = async () => {
  const client = new S3({
    region: PE_AWS_REGION, credentials: {
      accessKeyId: PE_PRIVATE_AWS_ACCESS_KEY_ID,
      secretAccessKey: PE_PRIVATE_AWS_SECRET_ACCESS_KEY
    }
  });
  const response = await client.getObject({
    Bucket: PE_PRIVATE_AWS_S3_BUCKET_NAME,
    Key: `credentials/client/${ENV_FILE}`
  });

  const data = await streamToString(response.Body);

  fs.writeFileSync("paladins-edge.env", data);
};

getCredentials();