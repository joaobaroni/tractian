import '../../domain/domain.dart';
import '../utils.dart';

/// A mixin to inject a [ViewModel] into a page/widget
///
/// See also:
///
///  * [ViewState], which disposes the [ViewModel] when the widget is disposed.
mixin View<VM extends Object> {
  /// Get the injected [ViewModel]
  final VM viewModel = DM.get<VM>();

  /// Get the current [NavigationArguments]
  final NavigationArguments args = Nav.args;
}
