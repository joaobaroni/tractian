part of 'custom_checkbox.dart';

class _StandardCustomCheckBox extends CustomCheckbox {
  const _StandardCustomCheckBox({
    required super.onChanged,
    required super.selected,
    required this.title,
  });

  final String title;

  @override
  State<CustomCheckbox> createState() => _StandardCheckBox();
}

class _StandardCheckBox extends State<_StandardCustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: widget.selected,
          onChanged: widget.onChanged,
        ),
        Spacing.xs.horizontal,
        Expanded(
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 14.fontSize,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
