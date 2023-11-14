import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmPassword;

  late FocusNode usernameFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode confirmPasswordFocusNode;

  var passwordObscure = true.obs;
  var confirmPasswordObscure = true.obs;

  RxBool isLoading = false.obs;

  // Email
  final emailError = RxString('');
  final emailChange = RxString('');

  // Password
  final passwordError = RxString('');
  final passwordChange = RxString('');

  // Confirm Password
  final confirmPasswordError = RxString('');
  final confirmPasswordChange = RxString('');

  void clearTextFieldProp() {
    username.clear();
    email.clear();
    password.clear();
    confirmPassword.clear();
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
    confirmPasswordFocusNode.unfocus();
  }

  void onObsecurePasswordTapped() {
    passwordObscure.toggle();
  }

  void onObsecureConfirmPasswordTapped() {
    confirmPasswordObscure.toggle();
  }

  void emailValidation() {
    if (email.text == '' || email.text.isEmpty) {
      emailError.value = 'Please enter email';
    } else if (!GetUtils.isEmail(email.text)) {
      emailError.value = 'Please enter valid email';
    } else {
      // Clear the error if email is valid
      emailError.value = '';
    }
  }

  void passwordValidation() {
    if (password.text == '' || password.text.isEmpty) {
      passwordError.value = 'Please enter password';
    } else if (password.text.length < 8) {
      passwordError.value = 'Password must be at least 8 characters';
    } else {
      // Clear the error if password is valid
      passwordError.value = '';
    }
  }

  void confirmPasswordValidation() {
    if (confirmPassword.text == '' || confirmPassword.text.isEmpty) {
      confirmPasswordError.value = 'Please enter confirm password';
    } else if (confirmPassword.text != password.text) {
      confirmPasswordError.value = 'Password does not match';
    } else {
      // Clear the error if password is valid
      confirmPasswordError.value = '';
    }
  }

  String? usernameValidators(value) {
    if (value.length == 0) {
      return 'Please enter username';
    }
    return null;
  }

  String? emailValidations(value) {
    if (value.length == 0) {
      return 'Please enter an email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? passwordValidations(value) {
    if (value.length == 0) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? confirmPasswordValidations(value) {
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (value != password.text) {
      return 'Password does not match';
    }
    return null;
  }

  void signUp() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 5000));
      Get.toNamed('/login');
    }
  }

  @override
  void onInit() {
    super.onInit();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();

    emailValidation();
    passwordValidation();
    confirmPasswordValidation();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    usernameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
    clearTextFieldProp();
  }
}
