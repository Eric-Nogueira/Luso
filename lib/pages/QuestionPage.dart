import 'package:flutter/material.dart';

import 'package:luso/pages/results/PerformancePage.dart';
import 'package:luso/pages/results/PerfectResultPage.dart';

class QuestionPage extends StatefulWidget {
  // Questão em que a página deve começar.
  final int initialQuestion;

  // Indica se a página foi aberta para revisão.
  final bool reviewMode;

  const QuestionPage({
    super.key,
    this.initialQuestion = 1,
    this.reviewMode = false,
  });

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  // ============================================================
  // CONFIGURAÇÕES DA PROVA
  // ============================================================

  late int currentQuestion;

  final int totalQuestions = 10;

  String? selectedAnswer;

  // Guarda as questões que o usuário errou.
  final List<int> wrongQuestions = [];

  // Guarda os conteúdos relacionados aos erros.
  final List<String> contentsToReview = [];

  // Respostas corretas para cada questão.
  final Map<int, String> correctAnswers = {
    1: 'A',
    2: 'B',
    3: 'C',
    4: 'D',
    5: 'E',
    6: 'B',
    7: 'C',
    8: 'E',
    9: 'A',
    10: 'B',
  };

  // Conteúdo relacionado a cada questão.
  final Map<int, String> questionContents = {
    1: 'Função afim',
    2: 'Porcentagem',
    3: 'Interpretação de gráficos',
    4: 'Função afim',
    5: 'Porcentagem',
    6: 'Geometria',
    7: 'Interpretação de gráficos',
    8: 'Probabilidade',
    9: 'Função afim',
    10: 'Porcentagem',
  };

  @override
  void initState() {
    super.initState();

    // Começa na questão enviada.
    currentQuestion = widget.initialQuestion;
  }

  @override
  Widget build(BuildContext context) {
    double progress = currentQuestion / totalQuestions;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            // ====================================================
            // CABEÇALHO
            // ====================================================

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

                  // LOGO
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

            // ====================================================
            // CONTEÚDO
            // ====================================================

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
                        // =================================================
                        // QUESTÃO X DE 10
                        // =================================================

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

                        // =================================================
                        // BARRA DE PROGRESSO
                        // =================================================

                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),

                          child: LinearProgressIndicator(
                            value: progress,

                            minHeight: 10,

                            backgroundColor:
                                const Color(0xFFE6E8F0),

                            valueColor:
                                const AlwaysStoppedAnimation<Color>(
                              Color(0xFF1735B4),
                            ),
                          ),
                        ),

                        const SizedBox(height: 35),

                        // =================================================
                        // ENUNCIADO
                        // =================================================

                        Container(
                          width: double.infinity,

                          padding: const EdgeInsets.all(20),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius:
                                BorderRadius.circular(22),

                            border: Border.all(
                              color: const Color(0xFFE2E2E2),
                            ),
                          ),

                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [
                              const Text(
                                'Enunciado',

                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1C094A),
                                ),
                              ),

                              const SizedBox(height: 16),

                              Text(
                                'Aqui ficará o enunciado da questão '
                                'do ENEM. Depois essa informação será '
                                'carregada através da API do sistema.',

                                style: const TextStyle(
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

                        // =================================================
                        // ALTERNATIVAS
                        // =================================================

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

                        answerButton(
                          letter: 'E',
                          text: 'Alternativa E',
                        ),

                        const SizedBox(height: 25),

                        // =================================================
                        // BOTÃO
                        // =================================================

                        SizedBox(
                          width: double.infinity,
                          height: 58,

                          child: ElevatedButton(
                            onPressed: nextQuestion,

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

                            child: Text(
                              widget.reviewMode
                                  ? 'Voltar ao desempenho'
                                  : currentQuestion ==
                                          totalQuestions
                                      ? 'Finalizar'
                                      : 'Próxima questão',

                              style: const TextStyle(
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

  // ==============================================================
  // BOTÃO DAS ALTERNATIVAS
  // ==============================================================

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
                ? const Color(0xFF1735B4)
                : const Color(0xFFE2E2E2),

            width: isSelected ? 2 : 1,
          ),
        ),

        child: Row(
          children: [
            // CÍRCULO
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

              child: isSelected
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 18,
                    )
                  : null,
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

            // TEXTO
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

  // ==============================================================
  // PRÓXIMA QUESTÃO
  // ==============================================================

  void nextQuestion() {
    // ------------------------------------------------------------
    // MODO REVISÃO
    // ------------------------------------------------------------

    if (widget.reviewMode) {
      if (selectedAnswer == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Selecione uma alternativa antes de voltar.',
            ),
          ),
        );

        return;
      }

      String? correctAnswer =
          correctAnswers[currentQuestion];

      if (selectedAnswer == correctAnswer) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Você acertou a questão na revisão!',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'A resposta correta é $correctAnswer.',
            ),
          ),
        );
      }

      // Depois de responder, volta para a tela de desempenho.
      Future.delayed(
        const Duration(milliseconds: 700),
        () {
          if (mounted) {
            Navigator.pop(context);
          }
        },
      );

      return;
    }

    // ------------------------------------------------------------
    // MODO NORMAL
    // ------------------------------------------------------------

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

    // ------------------------------------------------------------
    // VERIFICA SE A RESPOSTA ESTÁ CORRETA
    // ------------------------------------------------------------

    String? correctAnswer =
        correctAnswers[currentQuestion];

    if (selectedAnswer != correctAnswer) {
      // Evita adicionar a mesma questão duas vezes.
      if (!wrongQuestions.contains(currentQuestion)) {
        wrongQuestions.add(currentQuestion);
      }

      // Pega o conteúdo relacionado à questão.
      String? content =
          questionContents[currentQuestion];

      if (content != null &&
          !contentsToReview.contains(content)) {
        contentsToReview.add(content);
      }
    }

    // ------------------------------------------------------------
    // SE AINDA NÃO TERMINOU
    // ------------------------------------------------------------

    if (currentQuestion < totalQuestions) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
      });

      return;
    }

    // ------------------------------------------------------------
    // TERMINOU TODAS AS QUESTÕES
    // ------------------------------------------------------------

    finishQuiz();
  }

  // ==============================================================
  // FINALIZAR QUESTÕES
  // ==============================================================

  void finishQuiz() {
    // ------------------------------------------------------------
    // USUÁRIO ACERTOU TODAS
    // ------------------------------------------------------------

    if (wrongQuestions.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const PerfectResultPage(),
        ),
      );

      return;
    }

    // ------------------------------------------------------------
    // USUÁRIO ERROU ALGUMA QUESTÃO
    // ------------------------------------------------------------

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PerformancePage(
          correctAnswers:
              totalQuestions - wrongQuestions.length,
          totalQuestions: totalQuestions,
          wrongQuestions: wrongQuestions,
          reviewTopics: contentsToReview,
        ),
      ),
    );
  }
}