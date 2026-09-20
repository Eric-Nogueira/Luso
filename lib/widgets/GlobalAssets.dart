import 'package:flutter/material.dart';

class Assets {
  Widget appBar(
    BuildContext context,
    String route,
    Icon icon,
    String tooltip,
  ) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: icon,
        tooltip: tooltip,
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }

  Widget background() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 250, 250, 250),
                Color.fromARGB(255, 220, 220, 220),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget elbutton(
    String text,
    VoidCallback onPressed,
    Color bgColor,
    int width,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: bgColor.withAlpha(150),
            blurRadius: 0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      width: width.isNaN ? 300 : width.toDouble() + 10,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: SizedBox(
          width: width.isNaN ? 300 : width.toDouble() + 10,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }

  // BOTÃO DAS FASES DA HOME

  Widget faseButton({
    required IconData icon,
    required String title,
    required String description,
    String? route,
    Map<String, dynamic>? arguments,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),

          // Por enquanto as rotas das fases ainda não existem.
          // Quando elas forem criadas, basta informar a rota.
          onTap: route == null
              ? null
              : () {
                  Navigator.pushNamed(context, route, arguments: arguments);
                },

          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 14,
            ),
            child: Row(
              children: [
                // ÍCONE
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C094A),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 26,
                  ),
                ),

                const SizedBox(width: 15),

                // TÍTULO E DESCRIÇÃO
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C094A),
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        description,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                // SETA
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Color(0xFF1C094A),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}