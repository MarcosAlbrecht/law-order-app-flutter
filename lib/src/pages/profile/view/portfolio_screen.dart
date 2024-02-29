import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/service_model.dart';
import 'package:app_law_order/src/pages/common_widgets/custom_text_field.dart';
import 'package:app_law_order/src/pages/profile/controller/profile_controller.dart';
import 'package:app_law_order/src/pages/profile/view/components/picture_tile.dart';
import 'package:app_law_order/src/pages/profile/view/components/service_dialog.dart';
import 'package:app_law_order/src/pages/profile/view/components/services_tile.dart';
import 'package:app_law_order/src/pages/profile/view/components/skill_dialog.dart';
import 'package:app_law_order/src/pages/profile/view/components/skill_tile.dart';
import 'package:app_law_order/src/services/util_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'components/camera_dialog.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

final focus = FocusNode();
final focusStatus = FocusNode();
final utilServices = UtilServices();
final _formKey = GlobalKey<FormState>();

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Informações Pessoais",
          style: TextStyle(color: CustomColors.black),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: CustomColors.white,
          ),
          child: GetBuilder<ProfileController>(
            builder: (controller) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          label: "Título do Perfil",
                          initialValue: controller.authController.user.portfolioTitle,
                          onSaved: (value) {
                            controller.authController.user.portfolioTitle = value;
                          },
                        ),
                        CustomTextField(
                          label: "Sobre você",
                          minLines: 1,
                          maxLines: 5,
                          initialValue: controller.authController.user.portfolioAbout,
                          onSaved: (value) {
                            controller.authController.user.portfolioAbout = value;
                          },
                        ),

                        const Divider(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, left: 0),
                          child: Text(
                            "Fotos do Portfólio",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: CustomFontSizes.fontSize16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        //lista com as fotos
                        SizedBox(
                          height: 180,
                          child: Visibility(
                            visible: !controller.isSavingPortfolioPicuture,
                            replacement: Center(
                              child: LoadingAnimationWidget.discreteCircle(
                                color: CustomColors.blueDark2Color,
                                secondRingColor: CustomColors.blueDarkColor,
                                thirdRingColor: CustomColors.blueColor,
                                size: 50,
                              ),
                            ),
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(right: 15, bottom: 15),
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.authController.user.portfolioPictures != null
                                  ? controller.authController.user.portfolioPictures!.length + 1
                                  : 1,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return GestureDetector(
                                    onTap: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (_) {
                                          return CameraDialog(
                                            isPortfolio: true,
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: CustomColors.blueDarkColor,
                                      ),
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: CustomColors.white,
                                        size: 40,
                                      ),
                                    ),
                                  );
                                } else {
                                  final photo = controller.authController.user.portfolioPictures![index - 1];
                                  if (photo != null || photo.url != null || photo.localPath != null) {
                                    return PictureTile(
                                      picture: controller.authController.user.portfolioPictures![index - 1],
                                      index: index,
                                    );
                                  } else {
                                    return const SizedBox.shrink(); // Retorna um container vazio caso a propriedade seja nula
                                  }
                                }
                              },
                              separatorBuilder: (context, index) => const SizedBox(width: 5),
                            ),
                          ),
                        ),

                        const Divider(
                          height: 20,
                        ),
                        //titulo serviços oferecidos e icone para cadastrar
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                            left: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Serviços Ofertados",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: CustomFontSizes.fontSize16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  ServiceModel serviceModel = ServiceModel();
                                  controller.actualService = serviceModel;
                                  await showDialog(
                                    context: context,
                                    builder: (_) {
                                      return const ServiceDialog(
                                        status: "insert",
                                      );
                                    },
                                  );
                                },
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: CustomColors.blueDark2Color,
                                ),
                              )
                            ],
                          ),
                        ),
                        //container que lista os serviços oferecidos
                        Visibility(
                          visible: controller.authController.user.services != null &&
                              controller.authController.user.services!.isNotEmpty,
                          replacement: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.search_off, color: CustomColors.black),
                                const Text('Não há itens para apresentar'),
                              ],
                            ),
                          ),
                          child: SizedBox(
                            height: 200,
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Visibility(
                                  visible: !controller.isSavingService,
                                  replacement: Center(
                                    child: LoadingAnimationWidget.discreteCircle(
                                      color: CustomColors.blueDark2Color,
                                      secondRingColor: CustomColors.blueDarkColor,
                                      thirdRingColor: CustomColors.blueColor,
                                      size: 50,
                                    ),
                                  ),
                                  child: Dismissible(
                                    background: Container(
                                      alignment: Alignment.centerLeft,
                                      color: Colors.green,
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                    secondaryBackground: Container(
                                      alignment: Alignment.centerRight,
                                      color: Colors.red,
                                      child: const Icon(Icons.cancel),
                                    ),
                                    key: ValueKey<int>(index),
                                    child: ServicesTile(
                                      service: controller.authController.user.services![index],
                                    ),
                                    confirmDismiss: (direction) async {
                                      if (direction == DismissDirection.endToStart) {
                                        final bool result = await showDeleteConfirmation(context);
                                        if (result) {
                                          controller.actualService = controller.authController.user.services![index];
                                          controller.handleService(status: 'delete');
                                        }
                                      } else {
                                        await showDialog(
                                          context: context,
                                          builder: (_) {
                                            controller.actualService = controller.authController.user.services![index];
                                            return const ServiceDialog(
                                              status: "edit",
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                                );
                              },
                              itemCount: controller.authController.user.services!.length,
                              separatorBuilder: (context, index) => const SizedBox(height: 5),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 30,
                        ),
                        //titulo competencias e botao para cadastrar
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, left: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Competências",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: CustomFontSizes.fontSize16, fontWeight: FontWeight.w600),
                              ),
                              InkWell(
                                onTap: () async {
                                  ServiceModel serviceModel = ServiceModel();
                                  controller.actualService = serviceModel;
                                  await showDialog(
                                    context: context,
                                    builder: (_) {
                                      return const SkillDialog();
                                    },
                                  );
                                },
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: CustomColors.blueDark2Color,
                                ),
                              )
                            ],
                          ),
                        ),

                        //container com a lista de skill
                        Visibility(
                          visible:
                              controller.authController.user.skills != null && controller.authController.user.skills!.isNotEmpty,
                          replacement: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.search_off, color: CustomColors.black),
                                const Text('Não há itens para apresentar'),
                              ],
                            ),
                          ),
                          child: SizedBox(
                            height: 200,
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Visibility(
                                  visible: !controller.isSavingSkill,
                                  replacement: Center(
                                    child: LoadingAnimationWidget.discreteCircle(
                                      color: CustomColors.blueDark2Color,
                                      secondRingColor: CustomColors.blueDarkColor,
                                      thirdRingColor: CustomColors.blueColor,
                                      size: 50,
                                    ),
                                  ),
                                  child: Dismissible(
                                    background: Container(
                                      alignment: Alignment.centerRight,
                                      color: Colors.red,
                                      child: const Icon(Icons.cancel),
                                    ),
                                    key: ValueKey<int>(index),
                                    child: SkillTile(
                                      skill: controller.authController.user.skills![index],
                                    ),
                                    confirmDismiss: (direction) async {
                                      if (direction == DismissDirection.endToStart) {
                                        final bool result = await showDeleteConfirmation(context);
                                        if (result) {
                                          controller.skill = controller.authController.user.skills![index];
                                          controller.handleSkill(status: 'delete');
                                        }
                                      }
                                    },
                                  ),
                                );
                              },
                              itemCount: controller.authController.user.skills != null
                                  ? controller.authController.user.skills!.length
                                  : 0,
                              separatorBuilder: (context, index) => const SizedBox(height: 5),
                            ),
                          ),
                        ),

                        const Divider(
                          height: 15,
                          color: Colors.transparent,
                        ),

                        //botao para salvar o portfolio
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.blueColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: controller.authController.isLoading.value
                                ? null
                                : () async {
                                    //Get.toNamed(PagesRoutes.signUpStep1);
                                    FocusScope.of(context).unfocus();
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      await controller.handleUpdateProfile();
                                    } else {
                                      utilServices.showToast(message: "Verifique todos os campos!");
                                    }
                                  },
                            child: controller.isSaving
                                ? CircularProgressIndicator(
                                    color: CustomColors.white,
                                  )
                                : Text(
                                    'Atualizar perfil',
                                    style: TextStyle(
                                      color: CustomColors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Future<bool> showDeleteConfirmation(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmar exclusão'),
            content: Text('Tem certeza que deseja excluir este item?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Retorna falso para cancelar a exclusão
                },
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Retorna verdadeiro para confirmar a exclusão
                },
                child: Text('Confirmar'),
              ),
            ],
          );
        },
      ) ??
      false; // Retorna falso por padrão se showDialog retornar nulo
}
