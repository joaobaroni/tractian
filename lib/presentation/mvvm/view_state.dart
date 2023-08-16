import 'package:flutter/material.dart';

import 'mvvm.dart' as custom;

/// An abstract class to inject a [ViewModel] into a page/widget
/// and dispose the [ViewModel] when the widget is disposed.
abstract class ViewState<S extends StatefulWidget, M extends custom.ViewModel> extends State<S> with custom.View<M> {
  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }
}
