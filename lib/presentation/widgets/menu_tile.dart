import 'package:flutter/material.dart';
import 'package:tractian/infrastructure/infrastructure.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
  });

  final VoidCallback onTap;
  final Widget title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: Spacing.md.height),
        padding: EdgeInsets.symmetric(horizontal: Spacing.lg.width, vertical: Spacing.md.height),
        width: 317.responsiveWidth,
        decoration: BoxDecoration(
          color: context.theme.primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: IconTheme(
          data: context.theme.iconTheme.copyWith(color: context.colorPalette.onPrimary),
          child: DefaultTextStyle(
            style: context.textTheme.bodyLarge!.copyWith(color: context.colorPalette.onPrimary),
            child: Row(children: [
              icon,
              Spacing.sm.horizontal,
              title,
            ]),
          ),
        ),
      ),
    );
  }
}
