// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:luso/functions/Func.dart';

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

  int? selectedAnswer;

  // IDs das questões já sorteadas nesta rodada (não podem repetir).
  final List<String> _usedQuestionIds = [];

  // ID da questão atualmente exibida.
  String? _currentQuestionId;

  // Guarda as questões que o usuário errou.
  final List<Map<String, dynamic>> wrongQuestions = [];

  // Guarda os conteúdos relacionados aos erros.
  final List<String> contentsToReview = [];

  List<Map<String, dynamic>> _reviewList = [];
  int _reviewIndex = 0;

  // ============================================================
  // DADOS VINDOS DA API
  // ============================================================

  int _fase = 1;
  bool _carregando = true;

  String _enunciado = '';
  List<String?> _alternativas = [];
  int _alternativaCorreta = 1; // índice 1..5 (índice 0 é null na API)
  String _assunto = '';

  // ============================================================
  // CICLO DE VIDA
  // ============================================================

  @override
  void initState() {
    super.initState();
    currentQuestion = widget.initialQuestion;

    // Se for início de rodada, começa com histórico vazio.
    if (widget.initialQuestion == 1 && !widget.reviewMode) {
      _usedQuestionIds.clear();
      _currentQuestionId = null;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      _fase = (args?['fase'] as int?) ?? 1;

      // ============================================================
      // MODO REVISÃO: usa a lista passada, não consulta a API.
      // ============================================================
      if (widget.reviewMode) {
        final rawList = args?['reviewList'];

        if (rawList is List) {
          _reviewList = rawList
              .whereType<Map>()
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        } else if (args?['reviewData'] is Map) {
          // Compatibilidade com o formato antigo (uma só questão).
          _reviewList = [Map<String, dynamic>.from(args!['reviewData'] as Map)];
        }

        final rawIndex = args?['reviewIndex'];
        _reviewIndex =
            (rawIndex is int && rawIndex >= 0 && rawIndex < _reviewList.length)
            ? rawIndex
            : 0;

        _loadReviewItem();
        return;
      }

      // Modo normal: sorteia questão da API.
      _carregarQuestao();
    });
  }

  void _loadReviewItem() {
    if (_reviewList.isEmpty) {
      setState(() => _carregando = false);
      return;
    }

    final q = _reviewList[_reviewIndex];

    setState(() {
      currentQuestion = (q['number'] as int?) ?? (_reviewIndex + 1);
      _enunciado = q['enunciado'] as String? ?? '';
      _alternativas = List<String?>.from(
        (q['alternativas'] as List?) ?? const [],
      );
      _alternativaCorreta = q['correta'] as int? ?? 1;
      _assunto = q['assunto'] as String? ?? '';
      selectedAnswer = null;
      _carregando = false;
    });
  }

  Future<void> _carregarQuestao() async {
    setState(() => _carregando = true);

    final dados = await Func.getQuestionsForFase(
      _fase,
      exclude: _usedQuestionIds, // <<< passa as já usadas
    );

    if (!mounted) return;

    if (dados == null || dados['status'] != 'success') {
      setState(() => _carregando = false);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erro ao carregar questão')));
      return;
    }

    final q = dados['question'] as Map<String, dynamic>;
    final id = dados['id']?.toString();

    // Guarda o ID da questão atual para poder excluí-la na próxima.
    if (id != null && id.isNotEmpty) {
      _currentQuestionId = id;
    }

    setState(() {
      _enunciado = q['enunciado'] as String? ?? '';
      _alternativas = List<String?>.from(q['alternativas'] as List);
      _alternativaCorreta = q['alternativa_correta'] as int? ?? 1;
      _assunto = q['assuntos'] as String? ?? '';
      _carregando = false;
    });
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    // Enquanto carrega a API, mostra spinner.
    if (_carregando) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF1735B4)),
        ),
      );
    }

    final bool isReview = widget.reviewMode && _reviewList.isNotEmpty;
    final int displayNum = isReview ? (_reviewIndex + 1) : currentQuestion;
    final int displayTot = isReview ? _reviewList.length : totalQuestions;
    final double progress = displayNum / displayTot;

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
                padding: const EdgeInsets.fromLTRB(24, 25, 24, 30),

                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        // =================================================
                        // QUESTÃO X DE 10
                        // =================================================
                        Text(
                          isReview
                              ? 'Revisão $displayNum de $displayTot'
                              : 'Questão $displayNum de $displayTot',
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

                            backgroundColor: const Color(0xFFE6E8F0),

                            valueColor: const AlwaysStoppedAnimation<Color>(
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

                            borderRadius: BorderRadius.circular(22),

                            border: Border.all(color: const Color(0xFFE2E2E2)),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

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
                                _enunciado.isEmpty
                                    ? 'Carregando...'
                                    : _enunciado,

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
                        ...List.generate(5, (i) {
                          const letras = ['A', 'B', 'C', 'D', 'E'];

                          // A API começa no índice 1 (índice 0 é null).
                          final idxApi = i + 1;

                          final texto = idxApi < _alternativas.length
                              ? (_alternativas[idxApi] ?? '')
                              : '';

                          if (texto.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return answerButton(
                            letter: letras[i],
                            text: texto,
                            index: idxApi,
                          );
                        }),

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
                              backgroundColor: const Color(0xFF1735B4),

                              foregroundColor: Colors.white,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),

                              elevation: 0,
                            ),

                            child: Text(
                              widget.reviewMode
                                  ? (_reviewIndex < _reviewList.length - 1
                                        ? 'Próxima questão'
                                        : 'Concluir revisão')
                                  : (currentQuestion == totalQuestions
                                        ? 'Finalizar'
                                        : 'Próxima questão'),
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
    required int index,
  }) {
    bool isSelected = selectedAnswer == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnswer = index;
        });
      },

      child: Container(
        width: double.infinity,

        margin: const EdgeInsets.only(bottom: 12),

        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),

        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE9EEFF) : Colors.white,

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

                color: isSelected ? const Color(0xFF1735B4) : Colors.white,

                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF1735B4)
                      : const Color(0xFFCCCCCC),

                  width: 2,
                ),
              ),

              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
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
            content: Text('Selecione uma alternativa antes de continuar.'),
          ),
        );
        return;
      }

      final int correctAnswer = _alternativaCorreta;
      final bool acertou = selectedAnswer == correctAnswer;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            acertou
                ? 'Você acertou a questão na revisão!'
                : 'A resposta correta é ${_letraDaAlternativa(correctAnswer)}.',
          ),
        ),
      );

      Future.delayed(const Duration(milliseconds: 700), () {
        if (!mounted) return;

        // Ainda há questões a revisar?
        if (_reviewIndex < _reviewList.length - 1) {
          setState(() {
            _reviewIndex++;
            selectedAnswer = null;
          });
          _loadReviewItem();
        } else {
          // Fim da revisão: volta para a PerformancePage.
          Navigator.pop(context);
        }
      });

      return;
    }

    // ------------------------------------------------------------
    // MODO NORMAL
    // ------------------------------------------------------------

    if (selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione uma alternativa antes de continuar.'),
        ),
      );

      return;
    }

    // ------------------------------------------------------------
    // VERIFICA SE A RESPOSTA ESTÁ CORRETA
    // ------------------------------------------------------------

    final int correctAnswer = _alternativaCorreta;

    if (selectedAnswer != correctAnswer) {
      // Evita duplicar a mesma questão.
      final alreadyAdded = wrongQuestions.any(
        (q) => q['number'] == currentQuestion,
      );

      if (!alreadyAdded) {
        wrongQuestions.add({
          'number': currentQuestion,
          'id': _currentQuestionId,
          'enunciado': _enunciado,
          'alternativas': List<String?>.from(_alternativas),
          'correta': _alternativaCorreta,
          'assunto': _assunto,
        });
      }

      if (_assunto.isNotEmpty && !contentsToReview.contains(_assunto)) {
        contentsToReview.add(_assunto);
      }
    }

    // ------------------------------------------------------------
    // SE AINDA NÃO TERMINOU
    // ------------------------------------------------------------

    // ------------------------------------------------------------
    // SE AINDA NÃO TERMINOU
    // ------------------------------------------------------------

    if (currentQuestion < totalQuestions) {
      // Marca esta questão como já usada para não repetir.
      if (_currentQuestionId != null &&
          !_usedQuestionIds.contains(_currentQuestionId)) {
        _usedQuestionIds.add(_currentQuestionId!);
      }

      setState(() {
        currentQuestion++;
        selectedAnswer = null;
      });

      _carregarQuestao();
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
      Navigator.pushReplacementNamed(context, '/perfect_result');

      return;
    }

    // ------------------------------------------------------------
    // USUÁRIO ERROU ALGUMA QUESTÃO
    // ------------------------------------------------------------

    Navigator.pushReplacementNamed(
      context,
      '/performance',
      arguments: {
        'correctAnswers': totalQuestions - wrongQuestions.length,
        'totalQuestions': totalQuestions,
        'wrongQuestions': wrongQuestions, // agora List<Map>
        'reviewTopics': contentsToReview,
        'fase': _fase,
      },
    );
  }

  // ==============================================================
  // HELPERS
  // ==============================================================

  String _letraDaAlternativa(int index) {
    const letras = ['A', 'B', 'C', 'D', 'E'];
    final i = index - 1;
    if (i < 0 || i >= letras.length) return '?';
    return letras[i];
  }
}
