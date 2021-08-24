import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/category.dart';

class CategoryItem extends StatelessWidget {
  final Category item;
  final double minWidth;
  final Size imageSize;
  final double badgeFontSize;

  const CategoryItem({
    required this.item,
    Key? key,
    this.minWidth = 100,
    this.imageSize = const Size(60.0, 60.0),
    this.badgeFontSize = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: minWidth),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _ItemWithBadge(
            item: item,
            imageSize: imageSize,
            badgetFontSize: badgeFontSize,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              item.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemWithBadge extends StatelessWidget {
  final Category item;
  final Size imageSize;
  final double badgetFontSize;

  _ItemWithBadge({
    Key? key,
    required this.item,
    required this.imageSize,
    required this.badgetFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item.badgeName != null) {
      return Badge(
        shape: BadgeShape.circle,
        position: BadgePosition.topEnd(top: 0),
        padding: EdgeInsets.all(8),
        badgeContent: Text(
          item.badgeName!,
          style: TextStyle(
              color: Colors.white,
              fontSize: badgetFontSize,
              fontWeight: FontWeight.bold),
        ),
        child: categoryImage(imageSize),
      );
    } else {
      return categoryImage(imageSize);
    }
  }

  CachedNetworkImage categoryImage(Size imageSize) {
    return CachedNetworkImage(
      imageUrl: item.imageUri,
      imageBuilder: (context, imageProvider) => Container(
        height: imageSize.height,
        width: imageSize.width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
