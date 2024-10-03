import '../../domain/entities/production_companies.dart';

class ProductionCompaniesModel {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompaniesModel(
      {this.id, this.logoPath, this.name, this.originCountry});

  factory ProductionCompaniesModel.fromJson(Map<String, dynamic> json) =>
      ProductionCompaniesModel(
        id: json['id'],
        logoPath: json['logo_path'],
        name: json['name'],
        originCountry: json['origin_country'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'logo_path': logoPath,
        'name': name,
        'origin_country': originCountry,
      };

  ProductionCompanies toEntity() {
    return ProductionCompanies(
      id: id,
      logoPath: logoPath,
      name: name,
      originCountry: originCountry,
    );
  }
}
