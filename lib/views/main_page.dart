import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../controller/main_controller.dart';
import '../repository/repository.dart';
import '../stores/text_store.dart';
import '../utils/constants/policy_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late final TextStore textStore;
  late FocusNode mainTextFocusNode;
  late FocusNode editTextFocusNode;
  late final MainController mainController;
  int? editingIndex;

  @override
  void initState() {
    super.initState();
    mainTextFocusNode = FocusNode();
    editTextFocusNode = FocusNode();
    mainController = MainController(TextStore(Repository()))
    ..onTextEmpty = () {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('O texto não pode estar vazio.'),
        duration: Duration(seconds: 1),
      ));
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Color(0xFF2e968f), Color(0xFF1e4e62)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(right: 45.0, left: 45),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: SizedBox(
                      height: 250,
                      child: Observer(
                        builder: (_) => ListView.separated(
                          shrinkWrap: true,
                          itemCount: mainController.textStore.textList.length,
                          itemBuilder: (context, index) {
                            final text = mainController.textStore.textList[index];
                            final isEditing = index == editingIndex;
                            return ListTile(
                              title: isEditing
                                  ? TextField(
                                focusNode: editTextFocusNode,
                                controller: TextEditingController(text: text),
                                onSubmitted: (newText) {
                                  mainController.updateText(index, newText);
                                  setState(() => editingIndex = null);
                                  mainTextFocusNode.requestFocus();
                                },
                                autofocus: true,
                              )
                                  : Text(text,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit_rounded,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      editTextFocusNode.requestFocus();
                                      setState(() => editingIndex = index);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.highlight_remove_rounded,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      _showDeleteConfirmationDialog(index);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              thickness: 2,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: TextField(
                      focusNode: mainTextFocusNode,
                      controller: mainController.textController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        hintText: 'Digite seu texto',
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      autofocus: true,
                      onSubmitted: (text) {
                          mainController.addText(text);
                          mainController.textController.clear();
                          mainTextFocusNode.requestFocus();
                        }
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 20,
                child: policyTextField(() async {
                  await mainController.launchLink();
                })
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(int index) async {
    mainController.showDeleteConfirmation(index, () {
      Navigator.of(context).pop();
    }, () {
      mainController.deleteText(index);
      Navigator.of(context).pop();
    },
        context);
  }


  @override
  void dispose() {
    mainTextFocusNode.dispose();
    editTextFocusNode.dispose();
    super.dispose();
  }
}
