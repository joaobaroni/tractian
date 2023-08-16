import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import '../presentation.dart';

class WorkOrderEditingArguments {
  WorkOrderEditingArguments({required this.id, required this.params});
  final int id;
  final WorkOrderParams params;
}

class WorkOrderEditingView extends WorkOrderManagementView {
  const WorkOrderEditingView({super.key, required this.arguments});

  final WorkOrderEditingArguments arguments;

  @override
  State<StatefulWidget> createState() => WorkOrderEditingViewState();
}

class WorkOrderEditingViewState extends WorkOrderManagementViewState<WorkOrderEditingView, WorkOrderEditingViewModel> {
  @override
  void initState() {
    super.initState();
    viewModel.initialize(params: widget.arguments.params, id: widget.arguments.id);
    titleTextEditingController.text = widget.arguments.params.title;
    descriptionTextEditingController.text = widget.arguments.params.description ?? '';
  }

  @override
  String get appBarLabel => '#${widget.arguments.id}';
}
