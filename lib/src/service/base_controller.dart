import 'package:bakulpay/src/service/app_exception.dart';
import 'package:get/get.dart';

mixin BaseController {
  void handleError(error) {
    if (error is BadRequestException) {
      var message = error.message;
      Get.rawSnackbar(message: message);
    } else if (error is FetchDataException) {
      var message = error.message;
      Get.rawSnackbar(message: message);
    } else if (error is ApiNotRespondingException) {
      Get.rawSnackbar(message: 'Oops! It took longer to respond');
    }
  }
}
