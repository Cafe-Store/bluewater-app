import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entity/business_number.dart';
import '../business_number_model.dart';

class BusinessNumberSerialiser
    extends JsonConverter<BusinessNumber, Map<String, dynamic>> {
  const BusinessNumberSerialiser();

  @override
  BusinessNumber fromJson(Map<String, dynamic> json) =>
      BusinessNumberModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(BusinessNumber businessNumber) =>
      BusinessNumberModel.from(businessNumber).toJson();
}
