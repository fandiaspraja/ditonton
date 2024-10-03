import '../../domain/entities/networks.dart';

class NetworksModel {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  NetworksModel({this.id, this.logoPath, this.name, this.originCountry});

  factory NetworksModel.fromJson(Map<String, dynamic> json) => NetworksModel(
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

  Networks toEntity() {
    return Networks(
      id: id,
      logoPath: logoPath,
      name: name,
      originCountry: originCountry,
    );
  }
}
