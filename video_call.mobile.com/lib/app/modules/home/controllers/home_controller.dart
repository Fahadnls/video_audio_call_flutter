import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../../constants/constants.dart';
import '../../../../services/login_service.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  final TextEditingController singleInviteeUserIDTextCtrl =
      TextEditingController();
  final TextEditingController groupInviteeUserIDsTextCtrl =
      TextEditingController();

  Future<void> logoutUser() async {
    await logout();
    onUserLogout();
    Get.offAllNamed(Routes.login);
  }

  void onSendCallInvitationFinished(
    String code,
    String message,
    List<String> errorInvitees,
  ) {
    final context = Get.context;
    if (context == null) {
      return;
    }

    if (errorInvitees.isNotEmpty) {
      var userIDs = '';
      for (var index = 0; index < errorInvitees.length; index++) {
        if (index >= 5) {
          userIDs += '... ';
          break;
        }
        final userID = errorInvitees.elementAt(index);
        userIDs += '$userID ';
      }
      if (userIDs.isNotEmpty) {
        userIDs = userIDs.substring(0, userIDs.length - 1);
      }

      var errorMessage = "User doesn't exist or is offline: $userIDs";
      if (code.isNotEmpty) {
        errorMessage += ', code: $code, message:$message';
      }
      showToast(
        errorMessage,
        position: StyledToastPosition.top,
        context: context,
      );
    } else if (code.isNotEmpty) {
      showToast(
        'code: $code, message:$message',
        position: StyledToastPosition.top,
        context: context,
      );
    }
  }

  List<ZegoUIKitUser> getInvitesFromTextCtrl(String textCtrlText) {
    final invitees = <ZegoUIKitUser>[];
    final inviteeIDs = textCtrlText.trim().replaceAll('，', '');
    inviteeIDs.split(',').forEach((inviteeUserID) {
      if (inviteeUserID.isEmpty) return;

      invitees.add(
        ZegoUIKitUser(id: inviteeUserID, name: 'user_$inviteeUserID'),
      );
    });
    return invitees;
  }

  @override
  void onClose() {
    singleInviteeUserIDTextCtrl.dispose();
    groupInviteeUserIDsTextCtrl.dispose();
    super.onClose();
  }
}
