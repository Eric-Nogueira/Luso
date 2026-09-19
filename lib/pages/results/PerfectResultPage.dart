import 'package:flutter/material.dart';

class PerfectResultPage extends StatelessWidget {
  const PerfectResultPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            30,
            24,
            30,
          ),

          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 550,
              ),

              child: Column(
                children: [
                  // ========================================================
                  // PARABÉNS
                  // ========================================================

                  const Text(
                    'Parabéns!',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF168540),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Você acertou todas\nas questões!',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222222),
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ========================================================
                  // MASCOTE
                  // ========================================================

                  SizedBox(
                    height: 260,

                    child: Image.asset(
                      'assets/img/MASCOTE_LUSO.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ========================================================
                  // CARD 10/10
                  // ========================================================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 30,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(25),

                      border: Border.all(
                        color: const Color(0xFFE2E2E2),
                      ),
                    ),

                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,

                          children: [
                            Container(
                              width: 60,
                              height: 60,

                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF168540),
                              ),

                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),

                            const SizedBox(width: 18),

                            const Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [
                                Text(
                                  '10/10',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF168540),
                                  ),
                                ),

                                Text(
                                  'acertos',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF168540),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        const Text(
                          'Nível concluído!',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF222222),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ========================================================
                  // CONTINUAR
                  // ========================================================

                  SizedBox(
                    width: double.infinity,
                    height: 60,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          (route) => false,
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF10279A),

                        foregroundColor: Colors.white,

                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                      ),

                      child: const Text(
                        'Continuar',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
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
    );
  }
}