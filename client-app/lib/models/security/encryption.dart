import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/api.dart';
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/paddings/pkcs7.dart';

class Encryption {
  static final Uint8List _key = Uint8List.fromList(<int>[
    0x5a,
    0x22,
    0x62,
    0x7e,
    0x64,
    0x45,
    0x52,
    0x75,
    0x58,
    0x21,
    0x71,
    0x26,
    0x7a,
    0x6a,
    0x2d,
    0x2c,
    0x3e,
    0x64,
    0x7d,
    0x36,
    0x61,
    0x45,
    0x77,
    0x2d,
    0x5f,
    0x39,
    0x26,
    0x78,
    0x4a,
    0x5e,
    0x40,
    0x38
  ]);

  static final Uint8List _iv = Uint8List.fromList(
    <int>[
      0xda,
      0x39,
      0xa3,
      0xee,
      0x5e,
      0x6b,
      0x4b,
      0x0d,
      0x32,
      0x55,
      0xbf,
      0xef,
      0x95,
      0x60,
      0x18,
      0x90
    ],
  );

  static String? encrypt(String text) {
    List<int> temp = utf8.encode(text);
    Uint8List bytes = Uint8List.fromList(temp);

    Uint8List? unit8 = _encryptList(bytes);
    if (unit8 == null) {
      return null;
    }

    return base64Encode(unit8);
  }

  static Uint8List? _encryptList(Uint8List data) {
    final CBCBlockCipher cbcCipher = CBCBlockCipher(AESFastEngine());
    final ParametersWithIV<KeyParameter> ivParams =
    ParametersWithIV<KeyParameter>(KeyParameter(_key), _iv);
    final PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>
    paddingParams =
    PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>(
        ivParams, null);

    final PaddedBlockCipherImpl paddedCipher =
    PaddedBlockCipherImpl(PKCS7Padding(), cbcCipher);
    paddedCipher.init(true, paddingParams);

    try {
      return paddedCipher.process(data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}