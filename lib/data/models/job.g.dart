// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JobImpl _$$JobImplFromJson(Map<String, dynamic> json) => _$JobImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      company: json['company'] as String,
      posting: json['posting'] as String,
      dateApplied: DateTime.parse(json['dateApplied'] as String),
      status: $enumDecode(_$JobStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$JobImplToJson(_$JobImpl instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'company': instance.company,
      'posting': instance.posting,
      'dateApplied': instance.dateApplied.toIso8601String(),
      'status': _$JobStatusEnumMap[instance.status]!,
    };

const _$JobStatusEnumMap = {
  JobStatus.applied: 'applied',
  JobStatus.interviewing: 'interviewing',
  JobStatus.rejected: 'rejected',
  JobStatus.offered: 'offered',
};
