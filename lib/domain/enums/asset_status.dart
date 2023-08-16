///
/// Enum representing the operational status of an asset.
///
enum AssetStatus {
  ///
  /// The asset is currently offline and not operational.
  ///
  inDowntime,

  ///
  /// The asset is undergoing a planned stop or scheduled maintenance.
  ///
  plannedStop,

  ///
  /// The asset is currently in operation.
  ///
  inOperation,

  ///
  /// The asset is undergoing an unplanned stop or downtime.
  ///
  unplannedStop,

  ///
  /// The asset is in an alert state, possibly indicating a potential issue.
  ///
  inAlert,
}
