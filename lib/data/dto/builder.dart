import 'package:json_annotation/json_annotation.dart';

part 'builder.g.dart';

@JsonSerializable()
class Builder {
  const Builder({
    required this.isBusy,
  });

  factory Builder.fromJson(Map<String, dynamic> json) => _$BuilderFromJson(json);

  Map<String, dynamic> toJson() => _$BuilderToJson(this);

  final bool isBusy;

  Builder copyWith({
    bool? isBusy,
  }) {
    return Builder(
      isBusy: isBusy ?? this.isBusy,
    );
  }
}
