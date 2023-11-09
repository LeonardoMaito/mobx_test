// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TextStore on _TextStore, Store {
  late final _$textListAtom =
      Atom(name: '_TextStore.textList', context: context);

  @override
  ObservableList<String> get textList {
    _$textListAtom.reportRead();
    return super.textList;
  }

  @override
  set textList(ObservableList<String> value) {
    _$textListAtom.reportWrite(value, super.textList, () {
      super.textList = value;
    });
  }

  late final _$loadTextsAsyncAction =
      AsyncAction('_TextStore.loadTexts', context: context);

  @override
  Future<void> loadTexts() {
    return _$loadTextsAsyncAction.run(() => super.loadTexts());
  }

  late final _$_TextStoreActionController =
      ActionController(name: '_TextStore', context: context);

  @override
  void addText(String text) {
    final _$actionInfo =
        _$_TextStoreActionController.startAction(name: '_TextStore.addText');
    try {
      return super.addText(text);
    } finally {
      _$_TextStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateText(int index, String newText) {
    final _$actionInfo =
        _$_TextStoreActionController.startAction(name: '_TextStore.updateText');
    try {
      return super.updateText(index, newText);
    } finally {
      _$_TextStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteText(int index) {
    final _$actionInfo =
        _$_TextStoreActionController.startAction(name: '_TextStore.deleteText');
    try {
      return super.deleteText(index);
    } finally {
      _$_TextStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
textList: ${textList}
    ''';
  }
}
