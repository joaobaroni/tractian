import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian/bindings/app_bindings.dart';
import 'package:tractian/routes/app_routes.dart';

import 'bootstrap.dart';
import 'infrastructure/infrastructure.dart';

void main() {
  bootstrap();
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig.init().config(constraints, orientation);
            return GetMaterialApp(
              initialBinding: AppBindings(),
              title: 'Tractian',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.instance.lightTheme,
              darkTheme: AppTheme.instance.darkTheme,
              themeMode: ThemeMode.system,
              initialRoute: AppRoutes.root,
              getPages: AppRoutes.pages(),
            );
          },
        );
      },
    );
  }
}
