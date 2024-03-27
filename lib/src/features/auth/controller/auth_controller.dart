import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/constants/local_storage_key.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/router/page_navigator.dart';
import '../../../../core/utils/app_toast.dart';
import '../../../../core/utils/local_storage.dart';
import '../../../../core/utils/validator.dart';

class AuthController extends ChangeNotifier{
  Timer? debounceTimer;
  final GlobalKey<FormState> signInFormKey = GlobalKey();
  final GlobalKey<FormState> signupFormKey = GlobalKey();
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey();

  final TextEditingController signInEmail = TextEditingController();
  final TextEditingController signInPassword = TextEditingController();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  String? emailAddress;

  ///Signup Errors Message
  String? signInEmailError;
  String? signInPasswordError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  bool loading = false;
  bool rememberMeCheckValue = false;
  bool privacyPolicyCheckValue = false;
  bool eligibleForSignup = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> onInit()async{
    debugPrint('onInit called');
    loading=true;
    notifyListeners();
    emailAddress = await getData(LocalStorageKey.emailKey);
    if(emailAddress!=null){
      await Future.delayed(const Duration(seconds: 2));
     pushAndRemoveUntil(AppRouter.home);
    }
    debugPrint('Local Email Address: $emailAddress');
    loading=false;
    notifyListeners();
    email.addListener(validateSignupAgreeAndContinue);
    password.addListener(validateSignupAgreeAndContinue);
    confirmPassword.addListener(validateSignupAgreeAndContinue);
  }

  void clearAll(){
    signInEmail.clear();
    signInPassword.clear();
    email.clear();
    password.clear();
    confirmPassword.clear();
    signInEmailError = null;
    signInPasswordError = null;
    emailError = null;
    passwordError = null;
    confirmPasswordError = null;
    loading = false;
    notifyListeners();
  }

  ///UI Functions:::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void changeRememberMe(bool newValue){
    rememberMeCheckValue = newValue;
    notifyListeners();
  }
  void changePrivacyPolicy(bool newValue){
    privacyPolicyCheckValue = newValue;
    notifyListeners();
    validateSignupAgreeAndContinue();
  }

  void validateSignupAgreeAndContinue(){
    if(signupFormKey.currentState!=null){
      debouncing(
        fn: () async {
          if(!signupFormKey.currentState!.validate()){
            eligibleForSignup = false;
          }
          else if(!privacyPolicyCheckValue){
            eligibleForSignup = false;
          }
          else if(!validateEmail(email.text)){
            eligibleForSignup = false;
            emailError = 'Invalid email';
          }
          else if(!validatePassword(password.text)){
            eligibleForSignup = false;
            passwordError = 'Use 8 or more characters with a mix of letters, numbers & symbols';
          }
          else if(!validatePassword(confirmPassword.text)){
            eligibleForSignup = false;
            confirmPasswordError = 'Use 8 or more characters with a mix of letters, numbers & symbols';
          }
          else if(password.text != confirmPassword.text){
            eligibleForSignup = false;
            confirmPasswordError = 'password not matched';
          }
          else{
            eligibleForSignup = true;
            emailError = null;
            passwordError = null;
            confirmPasswordError = null;
          }
          notifyListeners();
        },
      );
    }
  }

  ///Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  Future<void> agreeAndContinueButtonOnTap() async {
    if(loading){
      showToast('Another process running');
      return;
    }
    if(!eligibleForSignup){
      return;
    }
    loading = true;
    notifyListeners();
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      showToast('Successfully signed up');
      emailAddress = email.text;
      clearAll();
      pushAndRemoveUntil(AppRouter.home);
    }on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast('The email address is already in use by another account.');
        debugPrint('The email address is already in use by another account: ${e.message}');
      } else {
        showToast(e.message ?? 'An error occurred during sign-up.');
        debugPrint('FirebaseAuthException: ${e.code}: ${e.message}');
      }
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    loading = false;
    notifyListeners();
  }

  Future<void> signInButtonOnTap() async {
    if(loading){
      showToast('Another process running');
      return;
    }
    if(!signInFormKey.currentState!.validate()){
      return;
    }
    if(!validateEmail(signInEmail.text)){
      signInEmailError = 'Invalid email';
      notifyListeners();
      return;
    }
    debugPrint('called');
    if(!validatePassword(signInPassword.text)){
      signInEmailError = null;
      signInPasswordError = 'Use 8 or more characters with a mix of letters, numbers & symbols';
      notifyListeners();
      return;
    }

    loading = true;
    notifyListeners();
    try {
      await _auth.signInWithEmailAndPassword(
        email: signInEmail.text,
        password: signInPassword.text,
      );
      if(rememberMeCheckValue==true){
        await setData(LocalStorageKey.emailKey, signInEmail.text);
      }
      showToast('Successfully logged in');
      emailAddress = signInEmail.text;
      clearAll();
      pushAndRemoveUntil(AppRouter.home);
    }on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        showToast('Invalid credentials. Please check your email and password.');
        debugPrint('Invalid credentials error: ${e.message}');
      } else {
        showToast(e.message ?? 'An error occurred during sign-in.');
        debugPrint('FirebaseAuthException: ${e.code}: ${e.message}');
      }
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    loading = false;
    notifyListeners();
  }

  Future<void> resetPassword() async {
    if(loading){
      showToast('Another process running');
      return;
    }
    if(!forgotPasswordFormKey.currentState!.validate()){
      return;
    }
    if(!validateEmail(signInEmail.text)){
      signInEmailError = 'Invalid email';
      notifyListeners();
      return;
    }
    loading =true;
    notifyListeners();
    // bool userExist = await doesUserExist(signInEmail.text);
    // if(userExist==false){
    //   loading =false;
    //   notifyListeners();
    //   showToast('User not found with this email');
    //   return;
    // }
    try {
      _auth.setLanguageCode('en');
      await _auth.sendPasswordResetEmail(email: signInEmail.text);
    } catch (error) {
      showToast("Error sending password reset email: $error");
      debugPrint("Error sending password reset email: $error");
    }
    loading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      await clearLocalData();
      pushAndRemoveUntil(AppRouter.initializer);
    } catch (error) {
      showToast(error.toString());
      debugPrint("Error signing out: $error");
    }
  }

  void debouncing({required Function() fn, int waitForMs = 700}) {
    debounceTimer?.cancel();
    debounceTimer = Timer(Duration(milliseconds: waitForMs), fn);
  }

}