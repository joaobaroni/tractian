import 'package:flutter/widgets.dart';

///
/// Utility class to manage dependencies
///
// ignore: one_member_abstracts
abstract class DependencyManager {
  ///
  /// Get an instance of type T from the DM
  ///
  T get<T extends Object>();

  ///
  /// Put an instance of T in memory
  ///
  T put<T extends Object>(T instance);

  /// Register a lazy singleton instance of type [T].
  ///
  /// This method allows you to register a lazy singleton instance of a specified type [T].
  /// The [instanceBuilder] function is used to construct the instance when it is first requested.
  /// The [instanceRenewal] parameter controls whether the instance should be recreated
  /// every time it's requested or if the existing instance should be reused.
  void registerLazySingleton<T extends Object>(ValueGetter<T> instanceBuilder, {required bool instanceRenewal});
}
