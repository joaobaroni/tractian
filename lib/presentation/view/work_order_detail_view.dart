import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tractian/domain/domain.dart';
import 'package:tractian/domain/usecases/usecases.dart';
import 'package:tractian/infrastructure/infrastructure.dart';
import 'package:tractian/presentation/presentation.dart';
import 'package:tractian/presentation/widgets/custom_shimmer.dart';

import '../../routes/routes.dart';
import '../mvvm/mvvm.dart';
import '../utils.dart';

class WorkOrderDetailView extends StatefulWidget {
  const WorkOrderDetailView({super.key, required this.workOrder});

  final WorkOrder workOrder;

  @override
  State<WorkOrderDetailView> createState() => _WorkOrderDetailViewState();
}

class _WorkOrderDetailViewState extends ViewState<WorkOrderDetailView, WorkOrderDetailViewModel> {
  @override
  void initState() {
    super.initState();
    viewModel.initialize(widget.workOrder);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Nav.pushNamedAndRemoveUntil(AppRoutes.workOrderEditing, (route) => route.settings.name == AppRoutes.root,
                  arguments: WorkOrderEditingArguments(
                    id: viewModel.workOrder.value.id,
                    params: WorkOrderParams(
                      assetId: viewModel.workOrder.value.assetId,
                      assignedUserIds: viewModel.workOrder.value.assignedUserIds,
                      priority: viewModel.workOrder.value.priority,
                      title: viewModel.workOrder.value.title,
                      checkList: viewModel.workOrder.value.checkList,
                      description: viewModel.workOrder.value.description,
                    ),
                  )),
          child: const Icon(Icons.edit)),
      appBar: AppBar(
        backgroundColor: context.colorPalette.primary,
        iconTheme: context.theme.iconTheme.copyWith(color: context.colorPalette.onPrimary),
        title: Text(
          '#${widget.workOrder.id}',
          style: context.textTheme.titleLarge!.copyWith(color: context.colorPalette.onPrimary),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ViewModelBuilder<WorkOrderDetailViewModel>(
            viewModel: viewModel,
            builder: (state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.md.width),
                child: SizedBox(
                    width: context.screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: Spacing.md.height),
                          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                            Icon(
                              AppIcons.machine,
                              color: context.colorPalette.primary,
                            ),
                            Spacing.xs.horizontal,
                            Text(
                              state.workOrder.value.title,
                              style: TextStyle(
                                fontSize: 24.fontSize,
                                color: const Color(0xFF24292F),
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ]),
                        ),
                        Text(
                          'Status (Click to refresh)',
                          style: TextStyle(
                            fontSize: 16.fontSize,
                            color: const Color(0xFF24292F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacing.sm.vertical,
                        Row(
                          children: [
                            ...WorkOrderStatus.values
                                .map((item) => Padding(
                                      padding: (item.index + 1) % 2 == 0
                                          ? EdgeInsets.symmetric(horizontal: 12.responsiveWidth)
                                          : EdgeInsets.zero,
                                      child: _StatusChangeButton(
                                        isSelected: item == state.workOrder.value.status,
                                        onTap: (newStatus) => viewModel.updateStatus(newStatus),
                                        status: item,
                                      ),
                                    ))
                                .toList(),
                          ],
                        ),
                        Spacing.md.vertical,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: _section(context, title: 'Assignee', children: [
                              if (state.assignedUsers.value == null) ...[
                                _assigneeTile(null)
                              ] else if (state.assignedUsers.value!.isEmpty) ...[
                                const Text('No assignees')
                              ] else ...[
                                for (final user in state.assignedUsers.value!) _assigneeTile(user)
                              ]
                            ])),
                            _section(
                              context,
                              title: 'Priority',
                              children: [
                                RoundedTag(
                                    label: Text(state.workOrder.value.priority.label),
                                    backgroundColor: state.workOrder.value.priority.color)
                              ],
                            ),
                            Spacing.md.vertical,
                          ],
                        ),
                        Spacing.md.vertical,
                        _section(
                          context,
                          title: 'Asset',
                          children: [
                            InkWell(
                              onTap: state.assetDetails.value != null
                                  ? () => Nav.pushNamed(AppRoutes.assetDetail, arguments: state.assetDetails.value!)
                                  : null,
                              child: Row(
                                children: [
                                  CustomShimmer(
                                    loading: state.assetDetails.value == null,
                                    baseColor: Colors.grey[300],
                                    child: Icon(
                                      AppIcons.cube,
                                      color: context.colorPalette.primary,
                                    ),
                                  ),
                                  Spacing.xs.horizontal,
                                  CustomShimmerArea(
                                    loading: state.assetDetails.value == null,
                                    child: Text(state.assetDetails.value?.name ?? 'Unkwnown'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Spacing.md.vertical,
                        if (state.workOrder.value.description != null && state.workOrder.value.description!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(bottom: Spacing.md.height),
                            child: _section(
                              context,
                              title: 'Description',
                              children: [
                                Text(state.workOrder.value.description!),
                              ],
                            ),
                          ),
                        if (state.workOrder.value.checkList != null && state.workOrder.value.checkList!.isNotEmpty)
                          _section(
                            context,
                            title: 'Procedures checklist',
                            children: state.workOrder.value.checkList!
                                .map((e) => CustomCheckbox.standard(
                                    onChanged: (value) {
                                      viewModel.updateCheckListItemStatus(
                                        e.copyWith(isCompleted: value),
                                        state.workOrder.value.checkList!.indexOf(e),
                                      );
                                    },
                                    selected: e.isCompleted,
                                    title: e.title))
                                .toList(),
                          ),
                      ],
                    )),
              );
            }),
      ),
    );
  }

  Widget _assigneeTile(User? user) {
    return Padding(
      padding: EdgeInsets.only(bottom: Spacing.xs.height),
      child: Row(children: [
        CustomShimmer(
          loading: user == null,
          child: CircleAvatar(
            maxRadius: 15.fontSize,
            backgroundColor: context.colorPalette.primaryContainer,
            child: Text(user?.name[0] ?? ''),
          ),
        ),
        Spacing.xs.horizontal,
        CustomShimmerArea(loading: user == null, child: Text(user?.name ?? 'Unkwnown')),
      ]),
    );
  }

  Widget _section(BuildContext context, {required String title, required List<Widget> children}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 16.fontSize,
          color: const Color(0xFF24292F),
          fontWeight: FontWeight.bold,
        ),
      ),
      Spacing.xs.vertical,
      ...children,
    ]);
  }
}

/// VOLTAR AQUI PARA REFATORAR
class _StatusChangeButton extends StatelessWidget {
  const _StatusChangeButton({
    super.key,
    required this.status,
    required this.onTap,
    required this.isSelected,
  });

  final WorkOrderStatus status;
  final ValueChanged<WorkOrderStatus> onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(status);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 100.responsiveWidth,
        padding: EdgeInsets.symmetric(horizontal: 12.responsiveWidth, vertical: 12.responsiveHeight),
        decoration: BoxDecoration(
          color: isSelected ? context.colorPalette.primary : context.colorPalette.onPrimary,
          border: Border.all(color: context.colorPalette.primary.withOpacity(0.3), width: 3),
          borderRadius: BorderRadius.circular(12.fontSize),
        ),
        child: Column(
          children: [
            Icon(
              status.icon,
              color: isSelected ? context.colorPalette.onPrimary : context.colorPalette.primary,
            ),
            Text(status.label,
                style: context.textTheme.labelMedium!
                    .copyWith(color: isSelected ? context.colorPalette.onPrimary : context.colorPalette.primary)),
          ],
        ),
      ),
    );
  }
}
