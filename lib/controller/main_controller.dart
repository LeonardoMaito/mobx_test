import 'package:flutter/material.dart';
import 'package:prova_target_sistemas/utils/constants/url.dart';
import 'package:url_launcher/url_launcher.dart';
import '../stores/text_store.dart';
import 'controller_contract.dart';

class MainController implements ControllerContract {
  final TextStore textStore;
  final Uri _url = Uri.parse(url);
  final TextEditingController textController = TextEditingController();

  MainController(this.textStore) {
    textStore.loadTexts();
  }

  VoidCallback? onTextEmpty;
  ValueChanged<String>? onTextAdded;

  void addText(String text) {
    if (text.isNotEmpty) {
      textStore.addText(text);
      textController.clear();
      onTextAdded?.call(text);
    } else {
      onTextEmpty?.call();
    }
  }

  void updateText(int index, String newText) {
    if (newText.isNotEmpty) {
      textStore.updateText(index, newText);
      onTextAdded?.call(newText);
    } else {
      onTextEmpty?.call();
    }
  }

  void deleteText(int index) {
    textStore.deleteText(index);
  }

  void showDeleteConfirmation(int index, VoidCallback onCancel, VoidCallback onDelete, BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Você tem certeza de que deseja excluir este item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                onCancel();
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () {
                onDelete();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Future<void> launchLink() async{
    if (!await canLaunchUrl(_url)) {
      debugPrint('Não foi possível lançar $_url');
      return;
    }
    await launchUrl(_url);
  }
}