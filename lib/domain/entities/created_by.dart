import 'package:equatable/equatable.dart';

class CreatedBy extends Equatable {
  int? id;
  String? creditId;
  String? name;
  String? originalName;
  int? gender;
  String? profilePath;

  CreatedBy(
      {this.id,
      this.creditId,
      this.name,
      this.originalName,
      this.gender,
      this.profilePath});

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        creditId,
        name,
        originalName,
        gender,
        profilePath,
      ];
}
