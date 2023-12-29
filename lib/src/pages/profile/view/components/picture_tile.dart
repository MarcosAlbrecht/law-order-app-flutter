// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:app_law_order/src/pages/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_law_order/src/models/picture_model.dart';

class PictureTile extends StatefulWidget {
  final int index;
  final PictureModel picture;

  const PictureTile({
    Key? key,
    required this.index,
    required this.picture,
  }) : super(key: key);

  @override
  State<PictureTile> createState() => _PictureTileState();
}

class _PictureTileState extends State<PictureTile> {
  final atendimentoController = Get.find<ProfileController>();

  Uint8List _buildMemoryBytes(String base64Image) {
    return base64Decode(base64Image);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        if (widget.index > 0) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Remover imagem'),
              //content: const Text('Escolha uma opção:'),
              actions: [
                TextButton(
                  onPressed: () {
                    // atendimentoController.removePhotoFromList(widget.index - 1);
                    // Navigator.pop(context); // Fechar o AlertDialog
                  },
                  child: const Text('Confirmar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Fechar o AlertDialog
                  },
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        width: 150,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: widget.picture.url != null
                ? NetworkImage(widget.picture.url!) as ImageProvider<Object>
                : FileImage(File(widget.picture.localPath!)),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
