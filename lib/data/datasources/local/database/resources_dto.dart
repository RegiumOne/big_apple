import 'dart:convert';

import 'package:drift/drift.dart';

class ResourceDto {
  ResourceDto({
    required this.gold,
    required this.peoples,
    required this.updatedAt,
  });

  factory ResourceDto.fromJson(Map<String, dynamic> json) => ResourceDto(
        gold: json["gold"],
        peoples: json["peoples"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  final int gold;
  final int peoples;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => {
        "gold": gold,
        "peoples": peoples,
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class ResourceConverter extends TypeConverter<ResourceDto, String> {
  const ResourceConverter();

  @override
  ResourceDto fromSql(String fromDb) {
    return ResourceDto.fromJson(jsonDecode(fromDb));
  }

  @override
  String toSql(ResourceDto value) {
    return jsonEncode(value.toJson());
  }
}
