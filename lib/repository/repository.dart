import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _textsKey = 'texts';

class Repository {

  Future<List<String>> loadTexts() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      List<String> texts = prefs.getStringList(_textsKey) ?? [];
      return texts;
    } catch(e) {
      debugPrint('Erro ao carregar textos: $e');
    }
    return [];
  }

  Future<void> saveTexts(List<String> texts) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_textsKey, texts);
    } catch(e){
      debugPrint('Erro ao salvar textos: $e');
    }
  }
}
