import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  10), // Define o raio para arredondamento
              color: CustomColors.white, // Cor de fundo do container
            ),
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                CustomTextField(
                  icon: Icons.person,
                  label: "Nome",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
