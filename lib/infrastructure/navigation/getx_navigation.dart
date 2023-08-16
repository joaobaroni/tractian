import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian/domain/domain.dart';

import '../infrastructure.dart';

class GetxNavigation implements Navigation {
  final GetxNavigationArguments _args = GetxNavigationArguments();

  GetxNavigation._();

  static GetxNavigation? _instance;

  ///
  /// Static instance for Navigation
  ///
  static GetxNavigation i() {
    _instance ??= GetxNavigation._();
    return _instance!;
  }

  @override
  NavigationArguments get args => _args;

  @override
  bool canPop() {
    return navigator!.canPop();
  }

  @override
  Future<bool> maybePop<T extends Object?>([T? result]) {
    return navigator!.maybePop(result);
  }

  @override
  void navigate(Object path, {arguments}) async {
    return Get.to(path.toString(), arguments: arguments);
  }

  @override
  void pop<T extends Object>({T? response}) {
    return navigator!.pop(response);
  }

  @override
  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(String routeName,
      {TO? result, Object? arguments}) async {
    return navigator!.popAndPushNamed(routeName, arguments: arguments, result: result);
  }

  @override
  void popUntil(bool Function(Route p1) predicate) {
    return navigator!.popUntil(predicate);
  }

  @override
  Future<T?> pushNamed<T extends Object?>(Object path, {Object? arguments}) {
    return navigator!.pushNamed(path.toString(), arguments: arguments);
  }

  @override
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(Object path, bool Function(Route p1) predicate,
      {Object? arguments}) {
    return navigator!.pushNamedAndRemoveUntil(path.toString(), predicate, arguments: arguments);
  }

  @override
  Future<Object?> pushReplacementNamed(Object path, {Object? arguments}) {
    return navigator!.pushReplacementNamed(path.toString(), arguments: arguments);
  }
}
