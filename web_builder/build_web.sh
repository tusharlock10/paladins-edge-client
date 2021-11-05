echo "Installing dependencies"
cd web_builder
npm install
cd ..

echo "Downloading credentials"
node ./web_builder/index.js

echo "Cloning flutter";
git clone https://github.com/flutter/flutter.git -b stable;
export PATH="$PATH:`pwd`/flutter/bin";

flutter --version;
flutter --doctor;

echo "Building web app";
flutter packages pub get;
flutter config --enable-web;
flutter build web --release;