import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restful_api/apicontroller.dart';

class EditController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final form = GlobalKey<FormState>();

  // final _home = Get.put(HomeController());
  final _apiC = Get.put(APIController());

  @override
  void onInit() {
    nameController.text = Get.arguments['name'];
    phoneController.text = Get.arguments['phone'];
    super.onInit();
  }

  void edit(String id) {
    _apiC.put(id, nameController.text, phoneController.text);
    nameController.clear();
    phoneController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
