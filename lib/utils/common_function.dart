import 'package:drivvo/routes/app_routes.dart';
import 'package:drivvo/services/app_service.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CommonFunction {
  final appService = AppService.to;
  // Future<void> getAllVehicleList() async {
  //   try {
  //     final snapshot = await FirebaseFirestore.instance
  //         .collection(DatabaseTables.USER_PROFILE)
  //         .doc(appService.appUser.value.id)
  //         .collection(DatabaseTables.VEHICLES)
  //         .get();

  //     if (snapshot.docs.isNotEmpty) {
  //       appService.allVehiclesCount.value = snapshot.docs.length;
  //       await appService._box.write(Constants.ALL_VEHICLES_COUNT, snapshot.docs.length);
  //       return;
  //     }
  //   } catch (e) {
  //     debugPrint("getAllVehicleList error: $e");
  //     return;
  //   }
  //   return;
  // }

  static Future<void> deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Utils.showSnackBar(message: "something_went_wrong".tr, success: false);
      return;
    }

    Utils.showProgressDialog();

    try {
      await user.delete();

      Get.back();

      try {
        await FirebaseAuth.instance.signOut();
      } catch (_) {
        // Ignore signout errors after successful deletion
      }

      Get.offAllNamed(AppRoutes.LOGIN_VIEW);

      Utils.showSnackBar(message: "account_deleted".tr, success: true);
    } on FirebaseAuthException catch (e) {
      Get.back();

      if (e.code == 'requires-recent-login') {
        Utils.showSnackBar(message: "login_again_to_delete".tr, success: false);
      } else {
        Utils.showSnackBar(message: "account_delete_failed".tr, success: false);
      }
    } catch (e) {
      Get.back();
      Utils.showSnackBar(message: "something_went_wrong".tr, success: false);
    }
  }
}
