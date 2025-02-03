import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_search/data/models/job.dart';
import 'package:job_search/ui/core/themes/theme.dart';
import 'package:job_search/utils/brightness_shift.dart';

final _dateFormatter = DateFormat.yMMMd();

class JobListItem extends StatefulWidget {
  final Job job;
  final Function(Job) onSelect;
  final Function(Job) onDelete;

  const JobListItem({
    super.key,
    required this.job,
    required this.onDelete,
    required this.onSelect,
  });

  @override
  State<JobListItem> createState() => _JobListItemState();
}

class _JobListItemState extends State<JobListItem> {
  var deletionProgress = 0.0;

  void onTapped() {
    widget.onSelect(widget.job);
  }

  void onDismissUpdate(DismissUpdateDetails details) {
    setState(() {
      deletionProgress = details.progress;
    });
  }

  void onDismissed(DismissDirection direction) {
    widget.onDelete(widget.job);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Colors for item
    final background = theme.colorScheme.primaryContainer;
    final shadow = background.darken(0.1);

    // Colors for dismissible "leave behind"
    final deletionBackground = theme.colorScheme.error;
    final deletionShadow = deletionBackground.darken(0.1);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: ClipRRect(
        borderRadius: BorderRadius.all(AppTheme.radius),
        child: Dismissible(
          onUpdate: onDismissUpdate,
          onDismissed: onDismissed,
          key: Key(widget.job.id),
          direction: DismissDirection.endToStart,
          background: Container(
            margin: const EdgeInsets.only(bottom: 4),
            padding: const EdgeInsets.only(right: 10),
            decoration: AppTheme.getBoxDecoration(
              background: deletionBackground,
              shadow: deletionShadow,
              borderRadius: BorderRadius.all(AppTheme.radius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Delete",
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.onError,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.delete,
                  color: theme.colorScheme.onError,
                ),
              ],
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 4),
            decoration: AppTheme.getBoxDecoration(
              shadow: Color.lerp(
                shadow,
                deletionShadow,
                deletionProgress,
              )!,
            ),
            child: Material(
              color: Color.lerp(
                background,
                deletionBackground,
                deletionProgress,
              ),
              borderRadius: BorderRadius.only(
                topLeft: AppTheme.radius,
                topRight:
                    deletionProgress > 0.0 ? Radius.zero : AppTheme.radius,
                bottomLeft: AppTheme.radius,
                bottomRight:
                    deletionProgress > 0.0 ? Radius.zero : AppTheme.radius,
              ),
              child: ListTile(
                onTap: () {},
                title: Text(
                  widget.job.title,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                subtitle: Text(
                  widget.job.company,
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
