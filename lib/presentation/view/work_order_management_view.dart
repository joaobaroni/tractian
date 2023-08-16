import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian/domain/domain.dart';
import 'package:tractian/infrastructure/infrastructure.dart';
import 'package:tractian/presentation/presentation.dart';
import 'package:tractian/presentation/widgets/custom_shimmer.dart';

import '../mvvm/mvvm.dart';
import '../utils.dart';

abstract class WorkOrderManagementView extends StatefulWidget {
  const WorkOrderManagementView({super.key});
}

abstract class WorkOrderManagementViewState<View extends WorkOrderManagementView,
    ViewModel extends WorkOrderManagementViewModel> extends ViewState<View, ViewModel> {
  final TextEditingController titleTextEditingController = TextEditingController();
  final TextEditingController descriptionTextEditingController = TextEditingController();

  final GlobalKey<SliverAnimatedListState> animatedList = GlobalKey();

  String get appBarLabel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorPalette.primary,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: context.colorPalette.onPrimary),
        title: Text(
          appBarLabel,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: context.colorPalette.onPrimary),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.md.width),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: SizedBox(
              width: context.screenWidth,
              child: Form(
                child: ViewModelBuilder<WorkOrderManagementViewModel>(
                    viewModel: viewModel,
                    builder: (state) {
                      return Column(
                        children: [
                          TextFormField(
                            controller: titleTextEditingController,
                            decoration: const InputDecoration(hintText: 'What needs to be done?'),
                          ),
                          Spacing.md.vertical,
                          _section(context, title: 'Description', children: [
                            TextFormField(
                              decoration: const InputDecoration(hintText: 'Add a description'),
                              controller: descriptionTextEditingController,
                            )
                          ]),
                          Spacing.md.vertical,
                          _section(context, title: 'Asset', children: [
                            Spacing.xs.vertical,
                            dropdownField<Asset>(
                              context,
                              currentValue: state.selectedAsset,
                              itemBuilder: (value) => Text(value.name),
                              items: state.availableAssets.value ?? [],
                              onChanged: (item) {
                                viewModel.selectedAsset = item;
                              },
                            )
                          ]),
                          Spacing.md.vertical,
                          _section(context, title: 'Assignees', children: [
                            Spacing.xs.vertical,
                            SizedBox(
                              width: context.screenWidth,
                              child: _AssigneesChips(
                                isLoading: state.availableUsers.value == null,
                                onSelectionChange: (selection) =>
                                    viewModel.updateSelectedUsers(selection.$1, selection.$2),
                                selectedUsers: state.selectedUsers,
                                users: state.availableUsers.value ?? [],
                              ),
                            ),
                          ]),
                          Spacing.md.vertical,
                          _section(context, title: 'Priority', children: [
                            Spacing.xs.vertical,
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: WorkOrderPriority.values
                                    .map((item) => _PriorityChangeButton(
                                          onChanged: (value) => viewModel.updatePriority(value),
                                          priority: item,
                                          selected: item == state.priority.value,
                                        ))
                                    .toList()),
                          ]),
                        ],
                      );
                    }),
              ),
            )),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: Spacing.md.height, bottom: Spacing.xs.height),
                child: Text(
                  'Procedures checklist',
                  style: TextStyle(
                    fontSize: 16.fontSize,
                    color: const Color(0xFF24292F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Obx(
              () => SliverAnimatedList(
                key: animatedList,
                initialItemCount: viewModel.checkListItems.value.length,
                itemBuilder: (context, index, animation) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: CustomCheckbox.editable(
                        onChanged: (value) {
                          final item = viewModel.checkListItems.value[index];
                          viewModel.checkListItems.value[index] = item.copyWith(isCompleted: value ?? false);
                        },
                        selected: viewModel.checkListItems.value[index].isCompleted,
                        initialValue: viewModel.checkListItems.value[index].title,
                        onContentChange: (value) {
                          final item = viewModel.checkListItems.value[index];
                          viewModel.checkListItems.value[index] = item.copyWith(title: value);
                        }),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Spacing.md.height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        viewModel.addCheckListItem();
                        animatedList.currentState?.insertItem(viewModel.checkListItems.value.length - 1);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: Spacing.xs.height),
                        height: Spacing.md.height,
                        width: 80.responsiveWidth,
                        decoration: BoxDecoration(
                            border: Border.all(color: context.colorPalette.primary),
                            color: context.colorPalette.onPrimary,
                            borderRadius: BorderRadius.circular(3.fontSize)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: context.colorPalette.primary,
                              size: 14.fontSize,
                            ),
                            Spacing.xs.horizontal,
                            Text(
                              'Add Item',
                              style: TextStyle(
                                color: context.colorPalette.primary,
                                fontSize: 12.fontSize,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await viewModel.saveWorkOrder(
                            title: titleTextEditingController.text, description: descriptionTextEditingController.text);
                        Nav.pop();
                      },
                      child: Container(
                        height: 40.responsiveHeight,
                        decoration: BoxDecoration(
                            color: context.colorPalette.primary, borderRadius: BorderRadius.circular(3.fontSize)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              AppIcons.save,
                              color: context.colorPalette.onPrimary,
                            ),
                            Spacing.xs.horizontal,
                            Text(
                              'SAVE',
                              style: TextStyle(
                                color: context.colorPalette.onPrimary,
                                fontSize: 16.fontSize,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox dropdownField<T extends Object>(
    BuildContext context, {
    required List<T> items,
    required T? currentValue,
    required Widget Function(T value) itemBuilder,
    required ValueChanged<T?> onChanged,
  }) {
    return SizedBox(
      height: Spacing.xl.height,
      child: DropdownButtonFormField<T>(
        value: currentValue,
        elevation: 1,
        dropdownColor: context.colorPalette.surface,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
        style: const TextStyle(
          color: Colors.black,
        ),
        onChanged: (T? value) {
          onChanged(value);
        },
        items: items.map<DropdownMenuItem<T>>((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: itemBuilder(value),
          );
        }).toList(),
      ),
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
      ...children,
    ]);
  }
}

class _AssigneesChips extends StatelessWidget {
  const _AssigneesChips({
    required this.users,
    required this.isLoading,
    required this.selectedUsers,
    required this.onSelectionChange,
  });

  final List<User> users;
  final List<User> selectedUsers;
  final ValueChanged<(User, bool)> onSelectionChange;
  final bool isLoading;

  Widget _chipItem(User? user) {
    return FilterChip(
      showCheckmark: false,
      selected: selectedUsers.contains(user),
      label: Text(
        user?.name ?? 'Unkwnown',
      ),
      onSelected: (bool value) {
        if (user != null) onSelectionChange((user, value));
      },
    );
  }

  Widget _loadingWidgets() {
    return CustomShimmer(
      loading: true,
      baseColor: Colors.grey[300],
      child: Container(
        height: Spacing.xl.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.fontSize),
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      crossFadeState: isLoading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      secondChild: Row(
        children: [
          Expanded(child: _loadingWidgets()),
          Spacing.xs.horizontal,
          Expanded(child: _loadingWidgets()),
          Spacing.xs.horizontal,
          Expanded(child: _loadingWidgets())
        ],
      ),
      firstChild: Wrap(
        spacing: Spacing.md.width,
        alignment: WrapAlignment.center,
        children: [
          if (users.isNotEmpty) ...[for (final user in users) _chipItem(user)]
        ],
      ),
    );
  }
}

class _PriorityChangeButton extends StatelessWidget {
  const _PriorityChangeButton({
    super.key,
    required this.priority,
    required this.onChanged,
    required this.selected,
  });

  final WorkOrderPriority priority;
  final ValueChanged<WorkOrderPriority> onChanged;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(priority);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 94.responsiveWidth,
        padding: EdgeInsets.all(10.fontSize),
        decoration: BoxDecoration(
          color: selected ? priority.color : context.colorPalette.onPrimary,
          border: Border.all(color: priority.color),
          borderRadius: BorderRadius.circular(10.fontSize),
        ),
        child: Center(
          child: Text(
            priority.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: selected ? context.colorPalette.onPrimary : priority.color,
            ),
          ),
        ),
      ),
    );
  }
}

class CheckListItemParams {
  CheckListItemParams({this.title, this.isCompleted = false});

  String? title;
  bool isCompleted;
}
