import 'package:flutter/material.dart';
import 'package:get/get.dart';
void showDailogy (){

  Get.defaultDialog(
    title: 'Add Todo List',
    content: Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            hintText: 'Enter your todo list',
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: (){
            Get.back();
          },
          child: const Text('Add'),
        ),
      ],
    ),
  );
}