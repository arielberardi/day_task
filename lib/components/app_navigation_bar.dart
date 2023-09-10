import 'package:flutter/material.dart';

class AppNavigationBar extends StatefulWidget {
  final Color color;
  final Color? selectedColor;
  final List<BarItemData> items;
  final Function(int) onChanged;

  const AppNavigationBar({
    super.key,
    required this.color,
    this.selectedColor,
    required this.items,
    required this.onChanged,
  });

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int _currentItem = 0;

  void onDestinationSelected(int value) {
    setState(() => _currentItem = value);
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      height: 70,
      child: Row(
        children: List.generate(
          widget.items.length,
          (index) => BarItem(
            onTap: () => onDestinationSelected(index),
            selected: _currentItem == index,
            icon: widget.items[index].icon,
            label: widget.items[index].label,
            color: widget.color,
            selectedColor: widget.selectedColor,
            child: widget.items[index].child,
          ),
        ),
      ),
    );
  }
}

class BarItemData {
  final IconData? icon;
  final String? label;
  final Widget? child;

  const BarItemData({
    this.icon,
    this.label,
    this.child,
  });
}

class BarItem extends StatelessWidget {
  final VoidCallback onTap;
  final bool selected;
  final Widget? child;
  final IconData? icon;
  final String? label;
  final Color color;
  final Color? selectedColor;

  const BarItem({
    super.key,
    required this.onTap,
    required this.selected,
    this.child,
    this.icon,
    this.label,
    required this.color,
    this.selectedColor,
  })  : assert(icon != null || child != null,
            'BarItem: requires Icon or a Widget'),
        assert(icon == null || child == null,
            'BarItem: only can have an Icon or a Widget, no both');

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: child ??
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: selected ? selectedColor ?? color : color,
                ),
                generateLabel(context, label),
              ],
            ),
      ),
    );
  }

  Widget generateLabel(BuildContext context, String? label) {
    if (label == null) {
      return Container();
    }

    return Text(
      label,
      softWrap: false,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontSize: 10,
            color: selected ? selectedColor ?? color : color,
          ),
    );
  }
}
