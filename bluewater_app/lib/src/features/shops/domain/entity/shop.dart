import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../location/data/model/serialiser/address_serialiser.dart';
import '../../../location/domain/entity/address.dart';
import '../../data/model/serialiser/business_number_serialiser.dart';
import '../../data/model/serialiser/owner_serialiser.dart';
import '../../data/model/serialiser/rank_serialiser.dart';
import '../../data/model/serialiser/shop_photo_list_serialiser.dart';
import '../../data/model/serialiser/telephone_number_serialiser.dart';
import 'business_number.dart';
import 'owner.dart';
import 'rank.dart';
import 'shop_photo.dart';
import 'telephone_homber.dart';

class Shop extends Equatable {
  final String id;
  final String name;

  @AddressSerialiser()
  final Address address;

  @TelePhoneNumberSerialiser()
  final TelephoneNumber tel;

  @BusinessNumberSerialiser()
  final BusinessNumber businessNumber;

  @RankSerialiser()
  final Rank rank;

  @OwnerSerialiser()
  final Owner owner;

  final String officeHours;

  final String notice;

  @ShopPhotoListSerialiser()
  final List<ShopPhoto> photos;

  @mustCallSuper
  const Shop({
    required this.id,
    required this.name,
    required this.address,
    required this.tel,
    required this.businessNumber,
    required this.rank,
    required this.owner,
    required this.officeHours,
    required this.notice,
    required this.photos,
  });

  factory Shop.empty() => Shop(
        id: '',
        name: '',
        photos: <ShopPhoto>[],
        rank: Rank(0.0, 0),
        address: Address('', '', ''),
        owner: Owner('', ''),
        officeHours: '',
        notice: '',
        businessNumber: BusinessNumber(''),
        tel: TelephoneNumber(''),
      );

  @override
  List<Object?> get props => [id];
}
