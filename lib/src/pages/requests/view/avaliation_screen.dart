import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/avaliation_values_model.dart';
import 'package:app_law_order/src/models/request_model.dart';
import 'package:app_law_order/src/pages/profile/view/portfolio_screen.dart';
import 'package:app_law_order/src/pages/requests/controller/request_manager_controller.dart';
import 'package:app_law_order/src/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvaliationScreen extends StatefulWidget {
  AvaliationScreen({Key? key}) : super(key: key);

  final RequestModel request = Get.arguments ?? {};

  @override
  State<AvaliationScreen> createState() => _AvaliationScreenState();
}

class _AvaliationScreenState extends State<AvaliationScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        title: Text(
          'Avaliação',
          style: TextStyle(
            color: CustomColors.black,
          ),
        ),
        backgroundColor: CustomColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxHeight: size.height,
          maxWidth: size.width,
        ),
        child: SingleChildScrollView(
          child: GetBuilder<RequestManagerController>(
            builder: (controller) {
              return Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Formulário de Avaliação',
                      style: TextStyle(
                        fontSize: CustomFontSizes.fontSize20,
                        color: CustomColors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                        'Este formulário tem como objetivo coletar feedback dos usuários sobre o sistema de prestadores de serviço. Sua opinião é fundamental para aprimorarmos a plataforma e oferecermos uma experiência cada vez melhor 😁.'),
                    const Divider(
                      height: 25,
                    ),
                    Text(
                      'Avaliação do prestador: ${widget.request.requested!.firstName!} ${widget.request.requested!.lastName!}',
                      style: TextStyle(
                        fontSize: CustomFontSizes.fontSize14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      '1. Qual foi o nível de satisfação geral com o serviço que você recebeu?*',
                      style: TextStyle(
                        fontSize: CustomFontSizes.fontSize14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                      items: controller.avaliationsValues.map((question) {
                        return DropdownMenuItem<AvaliationValuesModel>(
                          value: question,
                          child: Text(
                            question.title!,
                          ), // Use o nome da área como rótulo
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.avaliation.levelOfSatisfaction = value!.value;
                      },
                      onSaved: (value) {
                        controller.avaliation.levelOfSatisfaction = value!.value;
                      },
                      validator: avaliationValidator,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: CustomColors.blueColor,
                          ), // Defina a cor desejada da borda
                        ),
                        //prefixIcon: const Icon(Icons.work_outline),
                        //labelText: "Selecione uma opção",
                        hintText: 'Selecione uma opção',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      '2. Qualidade do serviço prestado:*',
                      style: TextStyle(
                        fontSize: CustomFontSizes.fontSize14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                      items: controller.avaliationsValues.map((question) {
                        return DropdownMenuItem<AvaliationValuesModel>(
                          value: question,
                          child: Text(
                            question.title!,
                          ), // Use o nome da área como rótulo
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.avaliation.serviceQuality = value!.value;
                      },
                      onSaved: (value) {
                        controller.avaliation.serviceQuality = value!.value;
                      },
                      validator: avaliationValidator,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: CustomColors.blueColor,
                          ), // Defina a cor desejada da borda
                        ),
                        hintText: 'Selecione uma opção',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      '3. Pontualidade do prestador:*',
                      style: TextStyle(
                        fontSize: CustomFontSizes.fontSize14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                      items: controller.avaliationsValues.map((question) {
                        return DropdownMenuItem<AvaliationValuesModel>(
                          value: question,
                          child: Text(
                            question.title!,
                          ), // Use o nome da área como rótulo
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.avaliation.providerPunctuality = value!.value;
                      },
                      onSaved: (value) {
                        controller.avaliation.providerPunctuality = value!.value;
                      },
                      validator: avaliationValidator,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: CustomColors.blueColor,
                          ), // Defina a cor desejada da borda
                        ),
                        hintText: 'Selecione uma opção',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      '4. Com relação a usabilidade da plataforma:*',
                      style: TextStyle(
                        fontSize: CustomFontSizes.fontSize14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                      items: controller.avaliationsValues.map((question) {
                        return DropdownMenuItem<AvaliationValuesModel>(
                          value: question,
                          child: Text(
                            question.title!,
                          ), // Use o nome da área como rótulo
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.avaliation.platformUsability = value!.value;
                      },
                      onSaved: (value) {
                        controller.avaliation.platformUsability = value!.value;
                      },
                      validator: avaliationValidator,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: CustomColors.blueColor,
                          ), // Defina a cor desejada da borda
                        ),
                        hintText: 'Selecione uma opção',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      '5. De 0 a 10, qual a chance de você recomendar a Prestadio para um amigo?*',
                      style: TextStyle(
                        fontSize: CustomFontSizes.fontSize14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                      items: List.generate(
                        10,
                        (index) {
                          return DropdownMenuItem<int>(
                            value: index + 1,
                            child: Text((index + 1).toString()),
                          );
                        },
                      ),
                      onChanged: (value) {
                        controller.avaliation.recommendAPlataform = value;
                      },
                      onSaved: (value) {
                        controller.avaliation.recommendAPlataform = value;
                      },
                      validator: avaliationPlatformValidator,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: CustomColors.blueColor,
                          ), // Defina a cor desejada da borda
                        ),
                        hintText: 'Selecione uma opção',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: SizedBox(
                        height: 50,
                        child: GetBuilder<RequestManagerController>(
                          builder: (authController) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.blueDark2Color,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: authController.isSaving
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        controller.handleSubmitAvaliation();
                                      } else {
                                        utilServices.showToast(message: 'Verifique todos os campos');
                                      }
                                    },
                              child: controller.isSaving
                                  ? CircularProgressIndicator(
                                      color: CustomColors.black,
                                    )
                                  : Text(
                                      'Enviar avaliação',
                                      style: TextStyle(
                                        color: CustomColors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
