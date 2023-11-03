import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async'; // Importar el paquete para Timer
import 'package:uuid/uuid.dart';

class Place {
  final String placeId;
  final String description;

  Place(this.placeId, this.description);

  @override
  String toString() {
    return 'Place(description: $description, placeId: $placeId)';
  }
}

class PlaceAPI extends StatefulWidget {
  final String title;

  PlaceAPI(this.title, {Key? key}) : super(key: key);

  @override
  _PlaceAPIState createState() => _PlaceAPIState();
}

class _PlaceAPIState extends State<PlaceAPI> {
  final _controller = TextEditingController();
  final apiKey = 'AIzaSyAUkXe3mWmqdi9LbB_dFVHcZ7-wLjZbxao'; // Reemplaza con tu clave de API de Google Places
  final sessionToken = Uuid().v4();
  List<Place> _suggestions = [];
  Timer? _debounce; // Para retrasar la llamada a fetchSuggestions

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void fetchSuggestions(String input) async {
    final request = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${input}&key=$apiKey&sessiontoken=$sessionToken&components=country:PE');
    final response = await http.get(request);
    print(response.body);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        setState(() {
          _suggestions = (result['predictions'] as List)
              .map((prediction) => Place(
              prediction['place_id'] as String,
              prediction['description'] as String))
              .toList();
        });
      } else {
        setState(() {
          _suggestions = [];
        });
      }
    } else {
      throw Exception('Failed to fetch suggestions');
    }
  }

  void onTextChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Llama fetchSuggestions después de un retraso de 500 ms
      fetchSuggestions(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            onChanged: onTextChanged, // Llamar onTextChanged en lugar de fetchSuggestions
            decoration: InputDecoration(
              hintText: 'Enter your shipping address',
              icon: Icon(Icons.home),
            ),
          ),
          if (_suggestions.isNotEmpty)
            Column(
              children: _suggestions
                  .map((suggestion) => ListTile(
                title: Text(suggestion.description),
                onTap: () {
                  setState(() {
                    _controller.text = suggestion.description;
                    _suggestions = [];
                  });
                },
              ))
                  .toList(),
            )
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PlaceAPI("Place Autocomplete"),
  ));
}
