import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  bool googleLoading = false;
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
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'email': email.text,
      });
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
      showToast('Something went wrong!');
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
      showToast('Something went wrong!');
      debugPrint(error.toString());
    }
    loading = false;
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    googleLoading = true;
    notifyListeners();
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      if(rememberMeCheckValue==true){
        await setData(LocalStorageKey.emailKey, userCredential.user!.email!);
      }
      showToast('Successfully logged in');
      emailAddress = userCredential.user!.email!;
      clearAll();
      pushAndRemoveUntil(AppRouter.home);
    } catch (error) {
      showToast('Something went wrong!');
      debugPrint(error.toString());
    }
    googleLoading = false;
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
    bool userExist = await doesUserExistByEmail(signInEmail.text);
    if(userExist==false){
      loading =false;
      notifyListeners();
      showErrorDialog('No user found', 'Please type a valid email address which is registered in Showa system');
      return;
    }
    try {
      _auth.setLanguageCode('en');
      await _auth.sendPasswordResetEmail(email: signInEmail.text);
      showSuccessDialog('Password reset link sent', 'Successful password reset '
          'link sent to email: “${signInEmail.text}” Please follow the email password reset instruction');
    } catch (error) {
      showErrorDialog('Error', 'Something went wrong try again later');
      debugPrint("Error sending password reset email: $error");
    }
    loading = false;
    notifyListeners();
  }

  Future<bool> doesUserExistByEmail(String email) async {
    try {
      final QuerySnapshot users = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      return users.docs.isNotEmpty;
    } catch (error) {
      showToast('Something went wrong!');
      debugPrint("Error checking if user exists: $error");
      return false;
    }
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