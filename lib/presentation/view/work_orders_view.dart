import 'package:flutter/material.dart';
import 'package:tractian/presentation/mvvm/mvvm.dart';
import 'package:tractian/presentation/viewmodel/viewmodel.dart';

import '../../infrastructure/infrastructure.dart';
import '../../routes/routes.dart';
import '../utils.dart';
import '../widgets/widgets.dart';

class WorkOrdersView extends StatefulWidget {
  const WorkOrdersView({super.key});

  @override
  State<WorkOrdersView> createState() => _WorkOrdersViewState();
}

class _WorkOrdersViewState extends ViewState<WorkOrdersView, WorkOrdersViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: context.colorPalette.primary,
          iconTheme: context.theme.iconTheme.copyWith(color: context.colorPalette.onPrimary),
          title: Text(
            'Work Orders',
            style: context.textTheme.titleLarge!.copyWith(color: context.colorPalette.onPrimary),
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ViewModelBuilder<WorkOrdersViewModel>(
              viewModel: viewModel,
              builder: (state) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: Spacing.md.height,
                            left: Spacing.sm.width,
                            right: Spacing.sm.width,
                            bottom: Spacing.sm.height),
                        height: Spacing.lg.height,
                        width: MediaQuery.sizeOf(context).width,
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hintText: 'Search work order',
                                suffixIcon: const Icon(Icons.search),
                                onChanged: (value) {
                                  viewModel.searchOrderByTitle(query: value);
                                },
                              ),
                            ),
                            Spacing.sm.horizontal,
                            Container(
                              width: 40.responsiveWidth,
                              height: Spacing.lg.height,
                              decoration: BoxDecoration(
                                  color: context.colorPalette.primary, borderRadius: BorderRadius.circular(5.fontSize)),
                              child: IconButton(
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () => Nav.pushNamedAndRemoveUntil(
                                        AppRoutes.workOrderCreation,
                                        (route) => route.settings.name == AppRoutes.root,
                                      ),
                                  icon: Icon(
                                    Icons.add,
                                    color: context.colorPalette.onPrimary,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    state.isLoading.value
                        ? const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
                        : SliverFillRemaining(
                            child: ListView.builder(
                                itemBuilder: (context, index) => CustomTile.workOrder(
                                    workOrder: state.workOrdersItems.value[index],
                                    onTap: () {
                                      Nav.pushNamed(AppRoutes.workOrderDetail,
                                          arguments: state.workOrdersItems.value[index]);
                                    }),
                                itemCount: state.workOrdersItems.value.length),
                          )
                  ],
                );
              }),
        ));
  }
}
