import 'package:flutter/material.dart';
import 'package:job_search/data/models/job.dart';
import 'package:job_search/data/providers/active_job.dart';
import 'package:job_search/data/providers/jobs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search/ui/core/themes/theme.dart';
import 'package:job_search/ui/home/dashboard.dart';
import 'package:job_search/utils/brightness_shift.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  final sidebarWidget = 400.0;

  void onAddJob(WidgetRef ref) {
    final newJob = Job.placeholder();

    ref.read(jobsProvider.notifier).addJob(newJob);
    ref.read(activeJobProvider.notifier).update(newJob);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: Container(
        decoration: AppTheme.getBoxDecoration(
          shadow: theme.colorScheme.primaryContainer.darken(0.1),
          borderRadius: const BorderRadius.all(
            AppTheme.radius,
          ),
        ),
        child: FloatingActionButton(
          elevation: 0,
          hoverElevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              AppTheme.radius,
            ),
          ),
          onPressed: () {
            onAddJob(ref);
          },
          child: Icon(Icons.add),
        ),
      ),
      body: FutureBuilder(
        future: ref.read(jobsProvider.notifier).init(),
        builder: (context, snapshot) {
          final isDone = snapshot.connectionState == ConnectionState.done;
          if (isDone && !snapshot.hasError) {
            return Dashboard();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "An unexpected error has occurred: ${snapshot.error}",
              ),
            );
          } else {
            return Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
