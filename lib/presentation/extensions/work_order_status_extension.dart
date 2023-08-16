import 'package:flutter/material.dart';
import 'package:tractian/domain/enums/enums.dart';

extension WorkOrderStatusExtension on WorkOrderStatus {
  String get label {
    switch (this) {
      case WorkOrderStatus.done:
        return 'Done';
      case WorkOrderStatus.open:
        return 'Open';
      case WorkOrderStatus.inProgress:
        return 'In Progress';
    }
  }

  Color get color {
    switch (this) {
      case WorkOrderStatus.done:
        return const Color(0xFF65c51d);
      case WorkOrderStatus.open:
        return const Color(0xFFe16f2d);
      case WorkOrderStatus.inProgress:
        return const Color(0xFF2387fc);
    }
  }

  IconData get icon {
    switch (this) {
      case WorkOrderStatus.done:
        return Icons.check_circle_outline;
      case WorkOrderStatus.open:
        return Icons.lock_open;
      case WorkOrderStatus.inProgress:
        return Icons.sync_outlined;
    }
  }
}
