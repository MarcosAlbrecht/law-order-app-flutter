import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _imageLoaded = false;
  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    // Simula um tempo de carregamento da imagem
    await Future.delayed(const Duration(seconds: 3));

    // Marca a imagem como carregada
    setState(() {
      _imageLoaded = true;
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
