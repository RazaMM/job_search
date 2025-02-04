import 'package:flutter/material.dart';

enum JobStatus implements Comparable<JobStatus> {
  applied(
    icon: Icons.list_alt,
  ),
  interviewing(
    icon: Icons.groups,
  ),
  rejected(
    icon: Icons.cancel_outlined,
  ),
  offered(
    icon: Icons.check
  );

  const JobStatus({
    required this.icon,
  });

  final IconData icon;

  @override
  int compareTo(JobStatus other) {
    return name.compareTo(other.name);
  }
}