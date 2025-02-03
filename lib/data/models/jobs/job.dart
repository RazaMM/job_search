import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:job_search/data/models/jobs/job_status.dart';
import 'package:uuid/uuid.dart';

part 'job.freezed.dart';

var uuid = Uuid();

@freezed
class Job with _$Job {
  const Job._();

  const factory Job({
    required String id,
    required String title,
    required String company,
    required String posting,
    required DateTime dateApplied,
    required JobStatus status,
  }) = _Job;

  factory Job.placeholder() {
    return _Job(
      id: uuid.v4(),
      title: 'Untitled Job',
      company: 'Untitled Company',
      posting: '',
      dateApplied: DateTime.now(),
      status: JobStatus.applied,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Job && runtimeType == other.runtimeType && id == other.id;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return '$title @ $company';
  }
}
