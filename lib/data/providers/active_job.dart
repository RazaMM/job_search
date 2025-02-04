import 'package:job_search/data/models/job.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_job.g.dart';

@Riverpod(keepAlive: true)
class ActiveJob extends _$ActiveJob {

  @override
  Job? build() {
    return null;
  }

  void update(Job job) {
    if(job.id != state?.id) {
      state = job;
    }
  }
}