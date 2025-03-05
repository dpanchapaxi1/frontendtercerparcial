import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/medico.dart';

class MedicoService {
  final String baseUrl = 'http://localhost:8080/api/medicos'; // Cambia la URL por la de tu backend

  Future<List<Medico>> obtenerMedicos() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Medico.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener médicos');
    }
  }
}
