import 'package:equatable/equatable.dart';

class SpokenLanguages extends Equatable {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguages({this.englishName, this.iso6391, this.name});

  @override
  // TODO: implement props
  List<Object?> get props => [
        englishName,
        iso6391,
        name,
      ];
}
