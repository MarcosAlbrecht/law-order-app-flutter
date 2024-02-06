import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/auth/controller/auth_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetMaterialApp(
      title: 'Prestadio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: CustomColors.white,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

        textTheme: GoogleFonts.robotoTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.roboto(
            textStyle: textTheme.bodySmall,
            letterSpacing: 1,
          ),
          bodyLarge: GoogleFonts.roboto(
            textStyle: textTheme.bodyMedium,
            letterSpacing: 1,
          ),
          titleLarge: GoogleFonts.roboto(
            textStyle: textTheme.titleLarge,
            letterSpacing: 1,
          ),
          titleMedium: GoogleFonts.roboto(
            textStyle: textTheme.titleMedium,
            letterSpacing: 1,
          ),
          titleSmall: GoogleFonts.roboto(
            textStyle: textTheme.titleSmall,
            letterSpacing: 1,
          ),
        ),
      ),
      getPages: AppPages.pages,
      initialRoute: PagesRoutes.signInRoute,
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('pt'),
      ],
    );
  }
}


/**
 * VER OS FILTROS DA TELA HOME
 * FAZER O CHAT
 * VER O BOTAO DE CHAT TELA DE GERENCIAMENTO DE PAGAMENTO
 * VER A TELA DE EXCLUIR APP NO PROFILE
 */
