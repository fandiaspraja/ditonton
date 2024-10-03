import 'package:equatable/equatable.dart';

class ProductionCompanies extends Equatable {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        logoPath,
        name,
        originCountry,
      ];
}
