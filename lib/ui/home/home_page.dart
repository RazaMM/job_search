import 'package:flutter/material.dart';
import 'package:job_search/data/models/job.dart';
import 'package:job_search/data/providers/jobs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search/ui/home/dashboard.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  final sidebarWidget = 400.0;

  void onAddJob(WidgetRef ref) {
    ref.read(jobsProvider.notifier).addJob(Job.placeholder());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onAddJob(ref);
        },
        child: Icon(Icons.add),
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
