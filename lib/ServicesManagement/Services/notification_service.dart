import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendNotification(String recipientToken, String title, String message) async {
  final String serverKey = 'AAAA8f9YeVk:APA91bE52LPetgXpuEOdy8pD5EKSdEkhLBy_DT8nP2dlgbACLCj--EuXMuejbFzYUPfuP0DunlCr6tE8GjFByDoHmjpkPap0rf6wCZNn92rBx_Vv1QZFsPZI_MhtTepXSwzTm8f0tM3u'; // Reemplaza con tu clave de servidor de Firebase
  final String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

  final Map<String, dynamic> body = {
    'notification': {
      'title': title,
      'body': message,
    },
    'priority': 'high',
    'data': {
      'screen': 'ruta_a_la_pantalla', // Datos adicionales que necesites
    },
    'to': recipientToken, // El token FCM del usuario destinatario
  };

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };

  final response = await http.post(
    Uri.parse(fcmUrl),
    headers: headers,
    body: json.encode(body),
  );

  if (response.statusCode == 200) {
    print('Notificación enviada con éxito');
  } else {
    print('Error al enviar la notificación: ${response.statusCode}');
  }
}
