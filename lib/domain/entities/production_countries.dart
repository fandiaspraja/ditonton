import 'package:equatable/equatable.dart';

class ProductionCountries extends Equatable {
  String? iso31661;
  String? name;

  ProductionCountries({this.iso31661, this.name});

  @override
  // TODO: implement props
  List<Object?> get props => [
        iso31661,
        name,
      ];
}
