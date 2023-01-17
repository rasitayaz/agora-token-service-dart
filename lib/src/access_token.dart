import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:agora_token_service/src/byte_buf.dart';
import 'package:agora_token_service/src/crc32.dart';
import 'package:agora_token_service/src/rtc_privilege.dart';
import 'package:crypto/crypto.dart';

const version = '006';

/// Token required for Agora WebRTC connection.
class AccessToken {
  AccessToken({
    required this.appId,
    required this.appCertificate,
    required this.channelName,
    required this.uid,
  });

  /// App ID issued to you by Agora.
  final String appId;

  /// App Certificate issued to you by Agora.
  final String appCertificate;

  /// Name of the Agora Channel you wish to join.
  final String channelName;

  /// User ID of the user joining the Agora Channel.
  final String uid;

  /// Timestamps when the privileges will expire.
  final Map<RtcPrivilege, int> privilegeTimestamps = {};

  /// Salt required to generate a signature.
  final int salt = (Random().nextDouble() * 0xffffffff).floor();

  /// Timestamp when the token will expire.
  final int timestamp = DateTime.now().secondsSinceEpoch + 24 * 3600;

  /// Builds the token with the given properties.
  String build() {
    final message = ByteBuf()
        .putUint32(salt)
        .putUint32(timestamp)
        .putUint32Map(privilegeTimestamps.map(
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
