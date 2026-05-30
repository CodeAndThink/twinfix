/// Strategy for syncing guest data when logging into an existing account.
enum SyncStrategy {
  /// Keep local data and overwrite server data.
  keepLocal,

  /// Discard local data and restore from server.
  keepRemote,

  /// Merge local and server data (additive).
  merge,
}
