import 'package:app_law_order/src/pages/chat/repository/chat_repository.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';

class WalletPaymentsController extends GetxController {
  final chatRepository = ChatRepository();
  final utilServices = UtilServices();
}
