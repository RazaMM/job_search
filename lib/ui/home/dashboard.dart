import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search/data/providers/jobs.dart';
import 'package:job_search/ui/core/widgets/conditional_parent.dart';
import 'package:job_search/ui/jobs/job_list.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  final breakpoint = 720.0;

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
              child: widget,
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text("form"),
                ),
              ),
            )
          ],
        );
      },
      child: JobList(jobs: jobs),
    );
  }
}
