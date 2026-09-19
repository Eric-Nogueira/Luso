import 'package:flutter/material.dart';

class PerformancePage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final List<int> wrongQuestions;
  final List<String> reviewTopics;

  const PerformancePage({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.wrongQuestions,
    required this.reviewTopics,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage =
        correctAnswers / totalQuestions;

    final int errors =
        totalQuestions - correctAnswers;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      body: SafeArea(
        child: Column(
          children: [
            // ==========================================================
            // CABEÇALHO
            // ==========================================================

            Container(
              width: double.infinity,
              height: 120,

              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),

              decoration: const BoxDecoration(
                color: Color(0xFF10279A),

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),

              child: Row(
                children: [
                  const Icon(
                    Icons.show_chart,
                    color: Colors.white,
                    size: 30,
                  ),

                  const SizedBox(width: 18),

                  const Text(
                    'Seu desempenho',

                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // ==========================================================
            // CONTEÚDO
            // ==========================================================

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  28,
                  24,
                  30,
                ),

                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 650,
                    ),

                    child: Column(
                      children: [
                        // ==================================================
                        // RESULTADO
                        // ==================================================

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,

                          children: [
                            // CÍRCULO DE ACERTOS
                            SizedBox(
                              width: 160,
                              height: 160,

                              child: Stack(
                                alignment: Alignment.center,

                                children: [
                                  SizedBox(
                                    width: 150,
                                    height: 150,

                                    child:
                                        CircularProgressIndicator(
                                      value: percentage,
                                      strokeWidth: 10,

                                      backgroundColor:
                                          const Color(
                                        0xFFE7EAF7,
                                      ),

                                      valueColor:
                                          const AlwaysStoppedAnimation(
                                        Color(0xFF10279A),
                                      ),
                                    ),
                                  ),

                                  Column(
                                    mainAxisSize:
                                        MainAxisSize.min,

                                    children: [
                                      Text(
                                        '$correctAnswers/$totalQuestions',

                                        style:
                                            const TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 32,
                                          fontWeight:
                                              FontWeight.bold,
                                          color:
                                              Color(0xFF10279A),
                                        ),
                                      ),

                                      const Text(
                                        'acertos',

                                        style:
                                            TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 16,
                                          fontWeight:
                                              FontWeight.bold,
                                          color:
                                              Color(0xFF10279A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // ERROS
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [
                                const Text(
                                  'Erros',

                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 18,
                                    fontWeight:
                                        FontWeight.bold,
                                    color:
                                        Color(0xFF222222),
                                  ),
                                ),

                                const SizedBox(height: 12),

                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,

                                  children: List.generate(
                                    totalQuestions,
                                    (index) {
                                      final bool isError =
                                          index < errors;

                                      return Container(
                                        width: 20,
                                        height: 20,

                                        decoration:
                                            BoxDecoration(
                                          shape:
                                              BoxShape.circle,

                                          color: isError
                                              ? Colors.red
                                              : Colors.white,

                                          border:
                                              Border.all(
                                            color: isError
                                                ? Colors.red
                                                : const Color(
                                                    0xFFCCCCCC,
                                                  ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 35),

                        // ==================================================
                        // QUESTÕES ERRADAS
                        // ==================================================

                        _sectionCard(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [
                              const Text(
                                'Questões erradas',

                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight.bold,
                                  color:
                                      Color(0xFF222222),
                                ),
                              ),

                              const SizedBox(height: 16),

                              ...wrongQuestions.map(
                                (questionNumber) {
                                  return InkWell(
                                    borderRadius:
                                        BorderRadius.circular(
                                      12,
                                    ),

                                    // ==================================================
                                    // ABRIR A QUESTÃO ERRADA
                                    // ==================================================

                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/questions',
                                        arguments: {
                                          'initialQuestion':
                                              questionNumber,
                                          'reviewMode': true,
                                        },
                                      );
                                    },

                                    child: Padding(
                                      padding:
                                          const EdgeInsets
                                              .symmetric(
                                        vertical: 10,
                                      ),

                                      child: Row(
                                        children: [
                                          Container(
                                            width: 24,
                                            height: 24,

                                            decoration:
                                                const BoxDecoration(
                                              shape:
                                                  BoxShape.circle,
                                              color: Colors.red,
                                            ),

                                            child:
                                                const Icon(
                                              Icons.close,
                                              color:
                                                  Colors.white,
                                              size: 17,
                                            ),
                                          ),

                                          const SizedBox(
                                            width: 15,
                                          ),

                                          Expanded(
                                            child: Text(
                                              'Questão $questionNumber',

                                              style:
                                                  const TextStyle(
                                                fontFamily:
                                                    'Inter',
                                                fontSize: 16,
                                                fontWeight:
                                                    FontWeight.w500,
                                              ),
                                            ),
                                          ),

                                          const Icon(
                                            Icons.chevron_right,
                                            color:
                                                Color(0xFF10279A),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ==================================================
                        // CONTEÚDOS PARA REVISAR
                        // ==================================================

                        _sectionCard(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [
                              const Text(
                                'Conteúdos para revisar',

                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 16),

                              ...reviewTopics.map(
                                (topic) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets
                                            .symmetric(
                                      vertical: 7,
                                    ),

                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,

                                      children: [
                                        const Padding(
                                          padding:
                                              EdgeInsets.only(
                                            top: 5,
                                          ),

                                          child: Icon(
                                            Icons.circle,
                                            size: 7,
                                            color:
                                                Color(0xFF10279A),
                                          ),
                                        ),

                                        const SizedBox(
                                          width: 10,
                                        ),

                                        Expanded(
                                          child: Text(
                                            topic,

                                            style:
                                                const TextStyle(
                                              fontFamily:
                                                  'Inter',
                                              fontSize: 15,
                                              color:
                                                  Color(
                                                0xFF333333,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 25),

                        // ==================================================
                        // REVISAR QUESTÕES
                        // ==================================================

                        SizedBox(
                          width: double.infinity,
                          height: 58,

                          child: ElevatedButton(
                            onPressed: () {
                              if (wrongQuestions.isEmpty) {
                                return;
                              }

                              Navigator.pushNamed(
                                context,
                                '/questions',
                                arguments: {
                                  'initialQuestion':
                                      wrongQuestions.first,
                                  'reviewMode': true,
                                },
                              );
                            },

                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF10279A),

                              foregroundColor:
                                  Colors.white,

                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20),
                              ),

                              elevation: 0,
                            ),

                            child: const Text(
                              'Revisar questões',

                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 17,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // ==================================================
                        // VOLTAR AO INÍCIO
                        // ==================================================

                        SizedBox(
                          width: double.infinity,
                          height: 58,

                          child: OutlinedButton(
                            onPressed: () {
                              Navigator
                                  .pushNamedAndRemoveUntil(
                                context,
                                '/home',
                                (route) => false,
                              );
                            },

                            style:
                                OutlinedButton.styleFrom(
                              foregroundColor:
                                  const Color(0xFF10279A),

                              side: const BorderSide(
                                color: Color(0xFF10279A),
                                width: 1.5,
                              ),

                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20),
                              ),
                            ),

                            child: const Text(
                              'Voltar ao início',

                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 17,
                                fontWeight:
                                    FontWeight.bold,
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
  // CARD DAS SEÇÕES
  // ==============================================================

  Widget _sectionCard({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(22),

        border: Border.all(
          color: const Color(0xFFE2E2E2),
        ),
      ),

      child: child,
    );
  }
}