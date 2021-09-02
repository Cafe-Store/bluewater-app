part of 'shops_fliter_list_widget.dart';

class _ShopsFilterWidget extends StatelessWidget {
  final String name;
  final Icon? leadingIcon;
  final Icon? trailingIcon;
  final VoidCallback tapCallback;

  final TextStyle? textStyle;
  final Color backgroundColor;
  final Color borderColor;

  _ShopsFilterWidget({
    Key? key,
    required this.name,
    required this.textStyle,
    required this.tapCallback,
    required this.borderColor,
    required this.backgroundColor,
    this.leadingIcon,
    this.trailingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: borderColor,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(30.0),
          ),
          color: backgroundColor),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _createChildren(context),
        ),
        onTap: tapCallback,
      ),
    );
  }

  List<Widget> _createChildren(BuildContext context) {
    var widgetList = <Widget>[];
    if (leadingIcon != null) {
      widgetList.add(
        leadingIcon!,
      );
    }
    widgetList.add(
      Text(
        name,
        style: textStyle,
      ),
    );

    if (trailingIcon != null) {
      widgetList.add(
        trailingIcon!,
      );
    }

    return widgetList;
  }
}
