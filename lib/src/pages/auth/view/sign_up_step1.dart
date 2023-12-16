import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:flutter/material.dart';

class SignUpStep1 extends StatefulWidget {
  const SignUpStep1({Key? key}) : super(key: key);

  @override
  _SignUpStep1State createState() => _SignUpStep1State();
}

class _SignUpStep1State extends State<SignUpStep1> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cadastro",
          style: TextStyle(color: CustomColors.black),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(10), // Define o raio para arredondamento
            color: CustomColors.white, // Cor de fundo do container
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/MARCA-DAGUA.png",
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Divider(
                  height: 40,
                ),
              ),
              Text(
                "Como você quer utilizar a Prestadio?",
                style: TextStyle(
                    color: CustomColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: CustomFontSizes.fontSize16),
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
              SizedBox(
                height: size.height / 3.5,
                width: size.width / 1.5,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                  color: CustomColors.blueColor,
                  child: Center(
                    child: Text(
                      "Quero trabalhar",
                      style: TextStyle(
                          color: CustomColors.white,
                          fontSize: CustomFontSizes.fontSize24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
              SizedBox(
                height: size.height / 3.5,
                width: size.width / 1.5,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                  color: CustomColors.blueColor,
                  child: Center(
                    child: Text(
                      "Quero contratar",
                      style: TextStyle(
                          color: CustomColors.white,
                          fontSize: CustomFontSizes.fontSize24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
