import 'package:flutter/material.dart';
import 'package:job_search/utils/brightness_shift.dart';

class BarChartData {
  const BarChartData({required this.count, required this.icon});

  final int count;
  final IconData icon;
}

class _BarChartBar extends StatelessWidget {
  const _BarChartBar({required this.data, required this.total});

  final BarChartData data;
  final int total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            data.count.toString(),
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.onPrimaryContainer.withValues(
                alpha: 0.4,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: FractionallySizedBox(
                alignment: Alignment.bottomCenter,
                heightFactor: (data.count / total).clamp(0.01, 1),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  child: Container(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Icon(
            data.icon,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ],
      ),
    );
  }
}

class BarChart extends StatelessWidget {
  final double height;
  final List<BarChartData> values;

  const BarChart({super.key, required this.height, required this.values});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final background = theme.colorScheme.primaryContainer;
    final shadow = background.darken(0.1);

    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: shadow,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          for (final value in values)
            _BarChartBar(
              data: value,
              total: values.length,
            )
        ],
      ),
    );
  }
}
