import 'package:flutter/material.dart';
import 'package:tractian/domain/enums/enums.dart';

extension AssetStatusExtension on AssetStatus {
  String get label {
    switch (this) {
      case AssetStatus.inAlert:
        return 'In Alert';
      case AssetStatus.inDowntime:
        return 'Offline';
      case AssetStatus.inOperation:
        return 'In Operation';
      case AssetStatus.plannedStop:
        return 'Planned Stop';
      case AssetStatus.unplannedStop:
        return 'Nnplanned Stop';
    }
  }

  Color get color {
    switch (this) {
      case AssetStatus.inAlert:
        return const Color(0xFFee4733);
      case AssetStatus.inDowntime:
        return const Color(0xFFd1cfcf);
      case AssetStatus.inOperation:
        return const Color(0xFF65c51d);
      case AssetStatus.plannedStop:
        return const Color(0xFF51caca);
      case AssetStatus.unplannedStop:
        return const Color(0xFFfaae31);
    }
  }
}
