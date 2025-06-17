// import 'package:dio/dio.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';

class Utils {
  static String apiKey = "2e271329609241c49c78fa1f0c203155";
  static const bool admin = true;

  static void showToast({required BuildContext context, required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Constants.primaryLight,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showAlertDialog({required BuildContext context, required String title, String subtitle = "", required Function() onConfirm}) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            content: Text(subtitle),
            actions: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => onConfirm(),
                      child: const Text("Yes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () => Modular.to.pop(),
                      child: const Text("No", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }

  static String generateSubTitleUser() {
    final random = Random();

    const adjetivos = [
      'Lendário',
      'Implacável',
      'Sombrio',
      'Espectral',
      'Mestre',
      'Aprendiz',
      'Explorador',
      'Veterano',
      'Novato',
      'Digital',
      'Cromado',
      'Corrompido',
      'Iluminado',
      'Silencioso',
      'Indomável',
      'Quântico',
      'Frenético',
    ];

    const substantivos = [
      'Campeão',
      'Gladiador',
      'Sentinela',
      'Algoz',
      'Peregrino',
      'Estrategista',
      'Mercenário',
      'Fantasma',
      'Desafiante',
      'Sobrevivente',
      'Navegador',
      'Cronomante',
      'Caçador de Glitch',
      'Streamer',
      'Speedrunner',
    ];

    const dominios = [
      'da Arena',
      'do Abismo',
      'de Valhalla',
      'do Nexus',
      'da Última Fronteira',
      'dos Pixels',
      'do Código-Fonte',
      'das Sombras',
      'do Vazio',
      'de Cyberpunk',
      'do Ping Alto',
      'da Realidade Virtual',
      'do Multiverso',
    ];
    final tipoDeTitulo = random.nextInt(3);

    switch (tipoDeTitulo) {
      case 0:
        final adjetivoAleatorio = adjetivos[random.nextInt(adjetivos.length)];
        final substantivoAleatorio = substantivos[random.nextInt(substantivos.length)];
        return '$adjetivoAleatorio $substantivoAleatorio';

      case 1:
        final substantivoAleatorio = substantivos[random.nextInt(substantivos.length)];
        final dominioAleatorio = dominios[random.nextInt(dominios.length)];
        return '$substantivoAleatorio $dominioAleatorio';

      case 2:
        final titulosUnicos = [...adjetivos, ...substantivos];
        final tituloAleatorio = titulosUnicos[random.nextInt(titulosUnicos.length)];
        return 'O $tituloAleatorio';
      default:
        return 'Jogador Profissional';
    }
  }

  static void showSuccess({required BuildContext context, required String message}) {
    _showSnackbar(context: context, message: message, backgroundColor: Colors.green.shade700, icon: Icons.check_circle_outline);
  }

  static void showError({required BuildContext context, required String message}) {
    _showSnackbar(context: context, message: message, backgroundColor: Colors.red.shade800, icon: Icons.error_outline);
  }

  static void showInfo({required BuildContext context, required String message}) {
    _showSnackbar(context: context, message: message, backgroundColor: Colors.blue.shade700, icon: Icons.info_outline);
  }

  static void _showSnackbar({required BuildContext context, required String message, required Color backgroundColor, required IconData icon}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackbar = SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12.0),
          Expanded(child: Text(message, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15))),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      duration: const Duration(seconds: 4),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
