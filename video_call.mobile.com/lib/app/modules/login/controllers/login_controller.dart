import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/login_service.dart';
import '../../../../utils/utils.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final userIdController = TextEditingController();
  final passwordVisible = false.obs;
  final userId = ''.obs;
  final isBusy = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initUserId();
  }

  Future<void> _initUserId() async {
    final generated = await getUniqueUserId();
    userIdController.text = generated;
    userId.value = generated;
  }

  void onUserIdChanged(String value) {
    userId.value = value.trim();
  }

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  Future<void> signIn() async {
    final value = userId.value;
    if (value.isEmpty || isBusy.value) {
      return;
    }

    isBusy.value = true;
    try {
      await login(
        userID: value,
        userName: 'user_$value',
      );
      onUserLogin();
      Get.offAllNamed(Routes.home);
    } finally {
      isBusy.value = false;
    }
  }

  @override
  void onClose() {
    userIdController.dispose();
    super.onClose();
  }
}
