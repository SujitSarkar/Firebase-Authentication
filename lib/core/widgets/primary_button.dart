import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_color.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.onTap,
      required this.child,
      this.width,
      this.height,
      this.backgroundColor,
      this.borderRadius,
        this.splashColor});
  final Function() onTap;
  final Widget child;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final MaterialStateProperty<Color?>? splashColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: backgroundColor ?? AppColor.primaryColor,
                elevation: 0.0,
                minimumSize: Size(width ?? MediaQuery.sizeOf(context).width, height??48.h),
                shape: RoundedRectangleBorder(
                    borderRadius: borderRadius ??
                        BorderRadius.all(Radius.circular(50.r))))
            .copyWith(
                overlayColor: splashColor??
                    MaterialStateProperty.all(Colors.white.withOpacity(0.5))),
        onPressed: onTap,
        child: child);
  }
}
