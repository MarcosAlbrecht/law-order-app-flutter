import 'package:app_law_order/src/pages/chat/controller/chat_service.dart';
import 'package:get/get.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatService());
  }
}
