import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lista_de_tarefas_2/stores/list_store.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/custom_text_field.dart';
import 'login_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  ListStore listStore = ListStore();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Tarefas',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 32),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.exit_to_app,
                        size: 36,
                      ),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Observer(builder: (_) {
                          return CustomTextField(
                              hint: 'Tarefa',
                              onChanged: listStore.setNewTodoTitle,
                              suffix: listStore.isFormValid
                                  ? CustomIconButton(
                                      radius: 32,
                                      iconData: Icons.add,
                                      onTap: listStore.addTodo,
                                    )
                                  : null);
                        }),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: Observer(
                            builder: (_) {
                              return ListView.separated(
                                itemCount: listStore.todoList.length,
                                itemBuilder: (_, index) {
                                  return ListTile(
                                    title: Text(
                                      listStore.todoList[index],
                                    ),
                                    onTap: () {},
                                  );
                                },
                                separatorBuilder: (_, __) {
                                  return const Divider();
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
