import 'package:json_annotation/json_annotation.dart';

import '../../../categories/data/model/category_model.dart';
import '../../../location/data/model/serialiser/address_serialiser.dart';
import '../../../location/domain/entity/address.dart';
import '../../domain/entity/business_number.dart';
import '../../domain/entity/owner.dart';
import '../../domain/entity/shop.dart';
import '../../domain/entity/telephone_homber.dart';
import 'rank_model.dart';
import 'serialiser/business_number_serialiser.dart';
import 'serialiser/category_list_serialiser.dart';
import 'serialiser/owner_serialiser.dart';
import 'serialiser/rank_serialiser.dart';
import 'serialiser/shop_photo_list_serialiser.dart';
import 'serialiser/telephone_number_serialiser.dart';
import 'shop_photo_model.dart';

part 'shop_model.g.dart';

@JsonSerializable()
class ShopModel extends Shop {
  final String shopId;

  const ShopModel({
    required this.shopId,
    required String name,
    required Address address,
    required TelephoneNumber tel,
    required BusinessNumber businessNumber,
    required RankModel rank,
    required Owner owner,
    required String officeHours,
    required String notice,
    required List<ShopPhotoModel> photos,
    required List<CategoryModel> categories,
  }) : super(
          id: shopId,
          name: name,
          address: address,
          tel: tel,
          businessNumber: businessNumber,
          rank: rank,
          owner: owner,
          officeHours: officeHours,
          notice: notice,
          photos: photos,
          categories: categories,
        );

  factory ShopModel.fromJson(Map<String, dynamic> json) =>
      _$ShopModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopModelToJson(this);
}
