import 'package:catalago_japamix/app/modules/createEditAd/controller/create_edit_ad_controller.dart';
import 'package:catalago_japamix/base/models/places/places.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateEditAdPage extends StatefulWidget {
  final Places? place;

  const CreateEditAdPage({
    Key? key,
    this.place,
  }) : super(key: key);

  @override
  State<CreateEditAdPage> createState() => _CreateEditAdPageState();
}

class _CreateEditAdPageState extends State<CreateEditAdPage> {
  late CreateEditAdController controller;

  @override
  void initState() {
    controller = Get.put(CreateEditAdController(widget.place));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
