import 'package:ditonton/domain/entities/production_countries.dart';

class ProductionCountriesModel {
  String? iso31661;
  String? name;

  ProductionCountriesModel({this.iso31661, this.name});

  factory ProductionCountriesModel.fromJson(Map<String, dynamic> json) =>
      ProductionCountriesModel(
        iso31661: json['iso_3166_1'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'iso_3166_1': iso31661,
        'name': name,
      };

  ProductionCountries toEntity() {
    return ProductionCountries(
      iso31661: iso31661,
      name: name,
    );
  }
}
