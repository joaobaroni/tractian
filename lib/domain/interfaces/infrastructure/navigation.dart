import 'package:flutter/widgets.dart';

import 'navigation_arguments.dart';

///
/// Interface for navigation
///
abstract class Navigation {
  /// Returns the [NavigationArguments] instance
  NavigationArguments get args;

  ///
  /// Push a named route to the stack
  ///
  Future<T?> pushNamed<T extends Object?>(Object path, {Object? arguments});

  ///
  /// Push and replace a named route
  ///
  Future<Object?> pushReplacementNamed(Object path, {Object? arguments});

  ///
  /// Push a named route and remove routes according to [predicate]
  ///
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    Object path,
    bool Function(Route) predicate, {
    Object? arguments,
  });

  ///
  /// Removes all previous routes and navigate to a route.
  ///
  void navigate(Object path, {dynamic arguments});

  ///
  /// Pop the current route out of the stack
  ///
  void pop<T extends Object>({T? response});

  ///
  /// Calls pop repeatedly on the navigator until the predicate returns true.
  ///
  void popUntil(bool Function(Route<dynamic>) predicate);

  ///
  /// Return true if route can pop
  ///
  bool canPop();

  /// Pop the current route off the navigator and navigate to a route
  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(String routeName, {TO? result, Object? arguments});

  ///
  /// Consults the current route's [Route.willPop] method, and acts accordingly, potentially popping the route as a result;
  /// returns whether the pop request should be considered handled.
  ///
  Future<bool> maybePop<T extends Object?>([T? result]);
}
