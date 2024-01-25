import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restful_api/apicontroller.dart';

class HomeController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  RxList phonebook = [].obs;
  final apiC = Get.put(APIController());
  @override
  void onInit() async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      apiC.get().then((value) => phonebook.assignAll(value));
    });
    phonebook.assignAll(await apiC.get());
    super.onInit();
  }

  void add() {
    apiC.post(nameController.text, phoneController.text);
    nameController.clear();
    phoneController.clear();
  }

  void showModal() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                add();
                Get.back();
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void delete(String id) {
    apiC.delete(id);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
