import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_house/Shared/Widgets/CustomInformCard.dart';

import '../../ServicesManagement/Interfaces/RequestInterface.dart';
import '../Widgets/texts/titles.dart';

class SeeDetails extends StatelessWidget {
  final RequestInterface request;
  String? name;
  
  SeeDetails(this.request, this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Titles(28, "Detalles de la solicitud"),
        backgroundColor: const Color(0xffffffff),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0XFF02AA8B),
          ),
          onPressed: () => {Navigator.of(context).pop()},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CustomInfoCard(Icons.person, "Name:", name ?? "N/A"),
            const SizedBox(height: 10),
            CustomInfoCard(Icons.category, "Categoría:", request.category ?? "N/A"),
            const SizedBox(height: 10),
            CustomInfoCard(Icons.price_change_outlined, "Presupuesto Estimado:", request.estimatedBudget!= null
                ? "${request.estimatedBudget!}"
                : "N/A"),
            const SizedBox(height: 10),
            CustomInfoCard(Icons.area_chart_outlined, "Área en m^2: ", request.area != null ? "${request.area} m^2" : "N/A"),
            const SizedBox(height: 10),
            CustomInfoCard(Icons.map_outlined, "Ubicación: ", request.location ?? "N/A"),
            const SizedBox(height: 10),
            CustomInfoCard(Icons.file_copy_outlined, "Archivos: ", request.file ?? "N/A"),
            const SizedBox(height: 10),
            CustomInfoCard(Icons.description, "Descripción: ", request.description ?? "N/A"),
            const SizedBox(height: 10),
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