echo "Installing dependencies"
cd web_builder
npm install
cd ..

echo "Downloading credentials"
node ./web_builder/index.js

echo "Cloning flutter";
git clone https://github.com/flutter/flutter.git
export PATH="$PATH:`pwd`/flutter/bin";
cd flutter
git checkout tags/3.16.6
cd ..
flutter precache

echo "Flutter version" && flutter --version;
echo "Flutter doctor" && flutter --doctor;

echo "Building web app";
flutter packages pub get;
flutter config --enable-web;
flutter build web --release;