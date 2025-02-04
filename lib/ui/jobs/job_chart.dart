import 'package:flutter/material.dart';
import 'package:job_search/data/models/job.dart';
import 'package:job_search/data/models/job_status.dart';
import 'package:job_search/ui/core/widgets/bar_chart.dart';

class JobChart extends StatelessWidget {
  const JobChart({super.key, required this.jobs});

  final List<Job> jobs;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      height: 200,
      values: JobStatus.values.map((status) {
        final count = jobs.fold<int>(
            0, (count, job) => job.status == status ? count + 1 : count);
        return BarChartData(count: count, icon: status.icon);
      }).toList(),
    );
  }
}
