part of 'custom_checkbox.dart';

class _EditableCustomCheckbox extends CustomCheckbox {
  final String? initialValue;
  final ValueChanged<String> onContentChange;

  const _EditableCustomCheckbox({
    required super.onChanged,
    required super.selected,
    this.initialValue,
    required this.onContentChange,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<_EditableCustomCheckbox> {
  final TextEditingController controller = TextEditingController();
  FocusNode focus = FocusNode();
  bool editing = false;
  bool selected = false;

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
    controller.text = widget.initialValue ?? '';
    if (controller.text.isEmpty) {
      editing = true;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Future.delayed(const Duration(milliseconds: 400), () => focus.requestFocus());
      });
    }

    controller.addListener(() {
      if (mounted) setState(() {});
    });

    focus.addListener(() {
      if (!focus.hasFocus) {
        editing = false;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Checkbox(
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: selected,
        onChanged: (value) {
          selected = value ?? false;
          widget.onChanged?.call(selected);
          setState(() {});
        },
      ),
      Spacing.xs.horizontal,
      Expanded(
        child: AnimatedCrossFade(
          crossFadeState: editing ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
          secondChild: TextField(
            controller: controller,
            focusNode: focus,
            onChanged: (value) {
              widget.onContentChange(value);
            },
            onSubmitted: (_) {
              setState(() {
                editing = !editing;
              });
            },
          ),
          firstChild: GestureDetector(
            child: Text(
              controller.text,
              style: TextStyle(
                fontSize: 14.fontSize,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
