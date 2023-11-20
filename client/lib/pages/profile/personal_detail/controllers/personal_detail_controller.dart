import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum Gender { male, female }

class PersonalDetailController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  Rx<Gender> gender = Gender.male.obs;
  late final TextEditingController birthDateController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;

  RxBool isLoading = RxBool(false);

  void changeGenderToMale() {
    gender.value = Gender.male;
  }

  void changeGenderToFemale() {
    gender.value = Gender.female;
  }

  void changeDate(ctx) async {
    DateTime? pickedDate = await showDatePicker(
        context: ctx,
        initialDate: DateTime(2023, 1, 1),
        firstDate: DateTime(1970),
        lastDate: DateTime(2023));

    if (pickedDate != null) {
      birthDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  void savePersonalDetail() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.toggle();
        //save personal details
      } catch (e) {
        if (e is DioException) {
          final errorResponse = e.response;
          if (errorResponse != null) {
            final errorMessage = errorResponse.data?['message'];
            Get.snackbar('Error', errorMessage ?? 'Unknown error');
          } else {
            Get.snackbar('Error', 'Unknown error occurred');
          }
          isLoading.toggle();
        }
      }
    }
  }

  @override
  void onInit() {
    nameController = TextEditingController();
    birthDateController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    birthDateController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
