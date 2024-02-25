import "dart:convert";
import "dart:typed_data";

import "package:encrypt/encrypt.dart";
import "package:flutter/services.dart" show rootBundle;
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:pointycastle/export.dart";

/// Class for RSA encryption
abstract class RSACrypto {
  static final _cipher = PKCS1Encoding(RSAEngine());

  /// Loads the public key from the assets.
  static Future<void> initialize() async {
    utilities.Stopwatch.startStopTimer("initializeRSACrypto");
    final publicKey = await rootBundle.loadString("assets/keys/publicKey.pem");

    final parser = RSAKeyParser();
    final public = parser.parse(publicKey) as RSAPublicKey;

    _cipher.init(true, PublicKeyParameter<RSAPublicKey>(public));
    utilities.Stopwatch.startStopTimer("initializeRSACrypto");
  }

  /// Encrypts the given text using the public key.
  static String encryptRSA(String text) {
    // add salt in the plain text
    final saltedText = "${constants.Env.saltString}:$text";

    final output = _cipher.process(Uint8List.fromList(utf8.encode(saltedText)));

    return base64Encode(output);
  }
}
