part of 'application_task.dart';

ApplicationTask _$ApplicationTaskFromJson(Map<String, dynamic> json) {
  return ApplicationTask(json['title'] as String);
}

Map<String, dynamic> _$ApplicationTaskToJson(ApplicationTask instance) =>
    <String, dynamic>{'title': instance._title};
