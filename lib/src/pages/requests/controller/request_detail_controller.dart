import 'package:app_law_order/src/models/request_model.dart';
import 'package:get/get.dart';

class RequestDetailController extends GetxController {
  String currentCategory;
  RequestModel request;

  RequestDetailController({
    required this.request,
    required this.currentCategory,
  });
}
