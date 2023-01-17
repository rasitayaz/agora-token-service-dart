import 'package:agora_token_service/agora_token_service.dart';
import 'package:agora_token_service/src/rtc_role.dart';

void main() {
  final appId = '970CA35de60c44645bbae8a215061b33';
  final appCertificate = '5CFd2fd1755d40ecb72977518be15d3b';
  final channelName = '7d72365eb983485397e3e3f9d460bdda';
  final uid = '2882341273';
  final role = RtcRole.publisher;

  final expirationInSeconds = 3600;
  final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  final expireTimestamp = currentTimestamp + expirationInSeconds;

  final token = RtcTokenBuilder.build(
    appId: appId,
    appCertificate: appCertificate,
    channelName: channelName,
    uid: uid,
    role: role,
    expireTimestamp: expireTimestamp,
  );

  print('token: $token');
}
