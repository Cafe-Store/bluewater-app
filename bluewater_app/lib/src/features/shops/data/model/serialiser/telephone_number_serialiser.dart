import 'package:bluewater_app/src/features/shops/data/model/telephone_number_model.dart';
import 'package:bluewater_app/src/features/shops/domain/entity/telephone_homber.dart';
import 'package:json_annotation/json_annotation.dart';

class TelePhoneNumberSerialiser
    extends JsonConverter<TelephoneNumber, Map<String, dynamic>> {
  const TelePhoneNumberSerialiser();

  @override
  TelephoneNumber fromJson(Map<String, dynamic> json) =>
      TelephoneNumberModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(TelephoneNumber tel) =>
      TelephoneNumberModel.from(tel).toJson();
}
