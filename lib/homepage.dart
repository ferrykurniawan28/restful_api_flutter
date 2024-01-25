import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:restful_api/addpage.dart';
import 'package:restful_api/apicontroller.dart';
import 'package:restful_api/editpage.dart';
import 'package:restful_api/homecontroller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final apiC = Get.put(APIController());
    final homeC = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phonebook'),
        actions: [
          IconButton(
            onPressed: () {
              homeC.showModal();
              // Get.to(() => const AddPage());
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(() {
        if (apiC.isLoading.value) {
          return const CircularProgressIndicator();
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: homeC.phonebook.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(homeC.phonebook[index]['id']),
              onDismissed: (direction) {
                homeC.delete(homeC.phonebook[index]['id']);
              },
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const EditPage(), arguments: {
                    'id': homeC.phonebook[index]['id'],
                    'name': homeC.phonebook[index]['name'],
                    'phone': homeC.phonebook[index]['phone'],
                  });
                },
                child: Card(
                  child: ListTile(
                    title: Text(homeC.phonebook[index]['name']),
                    subtitle: Text(homeC.phonebook[index]['phone']),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
