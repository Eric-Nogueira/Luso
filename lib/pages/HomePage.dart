import 'package:flutter/material.dart';
import 'package:luso/widgets/GlobalAssets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Assets assets = Assets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          
          // FUNDO

          Positioned.fill(
            child: assets.background(),
          ),

          // CONTEÚDO DA HOME

          const PageContent(),
        ],
      ),
    );
  }
}

class PageContent extends StatelessWidget {
  const PageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final Assets assets = Assets();

    return SafeArea(
      child: Column(
        children: [
          // CABEÇALHO ROXO + LOGO

          Container(
            width: double.infinity,
            height: 120,
            color: const Color(0xFF1C094A),
            child: Center(
              child: Image.asset(
                'assets/img/logo/LOGO_LUSO_LIGHT.png',
                width: 130,
                height: 70,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // CONTEÚDO

          Expanded(
            child: Container(
              width: double.infinity,

              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),

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
                      maxWidth: 850,
                    ),

                    child: Column(
                      children: [

                        // MASCOTE + BALÃO DE FALA

                        SizedBox(
                          width: double.infinity,
                          height: 190,

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [

                              // MASCOTE

                              SizedBox(
                                width: 150,
                                height: 190,

                                child: Image.asset(
                                  'assets/img/mascotevars/mascote_initial.png',
                                  fit: BoxFit.contain,
                                  alignment: Alignment.bottomCenter,
                                ),
                              ),

                              const SizedBox(width: 12),

                              // BALÃO DE FALA

                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 18,
                                  ),

                                  decoration: BoxDecoration(
                                    color: Colors.white,

                                    borderRadius: BorderRadius.circular(22),

                                    border: Border.all(
                                      color: const Color(0xFFE0E0E0),
                                      width: 1.5,
                                    ),

                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withAlpha(15),
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),

                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    mainAxisSize: MainAxisSize.min,

                                    children: [

                                      // TÍTULO DO BALÃO

                                      Text(
                                        'Bem-vindo ao Luso!',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1C094A),
                                        ),
                                      ),

                                      SizedBox(height: 8),

                                      // DESCRIÇÃO DO BALÃO

                                      Text(
                                        'Prepare-se para testar seus conhecimentos e arrasar no Enem!',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF1C094A),
                                          height: 1.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // TÍTULO DAS FASES

                        const Align(
                          alignment: Alignment.centerLeft,

                          child: Text(
                            'Escolha uma fase',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1C094A),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // FASE SIMPLES

                        assets.faseButton(
                          icon: Icons.school,
                          title: 'Fase Simples',
                          description: 'Gabarite o básico!',
                          context: context,
                        ),

                        // FASE MÉDIA

                        assets.faseButton(
                          icon: Icons.menu_book,
                          title: 'Fase Média',
                          description: 'Aumente o seu nível!',
                          context: context,
                        ),

                        // FASE DIFÍCIL

                        assets.faseButton(
                          icon: Icons.emoji_events,
                          title: 'Fase Difícil',
                          description: 'Mostre o que você sabe!',
                          context: context,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}