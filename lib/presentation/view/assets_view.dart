import 'package:flutter/material.dart';
import 'package:tractian/infrastructure/infrastructure.dart';
import 'package:tractian/presentation/extensions/build_context_extension.dart';
import 'package:tractian/presentation/mvvm/mvvm.dart';
import 'package:tractian/presentation/viewmodel/assets_viewmodel.dart';
import 'package:tractian/presentation/widgets/custom_tile.dart';
import 'package:tractian/routes/routes.dart';

import '../utils.dart';

class AssetsView extends StatefulWidget {
  const AssetsView({super.key});

  @override
  State<AssetsView> createState() => _AssetsViewState();
}

class _AssetsViewState extends ViewState<AssetsView, AssetsViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorPalette.primary,
        iconTheme: context.theme.iconTheme.copyWith(color: context.colorPalette.onPrimary),
        title: Text(
          'Assets',
          style: context.textTheme.titleLarge!.copyWith(color: context.colorPalette.onPrimary),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
          width: context.screenWidth,
          child: ViewModelBuilder<AssetsViewModel>(
            builder: (state) {
              if (state.isLoading.value) return const Center(child: CircularProgressIndicator());
              return ListView.builder(
                itemBuilder: (context, index) => CustomTile.asset(
                    onTap: () => Nav.pushNamed(AppRoutes.assetDetail, arguments: state.assetItems.value[index]),
                    asset: state.assetItems.value[index]),
                itemCount: state.assetItems.value.length,
              );
            },
            viewModel: viewModel,
          )),
    );
  }
}
