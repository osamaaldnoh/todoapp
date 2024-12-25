import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todoapp/res/appcolor.dart';
import 'package:todoapp/res/appstyle.dart';
import 'package:todoapp/res/size_config.dart';
import 'package:todoapp/res/widgets/hieght_spacer.dart';
import 'package:todoapp/res/widgets/reusable_text.dart';
import 'package:todoapp/res/widgets/width_spacer.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(
      {Key? key,
      this.color,
      this.title,
      this.description,
      this.start,
      this.end,
      this.editWidget,
      this.delete,
      this.switcher})
      : super(key: key);
  final Color? color;
  final String? title;
  final String? description;
  final String? start;
  final String? end;
  final Widget? editWidget;
  final Widget? switcher;
  final void Function()? delete;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              color: AppColors.kGreyLight,
              borderRadius: BorderRadius.all(
                Radius.circular(AppColors.kRadius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 80,
                      width: 5,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppColors.kRadius),
                          color: color ?? AppColors.kRed),
                    ),
                    WidthSpacer(width: 15),
                    Padding(
                      padding: EdgeInsets.all(8.h),
                      child: SizedBox(
                        width: SizeConfig.screenWidth * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: title ?? "Title of Todo",
                              style: appStyle(
                                  18, AppColors.kLight, FontWeight.bold),
                            ),
                            const HieghtSpacer(height: 3),
                            ReusableText(
                              text: description ?? "Description of Todo",
                              style: appStyle(
                                  12, AppColors.kLight, FontWeight.bold),
                            ),
                            const HieghtSpacer(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: SizeConfig.screenWidth * 0.3,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.kBkDark,
                                    border: Border.all(
                                      color: AppColors.kGreyDk,
                                      width: 0.3,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(AppColors.kRadius)),
                                  ),
                                  child: Center(
                                    child: ReusableText(
                                      text: "$start | $end",
                                      style: appStyle(12, AppColors.kLight,
                                          FontWeight.normal),
                                    ),
                                  ),
                                ),
                                WidthSpacer(width: 20),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: editWidget,
                                    ),
                                    WidthSpacer(width: 20),
                                    GestureDetector(
                                      onTap: delete,
                                      child: Icon(
                                          MaterialCommunityIcons.delete_circle),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: switcher,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
