import 'package:flutter/material.dart';
import 'package:tractian/domain/enums/work_order_priority.dart';

extension WorkOrderPriorityExtension on WorkOrderPriority {
  String get label {
    switch (this) {
      case WorkOrderPriority.high:
        return 'High';
      case WorkOrderPriority.medium:
        return 'Medium';
      case WorkOrderPriority.low:
        return 'Low';
    }
  }

  Color get color {
    switch (this) {
      case WorkOrderPriority.high:
        return const Color(0xFFf04a47);
      case WorkOrderPriority.medium:
        return const Color(0xFFe16f2d);
      case WorkOrderPriority.low:
        return const Color(0xFF50a54f);
    }
  }
}
