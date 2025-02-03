import 'package:job_search/data/models/job.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:job_search/data/repositories/jobs.dart' as repo show Jobs;

part 'jobs.g.dart';

@Riverpod(keepAlive: true)
class Jobs extends _$Jobs {
  @override
  List<Job> build() {
    return [];
  }

  Future<void> init() async {
    state = await repo.Jobs.all;
  }

  Future<void> updateJob(Job job) async {
    state = state.map((j) => job.id == j.id ? job : j).toList();
    await repo.Jobs.update(job);
  }

  Future<void> addJob(Job job) async {
    // If there already is a job with the id of the one we are trying to add, just update it with the new values.
    if(state.any((j) => job.id == j.id)){
      updateJob(job);
      return;
    }

    state = [...state, job];
    await repo.Jobs.add(job);
  }

  Future<void> removeJob(Job job) async {
    state = state.where((j) => j.id != job.id).toList();
    await repo.Jobs.delete(job);
  }
}