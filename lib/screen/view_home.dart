import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leanapigetx/controller/api/todocontrollor.dart';

class ViewHome extends StatelessWidget {
   ViewHome({super.key});
  TodoController todoController = Get.put(TodoController());


   @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home',
            style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _AddshowDialog(controller),
        child: const Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Center(
            child: Text('All todo List', style: TextStyle(fontSize: 20)),
          ),
          Expanded(
            child: Obx(() {
              if (todoController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(), // Loader when data is fetching
                );
              } else {
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: todoController.todoList.map((e) => ListTile(
                        title: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${e.title}"),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _editshowDailogy(controller);
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _deleteshowdailogy();
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )).toList(),
                    );
                  },
                );
              }
            }),
          )
        ],
      ),
    );
  }

  void _deleteshowdailogy() {
    Get.defaultDialog(
      title: 'Delete Todo List',
      content: const Text('Are you sure want to delete this todo list?'),
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }

  void _editshowDailogy(TextEditingController controller) {
    Get.defaultDialog(
      title: 'Edit Todo List',
      content: Column(
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter your todo list',
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 10),
              OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Cancel")),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Upadate'),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _AddshowDialog(TextEditingController controller) {
    Get.defaultDialog(
      title: 'Add Todo List',
      content: Column(
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter your todo list',
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  todoController.postTodos(controller.text);
                },
                child: const Text('Add'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Cancel'),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
