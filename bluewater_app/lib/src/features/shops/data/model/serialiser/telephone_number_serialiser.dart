import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entity/telephone_homber.dart';
import '../telephone_number_model.dart';

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
