import 'package:flutter_test/flutter_test.dart';
import 'package:prova_target_sistemas/controller/main_controller.dart';
import 'package:prova_target_sistemas/repository/repository.dart';
import 'package:prova_target_sistemas/stores/text_store.dart';

void main() {
  group('MainController Tests', () {
    late MainController mainController;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      mainController = MainController(TextStore(Repository()));
    });

    test('Tentar adicionar texto vazio', () {
      mainController.addText('');

      expect(mainController.textStore.textList.contains(''), false);
    });


    test('Adicionar texto à lista', () {
      mainController.addText('Teste');

      expect(mainController.textStore.textList.contains('Teste'), true);
    });

    test('Deletar texto da lista', () {

      mainController.addText('Texto 1');
      mainController.addText('Texto 2');

      expect(mainController.textStore.textList.length, 2);

      mainController.deleteText(0);

      expect(mainController.textStore.textList.length, 1);
      expect(mainController.textStore.textList.contains('Texto 1'), false);
      expect(mainController.textStore.textList.contains('Texto 2'), true);
    });
  });
}
