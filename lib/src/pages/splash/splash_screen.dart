import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uni_links2/uni_links.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription? _sub;
  @override
  void initState() {
    super.initState();
    initUniLinks();
    loadImage();
  }

  Future<void> loadImage() async {
    // Simula um tempo de carregamento da imagem
    await Future.delayed(const Duration(seconds: 3));

    // Marca a imagem como carregada
  }

  Future<void> initUniLinks() async {
    _sub = linkStream.listen((String? link) {
      if (link != null) {
        print('Listener is working');
        final uri = Uri.parse(link);
        if (uri.queryParameters['id'] != null) {
          print(uri.queryParameters['id'].toString());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white, // Cor de fundo da splash screen
      body: Center(
        child: SizedBox(
          height: size.height * 0.8,
          width: size.width * 0.4,
          child: Image.asset(
            'assets/SIMBOLO-2.png', // Substitua 'assets/SIMBOLO-2.png' pelo caminho da sua imagem
            fit: BoxFit.contain,
          ),
        ),
        // Exibe um indicador de progresso enquanto a imagem está carregando
      ),
    );
  }
}
