import 'package:luso/functions/Func.dart';

Future<void> main() async {
  print('=== Buscando questões da fase 1 ===');

  final resultado = await Func.getQuestionsForFase(1);

  print('=== RESULTADO ===');
  print(resultado);
}