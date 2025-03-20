import 'package:flutter/material.dart';
import 'package:job_search/data/models/job.dart';
import 'package:job_search/ui/jobs/job_list_item.dart';

class JobList extends StatelessWidget {
  const JobList({
    super.key,
    required this.jobs,
    required this.onSelect,
    required this.onDelete,
    this.query,
    this.emptyText = "No jobs saved.",
  });

  final List<Job> jobs;
  final Function(Job) onSelect;
  final Function(Job) onDelete;
  final String? query;
  final String emptyText;

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

    final filteredJobs = (query == null || query!.isEmpty)
        ? jobs
        : jobs.where((job) {
            final title = job.title.toLowerCase();
            final company = job.company.toLowerCase();
            final search = query!.toLowerCase();

            return title.contains(search) || company.contains(search);
          }).toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        final job = filteredJobs[index];

        return JobListItem(
          key: ValueKey(job.id),
          job: job,
          onSelect: onSelect,
          onDelete: onDelete,
        );
      },
      itemCount: filteredJobs.length,
    );
  }
}
