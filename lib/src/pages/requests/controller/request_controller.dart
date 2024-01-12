import 'package:app_law_order/src/models/request_model.dart';
import 'package:app_law_order/src/pages/requests/repository/request_repository.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';

const int itemsPerPage = 10;

class RequestController extends GetxController {
  final requestsRepository = RequestRepository();
  final utilServices = UtilServices();

  int pagination = 0;

  bool isLoading = false;

  String currentCategory = "received";

  List<RequestModel>? currentListRequest;

  List<RequestModel> allRequest = [];

  bool get isLastPage {
    if (currentListRequest!.length < itemsPerPage) return true;

    return pagination + itemsPerPage > allRequest.length;
  }

  @override
  void onInit() {
    super.onInit();

    loadRequests();
  }

  void setLoading(bool value, {bool isUser = false}) {
    if (isUser) {
      isLoading = value;
    }
    update();
  }

  Future<void> loadRequests({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isUser: true);
    }
    final result = await requestsRepository.getRequestsReceived(
        limit: itemsPerPage, skip: pagination);

    setLoading(false, isUser: true);
    result.when(
      success: (data) {
        currentListRequest = data;
        allRequest.addAll(currentListRequest!);
      },
      error: (message) {},
    );
  }

  void loadMoreRequestsReceived() {
    pagination = pagination + 10;
    loadRequests(canLoad: false);
  }

  void selectCategory({required String value}) {
    setLoading(true);
    currentCategory = value;

    //carregar itens da api
    setLoading(true);
  }
}
