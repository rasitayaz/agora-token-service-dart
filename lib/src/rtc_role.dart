enum RtcRole {
  /// Recommended
  publisher(1),

  /// Only use this role if your scenario require authentication for [Hosting-in](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#hosting-in).
  ///
  /// In order for this role to take effect, please contact our support team
  /// to enable authentication for Hosting-in for you. Otherwise,
  /// [subscriber] still has the same privileges as [publisher].
  subscriber(2);

  const RtcRole(this.id);

  final int id;
}
