import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/constants/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class UtilServices {
  final box = GetStorage();

  void showToast({
    required String message,
    bool isError = false,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: isError ? Colors.red : CustomColors.blueColor,
      textColor: isError ? Colors.white : CustomColors.white,
      fontSize: 16,
    );
  }

  void showToastNewChatMessage({
    required String message,
    bool showSnackbar = false,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: showSnackbar ? ToastGravity.SNACKBAR : ToastGravity.BOTTOM_LEFT,
      timeInSecForIosWeb: 3,
      backgroundColor: CustomColors.blueColor,
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  Future<void> saveLocalData(
      {required String email, required String? senha, required String token, required bool googleLogin}) async {
    await box.write(StorageKeys.email, email);
    await box.write(StorageKeys.password, senha ?? '');
    await box.write(StorageKeys.token, token);
    await box.write(StorageKeys.googleLogin, googleLogin);
  }

  Future<String> getEmailLocalData() async {
    print(box.read(StorageKeys.email));
    return await box.read(StorageKeys.email) ?? '';
  }

  Future<String> getPasswordlLocalData() async {
    return await box.read(StorageKeys.password) ?? '';
  }

  Future<String> getToken() async {
    return await box.read(StorageKeys.token) ?? '';
  }

  Future<bool> getGoogleLogin() async {
    return await box.read(StorageKeys.googleLogin) ?? false;
  }

  Future<void> removeLocalData() async {
    await box.remove(StorageKeys.email);
    await box.remove(StorageKeys.password);
    await box.remove(StorageKeys.token);
    await box.remove(StorageKeys.googleLogin);
  }

  Future<String> convertBirthday(String date) async {
    try {
      DateTime data = DateTime.parse(date);

      String formattedDate = DateFormat('dd/MM/yyyy').format(data);
      return formattedDate;
    } catch (e) {
      return date;
    }
  }

  //R$ VALOR
  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(
      locale: 'pt_BR',
    );

    return numberFormat.format(price);
  }

  //converter a data do banco para usuario
  String formatDateTime(String? originalDateTimeString) {
    if (originalDateTimeString == null || originalDateTimeString.isEmpty) {
      return '';
    }
    // Convertendo a string para um objeto DateTime
    DateTime originalDateTime = DateTime.parse(originalDateTimeString);

    // Formatando a data e hora para o novo formato desejado
    String formattedDateTime =
        "${originalDateTime.day.toString().padLeft(2, '0')}/${originalDateTime.month.toString().padLeft(2, '0')}/${originalDateTime.year} "
        "${originalDateTime.hour.toString().padLeft(2, '0')}:${originalDateTime.minute.toString().padLeft(2, '0')}:${originalDateTime.second.toString().padLeft(2, '0')}";

    return formattedDateTime;
  }

  String formatDate(String? originalDateTimeString) {
    if (originalDateTimeString == null || originalDateTimeString.isEmpty) {
      return '';
    }
    // Convertendo a string para um objeto DateTime
    DateTime originalDateTime = DateTime.parse(originalDateTimeString);

    // Formatando a data e hora para o novo formato desejado
    String formattedDateTime =
        "${originalDateTime.day.toString().padLeft(2, '0')}/${originalDateTime.month.toString().padLeft(2, '0')}/${originalDateTime.year}";
    //"${originalDateTime.hour.toString().padLeft(2, '0')}:${originalDateTime.minute.toString().padLeft(2, '0')}:${originalDateTime.second.toString().padLeft(2, '0')}";

    return formattedDateTime;
  }

  String formatTime(String? originalDateTimeString) {
    if (originalDateTimeString == null || originalDateTimeString.isEmpty) {
      return '';
    }

    // Convertendo a string para um objeto DateTime em UTC
    DateTime originalDateTime = DateTime.parse(originalDateTimeString);

    // Convertendo para o fuso horário local do dispositivo
    DateTime localDateTime = originalDateTime.toLocal();

    // Formatando a hora para o novo formato desejado
    String formattedDateTime =
        "${localDateTime.hour.toString().padLeft(2, '0')}:${localDateTime.minute.toString().padLeft(2, '0')}";

    return formattedDateTime;
  }

  String formatDateToBD(DateTime selectedDate) {
    // Convertendo para formato ISO 8601
    String iso8601String = selectedDate.toIso8601String();

    // Agora você pode enviar 'iso8601String' para a sua API Node.js
    return iso8601String;
  }

  String getCurrentDateTimeInISO8601Format() {
    DateTime now = DateTime.now().toUtc();
    String formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(now);
    return formattedDate;
  }
}
