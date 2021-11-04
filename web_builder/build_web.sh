echo "Installing dependencies"
cd web_builder
npm install
cd ..

echo "Downloading credentials"
node ./web_builder/index.js
ls

echo "Cloning flutter";
git clone https://github.com/flutter/flutter.git -b stable > /dev/null;
export PATH="$PATH:`pwd`/flutter/bin";

flutter --version > /dev/null;
flutter --doctor;

echo "Printing env file";
cat paladins-edge.env;

echo "Building web app";
flutter packages pub get;
flutter config --enable-web;
flutter build web --release;