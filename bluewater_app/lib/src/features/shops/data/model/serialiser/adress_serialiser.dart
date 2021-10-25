import 'package:json_annotation/json_annotation.dart';

import '../../../../location/domain/entity/adress.dart';
import '../adress_model.dart';

class AdressSerialiser extends JsonConverter<Adress, Map<String, dynamic>> {
  const AdressSerialiser();

  @override
  Adress fromJson(Map<String, dynamic> json) => AdressModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(Adress adress) =>
      AdressModel.from(adress).toJson();
}
