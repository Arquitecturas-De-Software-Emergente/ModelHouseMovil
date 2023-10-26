import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AcceptRejectButtons extends StatelessWidget {
  final VoidCallback onAcceptPressed;
  final VoidCallback onRejectPressed;

  const AcceptRejectButtons(
      {super.key,
      required this.onAcceptPressed,
      required this.onRejectPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white, // Fondo blanco
            borderRadius:
                BorderRadius.circular(10.0), // Bordes redondeados de 10px
            border: Border.all(color: Colors.green, width: 2.0), // Borde verde
          ),
          child: TextButton(
            onPressed: onAcceptPressed,
            style: TextButton.styleFrom(
                primary: Colors.green), // Color del texto verde
            child: const Text('Accept'), // Texto del botón
          ),
        ),
        const SizedBox(width: 16), // Espacio entre los botones
        Container(
          decoration: BoxDecoration(
            color: Colors.white, // Fondo blanco
            borderRadius:
                BorderRadius.circular(10.0), // Bordes redondeados de 10px
            border: Border.all(color: Colors.red, width: 2.0), // Borde verde
          ),
          child: TextButton(
            onPressed: onRejectPressed,
            style: TextButton.styleFrom(
                primary: Colors.red), // Color del texto verde
            child: const Text('Reject'), // Texto del botón
          ),
        ),
      ],
    );
  }
}
