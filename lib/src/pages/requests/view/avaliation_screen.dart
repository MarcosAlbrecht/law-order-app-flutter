import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/avaliation_values_model.dart';
import 'package:app_law_order/src/models/request_model.dart';
import 'package:app_law_order/src/pages/requests/controller/request_manager_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvaliationScreen extends StatefulWidget {
  const AvaliationScreen({Key? key}) : super(key: key);

  @override
  State<AvaliationScreen> createState() => _AvaliationScreenState();
}

class _AvaliationScreenState extends State<AvaliationScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final RequestModel request = Get.arguments ?? {};

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
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.all(16),
          child: GetBuilder<RequestManagerController>(
            builder: (controller) {
              return Column(
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
                    'Avaliação do prestador: ${request.requested!.firstName!} ${request.requested!.lastName!}',
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
                    onChanged: (data) {
                      //authController.user.occupationArea = data?.area;
                    },
                    onSaved: (data) {
                      //authController.user.occupationArea = data?.area;
                    },

                    //validator: occupationAreaValidator,
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
                    onChanged: (data) {
                      //authController.user.occupationArea = data?.area;
                    },
                    onSaved: (data) {
                      //authController.user.occupationArea = data?.area;
                    },
                    //validator: occupationAreaValidator,
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
                    onChanged: (data) {
                      //authController.user.occupationArea = data?.area;
                    },
                    onSaved: (data) {
                      //authController.user.occupationArea = data?.area;
                    },
                    //validator: occupationAreaValidator,
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
                    onChanged: (data) {
                      //authController.user.occupationArea = data?.area;
                    },
                    onSaved: (data) {
                      //authController.user.occupationArea = data?.area;
                    },
                    //validator: occupationAreaValidator,
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
                    items: controller.avaliationsValues.map((question) {
                      return DropdownMenuItem<AvaliationValuesModel>(
                        value: question,
                        child: Text(
                          question.title!,
                        ), // Use o nome da área como rótulo
                      );
                    }).toList(),
                    onChanged: (data) {
                      //authController.user.occupationArea = data?.area;
                    },
                    onSaved: (data) {
                      //authController.user.occupationArea = data?.area;
                    },
                    //validator: occupationAreaValidator,
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
                    padding: const EdgeInsets.only(top: 10),
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
                            onPressed: authController.isLoading
                                ? null
                                : () {
                                    //Get.toNamed(PagesRoutes.serviceRequestScreen);
                                  },
                            child: authController.isLoading
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
              );
            },
          ),
        ),
      ),
    );
  }
}
