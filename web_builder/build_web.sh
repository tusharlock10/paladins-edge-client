echo "Cloning flutter";
git clone https://github.com/flutter/flutter.git
export PATH="$PATH:`pwd`/flutter/bin";
cd flutter
git checkout tags/3.19.3
cd ..
flutter precache

echo "Flutter version" && flutter --version;

echo "Building web app";
flutter packages pub get;
flutter build web --release;