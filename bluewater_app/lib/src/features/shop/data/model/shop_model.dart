import '../../domain/entity/shop.dart';

class ShopModel extends Shop {
  const ShopModel({
    required int id,
    required String name,
    required List<String> imageUrls,
    required double rank,
  }) : super(id: id, name: name, imageUrls: imageUrls, rank: rank);

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: (json['id'] as num).toInt(),
      name: json['name'],
      imageUrls: List<String>.from(json["images"].map((x) => x)),
      rank: (json['id'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'images': List<dynamic>.from(imageUrls.map((x) => x)),
      'rank': rank,
    };
  }
}
