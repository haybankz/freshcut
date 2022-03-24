import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Space extends LeafRenderObjectWidget {
  ///
  /// easily add space inside Flex widgets such as Columns and Rows or scrolling views.
  ///
  /// returns a vertical space if used in a column or flex with with Axis.vertical
  /// returns a horizontal space when used in a row or flex widget with Axis.horizontal
  ///
  const Space(this.space, {Key? key}) : super(key: key);

  final double space;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderSpace(space: space);

  @override
  void updateRenderObject(
          BuildContext context, covariant RenderSpace renderObject) =>
      renderObject.space = space;
}

class RenderSpace extends RenderBox {
  RenderSpace({required double space}) : _space = space;

  double get space => _space;
  double _space;

  set space(double space) {
    if (space == _space) {
      return;
    }
    _space = space;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final Axis? direction = (parent as RenderFlex?)?.direction;
    assert(direction != null,
        'Space should not be used outside of a Flex (Row, Column)');
    if (direction == null) {
      size = Size.zero;
    } else {
      size = Size(direction == Axis.horizontal ? space.w : 0,
          direction == Axis.vertical ? space.h : 0);
    }
  }
}
