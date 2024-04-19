import 'package:app_law_order/src/config/app_data.dart';
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/follows_model.dart';
import 'package:app_law_order/src/models/occupation_areas_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/home/repository/home_repository.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

const int itemsPerPage = 10;

class HomeController extends GetxController {
  final homeRepository = HomeRepository();

  final utilServices = UtilServices();

  final authController = Get.find<AuthController>();

  late String tokenOneSignal;

  List<UserModel>? currentListUser;

  List<OccupationAreasModel> occupationsAreas = occupationAreas;

  List<UserModel> allUsers = [];
  List<FollowsModel> follows = [];
  List<String> cities = [];
  List<String> states = [];
  List<Map<String, dynamic>> filters = [];

  String stateSelected = "";
  String citySected = "";
  String occupationAreaSelected = "";

  RxString searchRequest = ''.obs;
  final isInitialized = false.obs;

  int pagination = 0;

  bool get isLastPage {
    if (currentListUser!.length < itemsPerPage) return true;

    return pagination + itemsPerPage > allUsers.length;
  }

  @override
  void onInit() {
    super.onInit();

    debounce(
      searchRequest,
      (_) => filterByTitle(),
      time: const Duration(milliseconds: 600),
    );

    //loadAllUsers();
    loadDatas();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    showAlertDialog();
  }

  bool isUserLoading = false;

  void setLoading(bool value, {bool isUser = false}) {
    if (isUser) {
      isUserLoading = value;
    }
    update();
  }

  void showAlertDialog() {
    // Exibir o dialog para habilitar push notifications
    if (authController.user.tokenOneSignal == null || authController.user.tokenOneSignal!.isEmpty) {
      Get.dialog(
        AlertDialog(
          title: const Text("🔔 Notificações Push! 🔔"),
          content: const Text(
              '''Não perca nenhuma novidade no nosso aplicativo! Ative as notificações push para receber atualizações importantes.

Com as notificações push ativadas, você ficará por dentro de tudo o que acontece no aplicativo, em tempo real. Não se preocupe, prometemos enviar apenas informações relevantes e importantes para você. 

Cocê poderá acessar a aba Perfil > Configurações e desativar as notificações.'''),
          actions: [
            TextButton(
              onPressed: () {
                //controller.cleanFilters();
                Get.back(result: false); // Fechar o diálogo
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.blueDark2Color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                //controller.applyFilters();
                await handleChangeTokenOneSignal();
                Get.back(result: true);
              },
              child: Text(
                'Ativar',
                style: TextStyle(
                  color: CustomColors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<void> getTokenOneSignal() async {
    //print("ENTROU NO GET TOKEN: ");

    await OneSignal.User.pushSubscription.optIn();

    tokenOneSignal = OneSignal.User.pushSubscription.id.toString();

    print(tokenOneSignal);
    //handleChangeTokenOneSignal();
  }

  Future<void> handleChangeTokenOneSignal() async {
    setLoading(true);
    if (authController.user.tokenOneSignal == null || authController.user.tokenOneSignal!.isEmpty) {
      await getTokenOneSignal();
    } else {
      tokenOneSignal = '';
    }
    final result = await homeRepository.updateTokenOneSignal(user: authController.user, token: tokenOneSignal);
    setLoading(false);
    result.when(
      success: (data) {
        authController.user.tokenOneSignal = tokenOneSignal;
      },
      error: (message) {},
    );
  }

  Future<void> loadDatas() async {
    setLoading(true, isUser: true);
    List<Future<void>> operations = [
      loadAllUsers(),
      loadFollows(),
      loadStates(),
      loadCities(),
    ];

    occupationsAreas.sort((a, b) => (a.area ?? '').compareTo(b.area ?? ''));

    await Future.wait(operations);
    isInitialized.value = true;

    setLoading(false, isUser: true);
  }

  Future<void> loadStates() async {
    final result = await homeRepository.getStates();
    result.when(
      success: (data) {
        states.addAll(data);
        states.sort((a, b) => a.compareTo(b));
      },
      error: (message) {
        //erro ao buscar os estados
      },
    );
  }

  Future<void> loadCities() async {
    final result = await homeRepository.getCities();
    result.when(
      success: (data) {
        cities.addAll(data);
        cities.sort((a, b) => a.compareTo(b));
      },
      error: (message) {
        //erro ao buscar as cidades
      },
    );
  }

  Future<void> loadFollows() async {
    var result = await homeRepository.getFollows();

    result.when(
      success: (data) {
        follows.clear();
        follows.addAll(data);
      },
      error: (message) {},
    );
  }

  Future<void> loadAllUsers({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isUser: true);
    }

    var result = await homeRepository.getAllUsersPaginated(limit: itemsPerPage, skip: pagination, filters: filters);

    setLoading(false, isUser: true);

    result.when(
      success: (data) {
        currentListUser = data;
        allUsers.addAll(currentListUser!);
      },
      error: (message) {
        utilServices.showToast(message: message);
      },
    );
  }

  Future<void> handleFollow({required FollowsModel? follow, required UserModel user}) async {
    setLoading(true, isUser: true);
    if (follow == null) {
      //adicionar follow
      await homeRepository.setFollow(userId: user.id!);
      await loadFollows();
    } else {
      //remover follow
      await homeRepository.setUnFollow(userId: user.id!);
      follows.removeWhere((follow) => follow.followedId == user.id);
    }
    setLoading(false, isUser: true);
  }

  void loadMoreProducts() {
    pagination = pagination + 10;
    loadAllUsers(canLoad: false);
  }

  void toggleStateItem(int index) {
    stateSelected = states[index];
    update(); // Atualiza a interface quando o estado muda
  }

  void toggleCityItem(int index) {
    citySected = cities[index];
    update(); // Atualiza a interface quando o estado muda
  }

  void toggleOccupationAreaItem(int index) {
    occupationAreaSelected = occupationsAreas[index].area!;
    update(); // Atualiza a interface quando o estado muda
  }

  void cleanFilters() {
    stateSelected = "";
    citySected = "";
    occupationAreaSelected = "";
    pagination = 0;
    currentListUser = [];
    allUsers = [];
    filters = [];
    //se tiver algo preenchido no filtro por nome, adicionar novamente
    if (occupationAreaSelected.isNotEmpty) {
      filters.add({'filters[occupationAreas][0]': occupationAreaSelected});
    }
    loadAllUsers(); // Atualiza a interface quando o estado muda
  }

  Future<void> applyFilters() async {
    filters.clear();
    if (stateSelected.isNotEmpty) {
      filters.add({'filters[state]': stateSelected});
    }
    if (citySected.isNotEmpty) {
      filters.add({'filters[cities][0]': citySected});
    }
    if (occupationAreaSelected.isNotEmpty) {
      filters.add({'filters[occupationAreas][0]': occupationAreaSelected});
    }

    pagination = 0;
    currentListUser = [];
    allUsers = [];

    loadAllUsers();
  }

  void filterByTitle() {
    //setLoading(true, isUser: true);
    if (searchRequest.value.isEmpty) {
      currentListUser = [];
      pagination = 0;
      allUsers.clear();
      filters.removeWhere((element) => element.containsKey('search'));
      //loadAllUsers();
    } else {
      currentListUser = [];
      pagination = 0;
      allUsers.clear();
      filters.add({'search': searchRequest.value});
    }

    loadAllUsers();

    //setLoading(false, isUser: true);
  }
}
