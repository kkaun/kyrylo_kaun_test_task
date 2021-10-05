import 'dart:convert';
import 'package:kyrylo_kaun_test_task/domain/entites/launch_entities.dart';

class LaunchModelsList extends LaunchList {
  final List<LaunchModel> list;

  LaunchModelsList({required this.list}) : super(launches: list);

  Map<String, dynamic> toMap() {
    return {
      'launches': list.map((x) => x.toMap()).toList(),
    };
  }

  factory LaunchModelsList.fromMap(Map<String, dynamic> map) {
    return LaunchModelsList(
      list: List<LaunchModel>.from(map['launches']?.map((x) => LaunchModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory LaunchModelsList.fromJson(String source) => LaunchModelsList.fromMap(json.decode(source));
}

class LaunchModel extends Launch {
  const LaunchModel({required String missionName, required String details})
      : super(missionName: missionName, details: details);

  Map<String, dynamic> toMap() {
    return {
      'mission_name': missionName,
      'details': details,
    };
  }

  factory LaunchModel.fromMap(Map<String, dynamic> map) {
    return LaunchModel(
      missionName: map['mission_name'] ?? 'N/A',
      details: map['details'] ?? 'N/A',
    );
  }

  String toJson() => json.encode(toMap());

  factory LaunchModel.fromJson(String source) => LaunchModel.fromMap(json.decode(source));
}
