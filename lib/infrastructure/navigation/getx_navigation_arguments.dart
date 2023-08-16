import 'package:get/get.dart';
import 'package:tractian/domain/domain.dart';

///
/// Implementation of [NavigationArguments]
///
class GetxNavigationArguments implements NavigationArguments {
  @override
  Map<String, dynamic> get params => Get.parameters;

  @override
  dynamic get data => Get.arguments;
}
