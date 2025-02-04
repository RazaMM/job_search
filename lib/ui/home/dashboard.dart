import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search/data/models/job.dart';
import 'package:job_search/data/providers/jobs.dart';
import 'package:job_search/ui/core/widgets/conditional_parent.dart';
import 'package:job_search/ui/jobs/job_chart.dart';
import 'package:job_search/ui/jobs/job_list.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  final breakpoint = 720.0;

  void onJobDelete(BuildContext context, WidgetRef ref, Job job) {
    ref.read(jobsProvider.notifier).removeJob(job);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted $job'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            ref.read(jobsProvider.notifier).addJob(job);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final media = MediaQuery.of(context);
    final theme = Theme.of(context);
    final jobs = ref.watch(jobsProvider);

    return ConditionalParent(
      condition: media.size.width > breakpoint,
      builder: (widget) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerLow,
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.surfaceContainer,
                      offset: const Offset(8, 0),
                    )
                  ],
                ),
                padding: EdgeInsets.all(15),
                child: widget,
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    "Select a job to edit, or create a new one.",
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.3,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
      child: Column(
        children: [
          if (jobs.isNotEmpty) JobChart(jobs: jobs),
          SizedBox(height: 20),
          Expanded(
            child: JobList(
              jobs: jobs,
              onSelect: (job) {},
              onDelete: (job) {
                onJobDelete(context, ref, job);
              },
            ),
          ),
        ],
      ),
    );
  }
}
