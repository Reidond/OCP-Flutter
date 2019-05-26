import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'application_task.g.dart';

@JsonSerializable(nullable: false)
class ApplicationTask extends Equatable {
  int id;
  int copyrightApplicationId;
  String _title;
  bool done;
  String createdAt;
  String updatedAt;

  ApplicationTask(this._title,
      {this.id,
      this.copyrightApplicationId,
      this.done,
      this.createdAt,
      this.updatedAt})
      : super([id, copyrightApplicationId, _title, done, createdAt, updatedAt]);

  @override
  String toString() {
    return _title;
  }

  factory ApplicationTask.fromJson(Map<String, dynamic> json) =>
      _$ApplicationTaskFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicationTaskToJson(this);
}
