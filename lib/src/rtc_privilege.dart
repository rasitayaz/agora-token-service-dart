enum RtcPrivilege {
  joinChannel(1),
  publishAudioStream(2),
  publishVideoStream(3),
  publishDataStream(4);

  const RtcPrivilege(this.id);

  final int id;
}
