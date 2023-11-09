import 'package:mobx/mobx.dart';
import '../repository/repository.dart';

part 'text_store.g.dart';

class TextStore = _TextStore with _$TextStore;

abstract class _TextStore with Store {
  final Repository _repository;

  @observable
  ObservableList<String> textList = ObservableList<String>();

  _TextStore(this._repository) {
    loadTexts();
  }

  @action
  Future<void> loadTexts() async {
    List<String> loadedTexts = await _repository.loadTexts();
    textList = ObservableList.of(loadedTexts);
  }

  @action
  void addText(String text) {
    textList.add(text);
    _saveTexts();
  }

  @action
  void updateText(int index, String newText) {
    if (index >= 0 && index < textList.length) {
      textList[index] = newText;
      _saveTexts();
    }
  }

  @action
  void deleteText(int index) {
    if (index >= 0 && index < textList.length) {
      textList.removeAt(index);
      _saveTexts();
    }
  }

  Future<void> _saveTexts() async {
    await _repository.saveTexts(textList.toList());
  }

}