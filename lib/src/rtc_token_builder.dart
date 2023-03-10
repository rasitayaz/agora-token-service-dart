import 'package:agora_token_service/src/access_token.dart';
import 'package:agora_token_service/src/rtc_privilege.dart';
import 'package:agora_token_service/src/rtc_role.dart';

/// A helper class to build a token for Agora WebRTC connection.
class RtcTokenBuilder {
  RtcTokenBuilder._();

  /// Builds a token with the given properties.
  static String build({
    required String appId,
    required String appCertificate,
    required String channelName,
    required String uid,
    required RtcRole role,
    required int expireTimestamp,
  }) {
    final token = AccessToken(
      appId: appId,
      appCertificate: appCertificate,
      channelName: channelName,
      uid: uid,
    );

    token.privilegeTimestamps[RtcPrivilege.joinChannel] = expireTimestamp;
    if (role == RtcRole.publisher) {
      token.privilegeTimestamps[RtcPrivilege.publishAudioStream] =
          expireTimestamp;
      token.privilegeTimestamps[RtcPrivilege.publishVideoStream] =
          expireTimestamp;
      token.privilegeTimestamps[RtcPrivilege.publishDataStream] =
          expireTimestamp;
    }

    return token.build();
  }
}
