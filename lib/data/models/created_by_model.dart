import 'package:ditonton/domain/entities/created_by.dart';

class CreatedByModel {
  int? id;
  String? creditId;
  String? name;
  String? originalName;
  int? gender;
  String? profilePath;

  CreatedByModel(
      {this.id,
      this.creditId,
      this.name,
      this.originalName,
      this.gender,
      this.profilePath});

  factory CreatedByModel.fromJson(Map<String, dynamic> json) => CreatedByModel(
      id: json['id'],
      creditId: json['credit_id'],
      name: json['name'],
      originalName: json['original_name'],
      gender: json['gender'],
      profilePath: json['profile_path']);

  CreatedBy toEntity() {
    return CreatedBy(
      id: this.id,
      creditId: this.creditId,
      name: this.name,
      originalName: this.originalName,
      gender: this.gender,
      profilePath: this.profilePath,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "credit_id": creditId,
        "name": name,
        "original_name": originalName,
        "gender": gender,
        "profile_path": profilePath,
      };
}
