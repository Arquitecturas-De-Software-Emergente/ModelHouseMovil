import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ServicesManagement/Interfaces/RequestInterface.dart';

class SeeDetails extends StatelessWidget {
  final RequestInterface request;
  String? name;

  SeeDetails(this.request, this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles de la Solicitud',
          style: TextStyle(
            color: Colors.black, // Color del texto del título del AppBar
            fontSize: 20.0, // Tamaño de fuente del título del AppBar
          ),
        ),
        backgroundColor: Colors.white, // Ajusta el color de fondo del AppBar según tus preferencias
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0XFF02AA8B), // Color del botón de retroceso
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(name ?? "N/A", ""),
            _buildDetailRow("Categoría:", request.category ?? "N/A"),
            _buildDetailRow("Presupuesto Estimado:", request.estimatedBudget != null
                ? "${request.estimatedBudget!}"
                : "N/A"), // Formatea el presupuesto como moneda
            _buildDetailRow("Área en m^2:", request.area != null ? "${request.area} m^2" : "N/A"),
            _buildDetailRow("Ubicación:", request.location ?? "N/A"),
            _buildDetailRow("Archivos:", request.file ?? "N/A"),
            _buildDetailRow("Descripción:", request.description ?? "N/A"),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black, // Color del texto de la etiqueta
            fontSize: 16.0, // Tamaño de fuente de la etiqueta
            fontWeight: FontWeight.bold, // Establece el texto de etiqueta en negrita
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black, // Color del texto de valor
            fontSize: 18.0, // Tamaño de fuente del valor
          ),
        ),
        SizedBox(height: 12.0), // Agrega espacio entre cada par de etiqueta y valor
      ],
    );
  }
}