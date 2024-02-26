import 'package:flutter/material.dart';

class DynamicColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final VerticalDirection verticalDirection;
  final TextDirection textDirection;
  final TextBaseline textBaseline;

  final MainAxisAlignment? rowMainAxisAlignment;
  final CrossAxisAlignment? rowCrossAxisAlignment;
  final MainAxisSize? rowMainAxisSize;
  final VerticalDirection? rowVerticalDirection;
  final TextDirection? rowTextDirection;
  final TextBaseline? rowTextBaseline;

  const DynamicColumn({
    Key? key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.verticalDirection = VerticalDirection.down,
    this.textDirection = TextDirection.ltr,
    this.textBaseline = TextBaseline.alphabetic,
    this.rowMainAxisAlignment,
    this.rowCrossAxisAlignment,
    this.rowMainAxisSize,
    this.rowVerticalDirection,
    this.rowTextDirection,
    this.rowTextBaseline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return Row(
        mainAxisAlignment: rowMainAxisAlignment ?? mainAxisAlignment,
        crossAxisAlignment: rowCrossAxisAlignment ?? crossAxisAlignment,
        mainAxisSize: rowMainAxisSize ?? mainAxisSize,
        verticalDirection: rowVerticalDirection ?? verticalDirection,
        textDirection: rowTextDirection ?? textDirection,
        textBaseline: rowTextBaseline ?? textBaseline,
        children: children,
      );
    }
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      verticalDirection: verticalDirection,
      textDirection: textDirection,
      textBaseline: textBaseline,
      children: children,
    );
  }
}
