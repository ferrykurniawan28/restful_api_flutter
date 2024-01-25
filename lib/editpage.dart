import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restful_api/editcontroller.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final editC = Get.put(EditController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Page'),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: editC.nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: editC.phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter phone';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                editC.edit(Get.arguments['id']);
                Get.back();
              },
              child: const Text('update'),
            ),
          ],
        ),
      ),
    );
  }
}
