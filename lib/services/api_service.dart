import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cita.dart';

class ApiService {
  final String baseUrl = 'http://localhost:8081/api/citas';
  final String authUrl = 'http://localhost:8081/api/pacientes/auth';// Asegúrate de usar la URL correcta

  //METODOS PARA CITAS
  Future<List<Cita>> getCitas() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      return data.map((e) => Cita.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar las citas');
    }
  }

  Future<void> saveCita(Cita cita) async {
    final bool esNuevaCita = cita.id == null; // Verifica si es una nueva cita

    final String url = esNuevaCita ? baseUrl : '$baseUrl/${cita.id}';
    final response = await (esNuevaCita
        ? http.post( // Crear nueva cita
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(cita.toJson()),
    )
        : http.put( // Actualizar cita existente
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(cita.toJson()),
    ));

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Error al guardar la cita: ${response.body}');
    }
  }


  Future<void> deleteCita(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar la cita');
    }
  }


  //METODOS PARA LOGIN
// Método para autenticar pacientes
  Future<bool> autenticarPaciente(String email, String fechaNacimiento) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login-paciente'), // Ruta del backend para autenticar pacientes
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'fechaNacimiento': fechaNacimiento}),
    );

    if (response.statusCode == 200) {
      print('Login exitoso');
      return true;
    } else {
      print('Error en autenticación: ${response.body}');
      return false;
    }
  }
}
