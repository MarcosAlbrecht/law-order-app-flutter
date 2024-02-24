import 'package:app_law_order/src/config/app_data.dart';
import 'package:app_law_order/src/models/follows_model.dart';
import 'package:app_law_order/src/models/occupation_areas_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:app_law_order/src/pages/home/repository/home_repository.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';

const int itemsPerPage = 10;

class HomeController extends GetxController {
  final homeRepository = HomeRepository();

  final utilServices = UtilServices();

  final authController = Get.find<AuthController>();

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

  bool isUserLoading = false;

  void setLoading(bool value, {bool isUser = false}) {
    if (isUser) {
      isUserLoading = value;
    }
    update();
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
