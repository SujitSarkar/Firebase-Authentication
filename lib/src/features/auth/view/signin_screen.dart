import '../../../../core/router/app_router.dart';
import '../../../../core/router/page_navigator.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../core/constants/app_color.dart';
import '../controller/auth_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                      key: authController.signInFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          "Welcome Back"
                              .text
                              .size(30.sp)
                              .color(AppColor.titleTextColor)
                              .fontWeight(FontWeight.w700)
                              .make(),
                          "Enter your details below"
                              .text
                              .size(15.sp)
                              .color(AppColor.secondaryTextColor)
                              .fontWeight(FontWeight.w400)
                              .make(),
                          TextFormFieldWidget(
                            controller: authController.signInEmail,
                            labelText: 'Email Address',
                            hintText: 'Your email address',
                            textInputType: TextInputType.emailAddress,
                            required: true,
                            validationErrorMessage: authController.signInEmailError,
                          ),
                          SizedBox(height: 8.h),
                          TextFormFieldWidget(
                            controller: authController.signInPassword,
                            labelText: 'Password',
                            hintText: 'Your password',
                            obscure: true,
                            required: true,
                            validationErrorMessage: authController.signInPasswordError,
                          ),
                          SizedBox(height: 32.h),
                          PrimaryButton(
                            onTap: ()=> authController.signInButtonOnTap(),
                            child:authController.loading
                                ? const LoadingWidget()
                                : "SIGN IN"
                                .text
                                .size(16.sp)
                                .color(AppColor.whiteColor)
                                .fontWeight(FontWeight.w500)
                                .make(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                side: const BorderSide(
                                    color: AppColor.secondaryTextColor),
                                value: authController.rememberMeCheckValue,
                                onChanged: (newValue) =>
                                    authController.changeRememberMe(newValue!),
                              ),
                              "Remember me!"
                                  .text
                                  .size(13.sp)
                                  .color(AppColor.secondaryTextColor)
                                  .fontWeight(FontWeight.w400)
                                  .make(),
                              const Spacer(),
                              InkWell(
                                onTap: () => pushTo(AppRouter.forgotPassword),
                                child: "Forgot your password?"
                                    .text
                                    .size(13.sp)
                                    .color(AppColor.secondaryTextColor)
                                    .fontWeight(FontWeight.w600)
                                    .make(),
                              ),
                            ],
                          ),
                          SizedBox(height: 50.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              "Don’t have an account?"
                                  .text
                                  .size(14.sp)
                                  .color(AppColor.titleTextColor)
                                  .fontWeight(FontWeight.w400)
                                  .make(),
                              SizedBox(width: 16.w),
                              PrimaryButton(
                                onTap: ()=> pushTo(AppRouter.signUp),
                                height: 28.h,
                                width: 84.w,
                                borderRadius: BorderRadius.all(Radius.circular(5.r)),
                                child: "SIGN UP"
                                    .text
                                    .size(14.sp)
                                    .color(AppColor.whiteColor)
                                    .fontWeight(FontWeight.w400)
                                    .make(),
                              )
                            ],
                          )
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
