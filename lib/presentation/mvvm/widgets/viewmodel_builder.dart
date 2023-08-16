import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../mvvm.dart';

/// Signature for the `builder` function which takes the
/// [ViewModelState] and is responsible for returning a widget which is  to be
/// rendered.
typedef ViewModelWidgetBuilder<S> = Widget Function(S state);

/// A typedef that defines a function signature for building and manipulating view model filters.
///
/// This typedef takes a single argument of type [S] (usually representing the state) and returns an [Object].
/// It is typically used in the context of state management or view models, where it represents a function
/// that constructs filters or operations based on the current state.
///
/// If the last return value of the filter function differs from the most recent one, the associated
/// [ViewModelBuilder] is rebuilt. This mechanism ensures that changes in the filtering logic trigger
/// the necessary UI updates.
typedef ViewModelFilter<S> = Object Function(S state);

///
/// A widget that extends [GetBuilder] to simplify the integration of a [ViewModel] into the GetX state management architecture.
///
class ViewModelBuilder<T extends ViewModel> extends GetBuilder<T> {
  const ViewModelBuilder({
    required ViewModelWidgetBuilder<T> builder,
    required T viewModel,
    Key? key,
    String? id,
    ViewModelFilter<T>? filter,
  }) : super(builder: builder, global: false, init: viewModel, key: key, id: id, filter: filter);
}
