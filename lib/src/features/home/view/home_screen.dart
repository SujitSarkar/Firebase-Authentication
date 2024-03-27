import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../core/constants/app_color.dart';
import '../../auth/controller/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: authController.emailAddress!.text
            .size(18.sp)
            .color(AppColor.whiteColor)
            .fontWeight(FontWeight.w500)
            .make(),
        actions: [
          IconButton(
              onPressed: () => authController.signOut(),
              icon: const Icon(Icons.logout, color: AppColor.whiteColor))
        ],
      ),
      body: Center(
        child: "Dashboard"
            .text
            .size(30.sp)
            .color(AppColor.titleTextColor)
            .fontWeight(FontWeight.w700)
            .make(),
      ),
    );
  }
}
