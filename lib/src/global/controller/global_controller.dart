import 'package:app_law_order/src/constants/endpoints.dart';
import 'package:app_law_order/src/models/notification_model.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GlobalService extends GetxService {
  final utilServices = UtilServices();

  late final String token;
  @override
  Future<void> onInit() async {
    print('iniciou o service');
    connect();
    super.onInit();
  }

  IO.Socket? socket;

  Future<void> connect() async {
    token = await utilServices.getToken();
    socket = IO.io(
      EndPoints.baseUrlNotification,
      IO.OptionBuilder().setTransports(['websocket']).setQuery({'Authorization': token}).enableAutoConnect().build(),
    );

    _connectServer();
  }

  void _connectServer() {
    socket?.onConnect((data) => print('Connected on server Notification'));
    socket?.onConnectError((data) => print('Error on Connect server  Notification $data'));
    socket?.onDisconnect((_) => print('disconnect server  Notification'));
    socket?.on('notification', (data) => _handleReceiveNewMessage(data));
  }

  void _handleReceiveNewMessage(dynamic data) {
    print(data);

    NotificationModel notification = NotificationModel.fromJson(data);
    utilServices.showToastNewChatMessage(message: notification.message!, showSnackbar: true);
  }
}
