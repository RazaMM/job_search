import 'package:flutter/material.dart';
import 'package:job_search/data/models/job.dart';
import 'package:job_search/ui/jobs/job_list_item.dart';
import 'package:job_search/utils/brightness_shift.dart';

class JobList extends StatelessWidget {
  final List<Job> jobs;
  final String emptyText;

  const JobList({
    super.key,
    required this.jobs,
    this.emptyText = "No jobs saved.",
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (jobs.isEmpty) {
      return Center(
        child: Text(
          emptyText,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(15.0),
      itemBuilder: (context, index) {
        final job = jobs[index];

        return JobListItem(
          key: ValueKey(job.id),
          job: job,
          onSelect: (job) {
            print('Selected: $job');
          },
          onDelete: (job) {
            print('Deleting: $job');
          },
        );
      },
      itemCount: jobs.length,
    );
  }
}
