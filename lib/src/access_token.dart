import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:agora_token_service/src/byte_buf.dart';
import 'package:agora_token_service/src/rtc_privilege.dart';
import 'package:crc32_checksum/crc32_checksum.dart';
import 'package:crypto/crypto.dart';

const version = '006';

class AccessToken {
  AccessToken({
    required this.appId,
    required this.appCertificate,
    required this.channelName,
    required this.uid,
  });

  final String appId;
  final String appCertificate;
  final String channelName;
  final String uid;
  final Map<RtcPrivilege, int> privilegeTimestamps = {};
  final int salt = (Random().nextDouble() * 0xffffffff).floor();
  final int timestamp = DateTime.now().secondsSinceEpoch + 24 * 3600;

  String build() {
    final message = ByteBuf()
        .putUint32(salt)
        .putUint32(timestamp)
        .putTreeMapUInt32(privilegeTimestamps.map(
          (privilege, timestamp) => MapEntry(privilege.id, timestamp),
        ))
        .pack();

    final toSign = Uint8List.fromList([
      ...appId.codeUnits,
      ...channelName.codeUnits,
      ...uid.codeUnits,
      ...message,
    ]);

    final signature = Uint8List.fromList(
      Hmac(sha256, appCertificate.codeUnits).convert(toSign).bytes,
    );

    final crcChannel = Crc32.calculate(channelName.codeUnits);
    final crcUid = Crc32.calculate(uid.codeUnits);

    final content = ByteBuf()
        .putBytes(signature)
        .putUint32(crcChannel)
        .putUint32(crcUid)
        .putBytes(message)
        .pack();

    return version + appId + base64.encode(content);
  }
}

extension on DateTime {
  int get secondsSinceEpoch => millisecondsSinceEpoch ~/ 1000;
}
