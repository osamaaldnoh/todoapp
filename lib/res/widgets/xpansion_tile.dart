import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todoapp/res/appcolor.dart';
import 'package:todoapp/res/size_config.dart';

import 'bottom_titles.dart';

class XpansionTile extends StatelessWidget {
  const XpansionTile(
      {Key? key,
      required this.text,
      required this.text2,
      this.onExpansionChanged,
      this.trailing,
      required this.children})
      : super(key: key);
  final String text;
  final String text2;
  final void Function(bool)? onExpansionChanged;
  final Widget? trailing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kBkLight,
        borderRadius: BorderRadius.circular(AppColors.kRadius),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title: BottomTitles(widgetText: text, widgetText2: text2),
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          onExpansionChanged: onExpansionChanged,
          controlAffinity: ListTileControlAffinity.trailing,
          trailing: SizedBox(
            height: SizeConfig.screenHeight,
            child: trailing),
          children: children,
        ),
      ),
    );
  }
}
