import 'package:flutter/material.dart';
import 'package:tractian/infrastructure/infrastructure.dart';
import 'package:tractian/presentation/extensions/build_context_extension.dart';
import 'package:tractian/presentation/presentation.dart';

import '../../routes/routes.dart';
import '../utils.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: context.colorPalette.primary,
          title: Padding(
            padding: EdgeInsets.only(left: 105.responsiveWidth),
            child: Icon(
              AppIcons.tractian,
              color: context.colorPalette.onPrimary,
              size: 17.fontSize,
            ),
          )),
      body: SizedBox(
        width: context.screenWidth,
        child: Padding(
          padding: EdgeInsets.all(Spacing.md.width),
          child: Column(
            children: [
              MenuTile(
                  icon: const Icon(AppIcons.addWorkOrder),
                  onTap: () => Nav.pushNamed(AppRoutes.workOrders),
                  title: const Text('Work Orders')),
              MenuTile(
                  icon: const Icon(AppIcons.asset),
                  onTap: () => Nav.pushNamed(AppRoutes.assets),
                  title: const Text('Assets')),
              MenuTile(icon: const Icon(AppIcons.qrCode), onTap: () {}, title: const Text('QR Code')),
            ],
          ),
        ),
      ),
    );
  }
}
