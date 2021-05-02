import 'package:flutter/material.dart';

class UIConstants {
  static const TextStyle fieldHintStyle = TextStyle(fontWeight: FontWeight.w300, color: Colors.black);
  static const String appName = 'Retailmi';
  static const double progressBarOpacity = 0.6;
  static const Color progressBarColor = Colors.black;
}

class Strings {
  static const String regFormIncomplete = 'Favor de llenar todos los campos';
  static const String termsNotAccepted = 'Por favor acepte los terminos de servicio';
  static const String registSuccess = 'Registro exitoso';
  static const String forgotEmailSent = 'Le hemos enviado un correo para restablecer su contraseña';
  static const String forgotPassInstructions = 'Introducir el correo asociado a la cuenta. Le enviaremos un email con instrucciones';
}

class Resources {
  static const String logo = 'assets/img/logo.jpeg';
}

SnackBar _getGenericSnackbar(String text, bool isError){
  return SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: isError ? Colors.red : Colors.white,
        fontSize: 16.0,
      ),
    ),
  );
}

void showGenericSnackbar(BuildContext context, String text, {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(_getGenericSnackbar(text, isError));
}