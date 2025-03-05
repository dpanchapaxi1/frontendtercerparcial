import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/paciente.dart';

class PacienteService {
  final String baseUrl = 'http://localhost:8080/api/pacientes';

  // Obtener todos los pacientes
  Future<List<Paciente>> obtenerPacientes() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Paciente.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar pacientes');
    }
  }

  // Crear un nuevo paciente
  Future<Paciente> crearPaciente(Paciente paciente) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nombre': paciente.nombre,
        'apellido': paciente.apellido,
        'fechaNacimiento': paciente.fechaNacimiento,
        'email': paciente.email,
      }),
    );

    if (response.statusCode == 201) {
      return Paciente.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al crear paciente');
    }
  }

  // Eliminar un paciente por ID
  Future<void> eliminarPaciente(int id) async {
    final url = Uri.parse('$baseUrl/$id');

    final response = await http.delete(url);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Error al eliminar paciente');
    }
  }

  // Editar un paciente
  Future<Paciente> editarPaciente(int id, Paciente paciente) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nombre': paciente.nombre,
        'apellido': paciente.apellido,
        'fechaNacimiento': paciente.fechaNacimiento,
        'email': paciente.email,
      }),
    );

    if (response.statusCode == 200) {
      return Paciente.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al editar paciente');
    }
  }
}
