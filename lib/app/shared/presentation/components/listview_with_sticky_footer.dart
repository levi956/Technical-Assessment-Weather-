import 'package:flutter/material.dart';

class ListViewWithStickyFooter extends StatelessWidget {
  final List<Widget> children;
  final List<Widget>? stickyFooterChildren;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;

  const ListViewWithStickyFooter({
    super.key,
    required this.children,
    this.padding,
    this.alignment,
    this.stickyFooterChildren,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Align(
                  alignment: alignment ?? Alignment.center,
                  child: children[index],
                );
              },
              childCount: children.length,
            ),
          ),
          if (stickyFooterChildren != null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: stickyFooterChildren!,
              ),
            ),
        ],
      ),
    );
  }
}
