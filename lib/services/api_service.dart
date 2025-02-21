import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cita.dart';

class ApiService {
  final String baseUrl = 'http://localhost:8080/api/citas'; // Asegúrate de usar la URL correcta

  Future<List<Cita>> getCitas() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      return data.map((e) => Cita.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar las citas');
    }
  }

  Future<void> deleteCita(int id) async {  // 🔹 Agregar este método
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar la cita');
    }
  }
  Future<void> saveCita(Cita cita) async {
    final url = cita.id == null ? baseUrl : '$baseUrl/${cita.id}';
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(cita.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Error al guardar la cita');
    }
  }

}
