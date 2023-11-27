import 'package:client/services/api_service/courier/courier_models.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PlaceOrderController extends GetxController {
  RxList<Courier> couriers = <Courier>[].obs;
  RxBool isLoading = RxBool(false);
  final dio = Dio();
  Rx<Courier?> selectedCourier = Rx<Courier?>(null);

  Future<void> getCouriers() async {
    try {
      isLoading.toggle();
      final res = await dio.get('https://stylish-shop.vercel.app/couriers');
      final List<dynamic> result = res.data;
      couriers.value = result.map((e) => Courier.fromJson(e)).toSet().toList();
      isLoading.toggle();
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

  void setSelectedCourier(Courier? courier) {
    selectedCourier.value = courier;
    update();
  }

  num get courierFee {
    return selectedCourier.value?.price ?? 0;
  }

  @override
  void onInit() {
    getCouriers();
    super.onInit();
  }
}
