import 'package:flutter/material.dart';
import '../../../../core/router/page_navigator.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/text_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../core/constants/app_color.dart';
import '../controller/auth_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Provider.of(context);
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/login_bg.png'),
              fit: BoxFit.cover)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  AppColor.primaryColor.withOpacity(0.8),
                  Colors.transparent
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              ),
              Positioned(
                child: IconButton(
                  onPressed: () {
                    authController.signInEmail.clear();
                    popScreen();
                    },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColor.whiteColor,
                    size: 20,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 580.h,
                  padding:
                      EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColor.appBodyBg,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r))),
                  child: SingleChildScrollView(
                    child: Form(
                      key: authController.forgotPasswordFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          "Reset password"
                              .text
                              .size(30.sp)
                              .color(AppColor.titleTextColor)
                              .fontWeight(FontWeight.w700)
                              .make(),
                          TextFormFieldWidget(
                            controller: authController.signInEmail,
                            labelText: 'Email Address',
                            hintText: 'Your email address',
                            textInputType: TextInputType.emailAddress,
                            required: true,
                            validationErrorMessage: authController.signInEmailError,
                          ),
                          SizedBox(height: 32.h),
                          PrimaryButton(
                            onTap: () => authController.resetPassword(),
                            child:authController.loading
                                ? const LoadingWidget()
                                : "Reset Password"
                                .text
                                .size(16.sp)
                                .color(AppColor.whiteColor)
                                .fontWeight(FontWeight.w500)
                                .make(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
