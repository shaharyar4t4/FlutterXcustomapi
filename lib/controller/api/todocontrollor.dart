import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:leanapigetx/controller/todomodels.dart';

class TodoController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTodos();
  }

  var todoList = RxList<TodoModel>();

  // getTODOS()
  Future<RxList<TodoModel>> getTodos() async {
    final response = await http.get(
        Uri.parse("https://67b0d37b3fc4eef538e88a6e.mockapi.io/api/todolist"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        todoList.add(TodoModel.fromJson(index));
      }
      return todoList;
    } else {
      return todoList;
    }
  }

  //postTODO()
  Future<void> postTodos(title) async {
    final response = await http.post(
      Uri.parse("https://67b0d37b3fc4eef538e88a6e.mockapi.io/api/todolist"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {"title": title},
      ),
    );
    if (response.statusCode == 201) {
      print("Done");
      todoList.clear();
      getTodos();
    } else {
      print("Failed");
    }
  }
}
