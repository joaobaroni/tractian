import 'package:tractian/infrastructure/dependency_manager/getx_dependency_manager.dart';
import 'package:tractian/infrastructure/infrastructure.dart';

import '../domain/domain.dart';

///
/// Provides a static access to a singleton that implements [Navigation]
///
final Navigation Nav = GetxNavigation.i();

///
/// Provides a static access to a singleton that implements [DependencyManager]
///
final DependencyManager DM = GetxDependencyManager.i();
