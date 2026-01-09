import 'package:drivvo/services/app_service.dart';
import 'package:drivvo/services/iap_service.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PlanController extends GetxController {
  late AppService appService;

  var isYearlyBilling = false.obs;

  bool get isUrdu => Get.locale?.languageCode == Constants.URDU_LANGUAGE_CODE;
  var planName = ''.obs;

  final IAPService _iapService = IAPService.to;

  RxList<ProductDetails> get productsList => _iapService.products;
  RxBool get isLoading => _iapService.isLoading;
  RxBool get isPurchasing => _iapService.isPurchasing;
  RxBool get isRestoring => _iapService.isRestorePurchasing;
  RxBool get isAvailable => _iapService.isAvailable;
  bool get hasProducts => _iapService.hasProducts;
  String? get errorMessage => _iapService.errorMessage;

  // Logic to select which product is selected in UI
  final Rx<ProductDetails?> selectedProduct = Rx<ProductDetails?>(null);

  @override
  void onInit() {
    super.onInit();
    appService = Get.find<AppService>();

    ever(productsList, (List<ProductDetails> data) {
      if (data.isNotEmpty && selectedProduct.value == null) {
        selectedProduct.value = data.first;
        planName.value = data.first.id;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    // Check subscription status when plan screen is ready
    _iapService.checkSubscriptionStatus();
  }

  void selectProduct(ProductDetails product) {
    selectedProduct.value = product;
    planName.value = product.id;
  }

  Future<void> restore() async {
    // Guard: Check connectivity
    if (!appService.connected.value) {
      Utils.showSnackBar(message: "check_internet_connection", success: false);
      return;
    }

    // Guard: Check IAP availability
    if (!isAvailable.value) {
      Utils.showSnackBar(message: "iap_not_available", success: false);
      return;
    }

    // Guard: Prevent duplicate operations
    if (isPurchasing.value) {
      return;
    }

    await _iapService.restorePurchases();
  }

  Future<void> buySelectedProduct() async {
    // Guard: Check connectivity
    if (!appService.connected.value) {
      Utils.showSnackBar(message: "check_internet_connection", success: false);
      return;
    }

    // Guard: Check IAP availability
    if (!isAvailable.value) {
      Utils.showSnackBar(message: "iap_not_available", success: false);
      return;
    }

    // Guard: Check if products are loaded
    if (!hasProducts) {
      Utils.showSnackBar(message: "products_loading", success: false);
      return;
    }

    // Guard: Check if product is selected
    if (selectedProduct.value == null) {
      Utils.showSnackBar(message: "select_subscription_plan", success: false);
      return;
    }

    // Guard: Prevent duplicate purchases
    if (isPurchasing.value) {
      return;
    }

    await _iapService.buyProduct(selectedProduct.value!);
  }
}
