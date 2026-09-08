import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int currentQuestion = 3;
  final int totalQuestions = 10;
  String? selectedAnswer = 'B';

  @override
  Widget build(BuildContext context) {
    double progress = currentQuestion / totalQuestions;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // CABEÇALHO
            Container(
              width: double.infinity,
              height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF1C094A),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Row(
                children: [
                  // BOTÃO VOLTAR
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),

                  // LOGO DO LUSO
                  const Expanded(
                    child: Center(
                      child: Image(
                        image: AssetImage(
                          'assets/img/logo/LOGO_LUSO_LIGHT.png',
                        ),
                        width: 110,
                        height: 55,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // ESPAÇO PARA CENTRALIZAR A LOGO
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // CONTEÚDO
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  25,
                  24,
                  30,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 700,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // QUESTÃO X DE 10
                        Text(
                          'Questão $currentQuestion de $totalQuestions',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C094A),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // BARRA DE PROGRESSO
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 10,
                            backgroundColor: Color(0xFFE6E8F0),
                            valueColor:
                                const AlwaysStoppedAnimation<Color>(
                              Color(0xFF1735B4),
                            ),
                          ),
                        ),

                        const SizedBox(height: 35),

                        // CARD DO ENUNCIADO
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: const Color(0xFFE2E2E2),
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Enunciado',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1C094A),
                                ),
                              ),

                              SizedBox(height: 16),

                              Text(
                                'Aqui ficará o enunciado da questão do ENEM. '
                                'Depois essa informação será carregada através '
                                'da API do sistema.',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 15,
                                  color: Color(0xFF333333),
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 22),

                        // ALTERNATIVAS
                        answerButton(
                          letter: 'A',
                          text: 'Alternativa A',
                        ),

                        answerButton(
                          letter: 'B',
                          text: 'Alternativa B',
                        ),

                        answerButton(
                          letter: 'C',
                          text: 'Alternativa C',
                        ),

                        answerButton(
                          letter: 'D',
                          text: 'Alternativa D',
                        ),

                        const SizedBox(height: 25),

                        // BOTÃO PRÓXIMA QUESTÃO
                        SizedBox(
                          width: double.infinity,
                          height: 58,
                          child: ElevatedButton(
                            onPressed: () {
                              nextQuestion();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF1735B4),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(22),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Próxima questão',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // BOTÃO DAS ALTERNATIVAS
  Widget answerButton({
    required String letter,
    required String text,
  }) {
    bool isSelected = selectedAnswer == letter;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnswer = letter;
        });
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE9EEFF)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFD9E1FF)
                : const Color(0xFFE2E2E2),
          ),
        ),
        child: Row(
          children: [
            // CÍRCULO DA ALTERNATIVA
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? const Color(0xFF1735B4)
                    : Colors.white,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF1735B4)
                      : const Color(0xFFCCCCCC),
                  width: 2,
                ),
              ),
            ),

            const SizedBox(width: 18),

            // LETRA
            Text(
              letter,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C094A),
              ),
            ),

            const SizedBox(width: 15),

            // TEXTO DA ALTERNATIVA
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  color: Color(0xFF333333),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // PRÓXIMA QUESTÃO
  void nextQuestion() {
    if (selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Selecione uma alternativa antes de continuar.',
          ),
        ),
      );

      return;
    }

    if (currentQuestion < totalQuestions) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
      });
    }
  }
}