import 'package:flutter/gestures.dart';
import '../../../../core/router/page_navigator.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../core/constants/app_color.dart';
import '../controller/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Provider.of(context);
    return SafeArea(
      child: Form(
        key: authController.signupFormKey,
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: ()=> popScreen(),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColor.titleTextColor,
                    size: 20,
                  ),
                ),
                SizedBox(height: 50.h),

                "Let’s create"
                    .text
                    .size(26.sp)
                    .color(AppColor.secondaryTextColor)
                    .fontWeight(FontWeight.w400)
                    .make(),
                "Your Account"
                    .text
                    .size(30.sp)
                    .color(AppColor.titleTextColor)
                    .fontWeight(FontWeight.w400)
                    .make(),
                SizedBox(height: 20.h),

                TextFormFieldWidget(
                  controller: authController.email,
                  labelText: 'Email Address',
                  hintText: 'Your email address',
                  textInputType: TextInputType.emailAddress,
                  required: true,
                  validationErrorMessage: authController.emailError,
                ),
                SizedBox(height: 8.h),
                TextFormFieldWidget(
                  controller: authController.password,
                  labelText: 'Password',
                  hintText: 'Your password',
                  obscure: true,
                  required: true,
                  validationErrorMessage: authController.passwordError,
                ),
                SizedBox(height: 8.h),
                TextFormFieldWidget(
                  controller: authController.confirmPassword,
                  labelText: 'Confirm Password',
                  hintText: 'Type again',
                  obscure: true,
                  required: true,
                  validationErrorMessage: authController.confirmPasswordError,
                ),
              ],
            ),
          ),


          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            alignment: Alignment.center,
            height: 150.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      side: const BorderSide(color: AppColor.secondaryTextColor),
                      value: authController.privacyPolicyCheckValue,
                      onChanged: (newValue) =>
                          authController.changePrivacyPolicy(newValue!),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColor.secondaryTextColor),
                          children: [
                            const TextSpan(text: 'Read our '),
                            TextSpan(
                              text: 'Privacy Policy.',
                              style: const TextStyle(color: Color(0xff1E6D8B)),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            const TextSpan(
                                text: ' Tap “Agree and continue” to accept the '),
                            TextSpan(
                              text: 'Terms of Service.',
                              style: const TextStyle(color: Color(0xff1E6D8B)),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24.h),
                PrimaryButton(
                  onTap: () => authController.agreeAndContinueButtonOnTap(),
                  backgroundColor: !authController.eligibleForSignup
                      ? const Color(0xffD7E0E7)
                      : null,
                  child: "Agree and continue"
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
    );
  }
}
