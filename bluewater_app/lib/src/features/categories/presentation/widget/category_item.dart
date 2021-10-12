import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../shared/model/tab_item.dart';

class CategoryItem<T extends TabItem> extends StatelessWidget {
  final T item;
  final Size imageSize;
  final double badgeFontSize;
  final TextStyle titleStyle;
  final Color borderColor;

  const CategoryItem({
    required this.item,
    required this.titleStyle,
    Key? key,
    this.imageSize = const Size(60.0, 60.0),
    this.badgeFontSize = 8,
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ItemWithBadge(
          item: item,
          imageSize: imageSize,
          badgetFontSize: badgeFontSize,
          borderColor: borderColor,
        ),
        Text(
          item.title,
          style: titleStyle,
        ),
      ],
    );
  }
}

class _ItemWithBadge extends StatelessWidget {
  final TabItem item;
  final Size imageSize;
  final double badgetFontSize;
  final Color borderColor;

  _ItemWithBadge({
    Key? key,
    required this.item,
    required this.imageSize,
    required this.badgetFontSize,
    required this.borderColor,
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
        child: categoryImage(imageSize, borderColor),
      );
    } else {
      return categoryImage(imageSize, borderColor);
    }
  }

  CachedNetworkImage categoryImage(Size imageSize, Color borderColor) {
    return CachedNetworkImage(
      imageUrl: item.image,
      imageBuilder: (context, imageProvider) => Container(
        height: imageSize.height,
        width: imageSize.width,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 2.0),
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
