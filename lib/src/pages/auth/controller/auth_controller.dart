import 'dart:async';
import 'dart:io';

import 'package:app_law_order/src/config/app_data.dart';
import 'package:app_law_order/src/models/occupation_areas_model.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:app_law_order/src/pages/auth/repository/auth_repository.dart';
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthController extends GetxController {
  final authRepository = AuthRepository();
  final utilServices = UtilServices();

  static const List<String> scopes = <String>['email', 'profile', 'openid'];

  final _googleSignin = GoogleSignIn(
      scopes: scopes,
      clientId: Platform.isAndroid
          ? '183592142336-om2umt7mohiad5gbrbiaj4hkr8f80svj.apps.googleusercontent.com'
          : '183592142336-amugpmh4k444jkfh4ik7rsqdonnv777a.apps.googleusercontent.com');
  var googleAccount = Rx<GoogleSignInAccount?>(null);

  UserModel user = UserModel();

  List<OccupationAreasModel> occupationsAreas = occupationAreas;

  RxBool isLoading = false.obs;
  bool isSaving = false;
  RxBool isWork = false.obs;
  bool isValidCep = false;

  String? confirmPassword;

  @override
  void onInit() {
    super.onInit();

    validateLogin();
    //print(occupationsAreas);

    //print(googleAccount);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  void setSaving(bool value) {
    isSaving = value;
    update();
  }

  void setIsLoading(bool value) {
    isLoading.value = value;
    update();
  }

  Future<void> loginGoogle() async {
    googleAccount.value = await _googleSignin.signIn();
    GoogleSignInAuthentication? googleAuth = await googleAccount.value?.authentication;

    //update();
    if (googleAuth == null || googleAuth.idToken == null) {
      utilServices.showToast(message: 'Não foi possivel obter os dados do google. Tente novamente mais tarde!');
      return;
    }
    setIsLoading(true);
    final result = await authRepository.googleSignIn(token: googleAuth.idToken!);
    await _googleSignin.disconnect();
    setIsLoading(false);
    result.when(
      success: (data) {
        user = data;
        saveTokenAndProceedToBase(user.email ?? '', user.password ?? '', user.accessToken!, googleLogin: true);
      },
      error: (message) {
        user.email = googleAccount.value!.email;
        user.firstName = googleAccount.value!.displayName;
        Get.offAllNamed(PagesRoutes.signupGoogleRoute);
      },
    );
  }

  Future<void> loginApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
          clientId: 'com.prestadioapp.prestadio',
          redirectUri:
              // For web your redirect URI needs to be the host of the "current page",
              // while for Android you will be using the API server that redirects back into your app via a deep link
              // NOTE(tp): For package local development use (as described in `Development.md`)
              // Uri.parse('https://siwa-flutter-plugin.dev/')

              Uri.parse(
                  'intent://callback?code=<code>&id_token=<jwttoken>#Intent;package=androidappid;scheme=signinwithapple;end'),
        ),
      );

      print(credential);

      // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
      // after they have been validated with Apple (see `Integration` section for more information on how to do this)

      print("Given Name: ${credential.givenName}");
      print("Family Name: ${credential.familyName}");
      print("email: ${credential.email}");
      print("state: ${credential.state}");
      print("Authorization Code: ${credential.authorizationCode}");
      print("User Identifier: ${credential.userIdentifier}");
      print("Identity Token: ${credential.identityToken}");

      setIsLoading(true);
      final result = await authRepository.appleSignIn(token: credential.identityToken!);
      setIsLoading(false);
      result.when(
        success: (data) {
          user = data;
          saveTokenAndProceedToBase(user.email ?? '', user.password ?? '', user.accessToken!, googleLogin: true);
        },
        error: (message) {
          Map<String, dynamic> decodedToken1 = JwtDecoder.decode("${credential.identityToken}");
          print("Token decoded: ${credential.identityToken}");
          String? emailFromToken = decodedToken1['email'];
          user.email = emailFromToken;
          user.firstName = '';
          Get.offAllNamed(PagesRoutes.signupGoogleRoute);
        },
      );
    } on Exception catch (e) {
      // TODO
      print(e);
    }

    // Map<String, dynamic> decodedToken = JwtDecoder.decode("${credential.identityToken}");
    // print(decodedToken);
  }

  Future<void> validateLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    String? email = await utilServices.getEmailLocalData();
    String? password = await utilServices.getPasswordlLocalData();
    String? token = await utilServices.getToken();
    bool googleLogin = await utilServices.getGoogleLogin();

    if (token.isNotEmpty || googleLogin) {
      await signInWithAccessToken(accessToken: token);
      return;
    }

    if (email.isNotEmpty && password.isNotEmpty) {
      signIn(email: email, password: password);
    } else {
      Get.offAllNamed(PagesRoutes.signInRoute);
    }
  }

  Future<void> signInWithAccessToken({required String accessToken}) async {
    setIsLoading(true);
    var result = await authRepository.signInWithAccessToken(accessToken: accessToken);
    setIsLoading(false);

    result.when(
      success: (data) async {
        user = data;

        saveTokenAndProceedToBase(user.email ?? '', user.password ?? '', accessToken, googleLogin: true);
      },
      error: (message) async {
        utilServices.showToast(message: message, isError: true);
        await utilServices.removeLocalData();
        Get.offAllNamed(PagesRoutes.signInRoute);
      },
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    setIsLoading(true);
    var result = await authRepository.signIn(email: email, password: password);
    setIsLoading(false);

    result.when(
      success: (data) {
        user = data;
        user.password = password;
        saveTokenAndProceedToBase(user.email ?? '', password, user.accessToken!);
      },
      error: (message) async {
        utilServices.showToast(message: message, isError: true);
        await utilServices.removeLocalData();
        Get.offAllNamed(PagesRoutes.signInRoute);
      },
    );
  }

  //insere um novo usuario
  Future<void> handleSignUp() async {
    //verifica se as senhas sáo iguais
    if ((user.password != confirmPassword) || user.password == null || confirmPassword == null) {
      utilServices.showToast(message: "A senhas não conferem!");
      return;
    }

    //verifica se o cep foi validado
    if (!isValidCep) {
      utilServices.showToast(message: "CEP inválido!");
      return;
    }

    //formata a data para modelo 10/10/1999
    user.birthday = await utilServices.convertBirthday(user.birthday!);

    setSaving(true);

    //chamar a api para efetuar cadastro
    var result = await authRepository.signUp(user: user);

    result.when(
      success: (data) async {
        utilServices.showToast(message: "Cadastro realizado com sucesso!");
        var password = user.password;
        final email = user.email!;
        user = data;
        //realizar o login e salva os dados localmente
        await signIn(email: email, password: password!);
        //saveTokenAndProceedToBase(user.email!, password!, user.accessToken!);
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
      },
    );

    setSaving(false);
  }

  Future<void> handleProfileEdit({bool validaCep = true}) async {
    //verifica se o cep foi validado
    if (validaCep) {
      final validCep = await handleValidateCep(cep1: user.cep!);

      if (!validCep) {
        utilServices.showToast(message: "CEP inválido");
        return;
      }
    }

    setSaving(true);

    //chamar a api para editar perfil
    var result = await authRepository.editProfile(user: user);

    setSaving(false);

    result.when(
      success: (data) {
        utilServices.showToast(message: "Cadastro editado com sucesso!");
        var password = user.password;
        user = data;
        //saveTokenAndProceedToBase(user.email!, password!, user.accessToken!);
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
      },
    );

    isValidCep = false;
  }

  //envia email de recuperaçao de senha
  Future<void> handleForgotPassword({required String email}) async {
    var result = await authRepository.forgotPassword(email: email);
    result.when(success: (data) {
      utilServices.showToast(message: data);
    }, error: (message) {
      utilServices.showToast(message: message, isError: true);
    });
  }

  void saveTokenAndProceedToBase(String email, String? password, String token, {googleLogin = false}) {
    //salvar o token
    utilServices.saveLocalData(
      email: email,
      senha: password,
      token: token,
      googleLogin: googleLogin,
    );
    //ir para a tela base
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  //valida o cep digitado
  Future<bool> handleValidateCep({required String cep1}) async {
    var cep2 = cep1.replaceAll("-", "");
    var result = await authRepository.getCep(cep: cep2);
    result.when(
      success: (data) {
        isValidCep = true;
        user.city = data.localidade;
        user.state = data.uf;
        user.cep = cep2;
        return true;
      },
      error: (message) {
        isValidCep = false;
        utilServices.showToast(message: message, isError: true);
        return false;
      },
    );
    return true;
  }

  Future<void> getUserById() async {
    final result = await authRepository.getUserById(user: user);
    result.when(
      success: (data) {
        user = data;
      },
      error: (message) {
        utilServices.showToast(message: message);
      },
    );
  }

  Future<void> logout() async {
    await utilServices.removeLocalData();
    user = UserModel();
    Get.offAllNamed(PagesRoutes.signInRoute);
  }
}
