import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class APIController extends GetxController {
  var client = http.Client();
  RxBool isLoading = true.obs;
  final String baseUrl =
      'rest-api-666ab-default-rtdb.asia-southeast1.firebasedatabase.app';

  // @override
  // void onInit() {
  //   super.onInit();
  //   get();
  // }

  Future<List<Map<String, dynamic>>> get() async {
    final url = Uri.https(baseUrl, 'phonebook.json');

    try {
      final response = await client.get(url);

      if (response.statusCode >= 400) {
        Get.snackbar(
          'Error',
          'Failed to fetch data. Please try again later.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      if (response.body == 'null') {
        isLoading.value = false;
        return [];
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      List<Map<String, dynamic>> phonebook = [];

      for (final item in listData.entries) {
        phonebook.add({
          'id': item.key,
          'name': item.value['name'],
          'phone': item.value['phone'],
        });
      }

      // phoneBook.assignAll(phonebook);
      isLoading.value = false;
      print(phonebook);
      return phonebook;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch data. Please try again later.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return [];
    }
  }

  Future<void> post(String name, String phone) async {
    final url = Uri.https(baseUrl, 'phonebook.json');

    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'name': name,
            'phone': phone,
          },
        ),
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode >= 400) {
        Get.snackbar(
          'Error',
          'Failed to fetch data. Please try again later.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      if (response.body == 'null') {
        return;
      }

      final Map<String, dynamic> resData = json.decode(response.body);

      Get.snackbar(
        'Success',
        'Data successfully added.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch data. Please try again later.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> put(String id, String name, String phone) async {
    final url = Uri.https(baseUrl, 'phonebook/$id.json');

    try {
      final response = await client.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'name': name,
            'phone': phone,
          },
        ),
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode >= 400) {
        Get.snackbar(
          'Error',
          'Failed to fetch data. Please try again later.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      if (response.body == 'null') {
        return;
      }

      final Map<String, dynamic> resData = json.decode(response.body);

      Get.snackbar(
        'Success',
        'Data successfully updated.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch data. Please try again later.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> delete(String id) async {
    final url = Uri.https(baseUrl, 'phonebook/$id.json');

    try {
      final response = await client.delete(url);

      print(response.body);
      print(response.statusCode);

      if (response.statusCode >= 400) {
        Get.snackbar(
          'Error',
          'Failed to fetch data. Please try again later.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      if (response.body == 'null') {
        return;
      }

      final Map<String, dynamic> resData = json.decode(response.body);

      Get.snackbar(
        'Success',
        'Data successfully deleted.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch data. Please try again later.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
