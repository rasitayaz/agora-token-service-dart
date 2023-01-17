# Agora Token Service for Dart

[![pub](https://img.shields.io/pub/v/agora_token_service.svg?style=popout)](https://pub.dartlang.org/packages/agora_token_service)
[![github](https://img.shields.io/badge/github-rasitayaz-red)](https://github.com/rasitayaz)
[![buy me a coffee](https://img.shields.io/badge/buy&nbsp;me&nbsp;a&nbsp;coffee-donate-green)](https://www.buymeacoffee.com/RasitAyaz)

This is an unofficial Dart library for generating [Agora.io](https://www.agora.io/) WebRTC tokens. It is based on Agora's Node.js token service implementation [in this repository](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/nodejs).

You can use it in your Dart server to create [Agora WebRTC](https://www.agora.io/en/developer/webrtc/) access tokens.

## Usage

Check [example](https://pub.dev/packages/agora_token_service/example) for basic usage.

```dart
final token = RtcTokenBuilder.build(
  appId: appId,
  appCertificate: appCertificate,
  channelName: channelName,
  uid: uid,
  role: role,
  expireTimestamp: expireTimestamp,
);
```

## Contribution

This library is currently only used for token generation, you can [contribute here](https://github.com/rasitayaz/agora-token-service-dart) by implementing other features included in [Agora's official implementation](https://github.com/AgoraIO/Tools).