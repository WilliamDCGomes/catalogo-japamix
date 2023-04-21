import 'dart:io';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;
import '../../enums/enums.dart';
import '../sharedWidgets/popups/confirmation_popup.dart';
import '../sharedWidgets/popups/information_popup.dart';

class ViewPicture {
  static openPicture(String path) {
    try{
      showImageViewer(
        Get.context!,
        Image.memory(
          File(
            path,
          ).readAsBytesSync(),
        ).image,
      );
    }
    catch(_){
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Não foi possível abrir a imagem",
          );
        },
      );
    }
  }

  static Future<XFile?> addNewPicture() async {
    XFile? picture;
    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return ConfirmationPopup(
          title: "Aviso",
          subTitle: "Escolha o método desejado para adicionar a imagem",
          firstButtonText: "GALERIA",
          secondButtonText: "CÂMERA",
          disableGetBack: true,
          firstButton: () async {
            picture = await _getImage(ImageOrigin.gallery);
            Get.back();
          },
          secondButton: () async {
            picture = await _getImage(ImageOrigin.camera);
            Get.back();
          },
        );
      },
    );
    return picture;
  }

  static Future<XFile?> _getImage(ImageOrigin origin) async {
    try {
      late final ImagePicker picker = ImagePicker();
      final source = origin == ImageOrigin.camera ? ImageSource.camera : ImageSource.gallery;

      XFile? profilePicture = await picker.pickImage(source: source);

      return await _compressFile(profilePicture);
    } catch (e) {
      return null;
    }
  }

  static Future<XFile?> _compressFile(XFile? file) async {
    try {
      if (file == null) {
        return null;
      }

      final fileExtension = p.extension(file.path);

      if (fileExtension.contains('jpg') || fileExtension.contains('png') || fileExtension.contains('jpeg')) {
        var targetPath = file.path.split('.');
        targetPath[targetPath.length - 2] += "_compacted";
        String newPath = "";

        for (int i = 0; i < targetPath.length; i++) {
          if (i != targetPath.length - 1) {
            newPath += ("${targetPath[i]}.");
          } else {
            newPath += targetPath[i];
          }
        }

        final imageLowQuality = await FlutterImageCompress.compressAndGetFile(
          file.path,
          newPath,
          quality: 30,
          format: _getFormat(targetPath[targetPath.length - 1]),
        );

        if (imageLowQuality != null) {
          file = XFile(imageLowQuality.path);
        }
      }

      return file;
    } catch (e) {
      return null;
    }
  }

  static CompressFormat _getFormat(String format) {
    switch (format) {
      case "png":
        return CompressFormat.png;
      case "jpeg":
        return CompressFormat.jpeg;
      case "jpg":
        return CompressFormat.jpeg;
    }
    return CompressFormat.jpeg;
  }
}