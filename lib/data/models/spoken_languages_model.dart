import 'package:ditonton/domain/entities/spoken_languages.dart';

class SpokenLanguagesModel {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguagesModel({this.englishName, this.iso6391, this.name});

  factory SpokenLanguagesModel.fromJson(Map<String, dynamic> json) =>
      SpokenLanguagesModel(
        englishName: json['english_name'],
        iso6391: json['iso_639_1'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'english_name': englishName,
        'iso_639_1': iso6391,
        'name': name,
      };

  SpokenLanguages toEntity() {
    return SpokenLanguages(
      englishName: englishName,
      iso6391: iso6391,
      name: name,
    );
  }
}
