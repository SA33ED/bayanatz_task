import 'package:flutter/material.dart';

class TaskCategoryBar extends StatelessWidget {
  const TaskCategoryBar({
    required this.counts,
    required this.selectedDepartment,
    required this.onSelected,
    super.key,
  });

  final Map<String, int> counts;
  final String? selectedDepartment;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    final categories = <String>['All', ...counts.keys];
    final allCount = counts.values.fold<int>(0, (sum, value) => sum + value);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var index = 0; index < categories.length; index++) ...[
            if (index > 0) const SizedBox(width: 30),
            _CategoryItem(
              label: categories[index],
              count: categories[index] == 'All'
                  ? allCount
                  : counts[categories[index]] ?? 0,
              selected: categories[index] == 'All'
                  ? selectedDepartment == null
                  : selectedDepartment == categories[index],
              onTap: () => onSelected(
                categories[index] == 'All' ? null : categories[index],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFFE0E0E0)
                  : Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '$count',
              style: const TextStyle(
                fontFamily: 'Jost',
                fontSize: 14,
                color: Color(0xFF2D2D2D),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Jost',
              fontSize: 12,
              fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
