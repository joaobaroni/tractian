import 'package:flutter/material.dart';

import '../presentation.dart';

class WorkOrderCreationView extends WorkOrderManagementView {
  @override
  State<StatefulWidget> createState() => _WorkOrderCreationViewState();
}

class _WorkOrderCreationViewState
    extends WorkOrderManagementViewState<WorkOrderCreationView, WorkOrderCreationViewModel> {
  @override
  String get appBarLabel => 'New Work Order';
}
