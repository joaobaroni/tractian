import 'package:flutter/material.dart';

import '../../infrastructure/infrastructure.dart';

part 'standard_custom_checkbox.dart';
part 'editable_custom_checkbox.dart';

abstract class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    super.key,
    required this.onChanged,
    required this.selected,
  });

  const factory CustomCheckbox.standard(
      {required ValueChanged<bool?> onChanged,
      required bool selected,
      required String title}) = _StandardCustomCheckBox;

  const factory CustomCheckbox.editable({
    required ValueChanged<bool?> onChanged,
    required bool selected,
    String? initialValue,
    required ValueChanged<String> onContentChange,
  }) = _EditableCustomCheckbox;

  final ValueChanged<bool?>? onChanged;
  final bool selected;
}
