import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tractian/domain/domain.dart';

class GetxDependencyManager implements DependencyManager {
  static GetxDependencyManager? _instance;

  GetxDependencyManager._();

  ///
  /// Static instance for DM
  ///
  static GetxDependencyManager i() {
    _instance ??= GetxDependencyManager._();
    return _instance!;
  }

  @override
  T get<T extends Object>() {
    return Get.find<T>();
  }

  @override
  T put<T extends Object>(T instance) {
    return Get.put<T>(instance);
  }

  @override
  void registerLazySingleton<T extends Object>(ValueGetter<T> instanceBuilder, {required bool instanceRenewal}) {
    return Get.lazyPut<T>(instanceBuilder, fenix: instanceRenewal);
  }
}
