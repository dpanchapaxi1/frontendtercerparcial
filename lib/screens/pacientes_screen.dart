import 'package:flutter/material.dart';
import '../models/paciente.dart';
import '../services/paciente_service.dart';

class PacientesScreen extends StatefulWidget {
  @override
  _PacientesScreenState createState() => _PacientesScreenState();
}

class _PacientesScreenState extends State<PacientesScreen> {
  final PacienteService pacienteService = PacienteService();
  List<Paciente> pacientes = [];
  bool isLoading = true;

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController fechaNacimientoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  int? pacienteIdToEdit;

  @override
  void initState() {
    super.initState();
    _cargarPacientes();
  }

  Future<void> _cargarPacientes() async {
    try {
      List<Paciente> lista = await pacienteService.obtenerPacientes();
      setState(() {
        pacientes = lista;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error: $e");
    }
  }

  Future<void> _agregarPaciente() async {
    if (nombreController.text.isEmpty || apellidoController.text.isEmpty || fechaNacimientoController.text.isEmpty || emailController.text.isEmpty) {
      return;
    }

    Paciente nuevoPaciente = Paciente(
      id: 0,
      nombre: nombreController.text,
      apellido: apellidoController.text,
      fechaNacimiento: fechaNacimientoController.text,
      email: emailController.text,
    );

    try {
      Paciente pacienteCreado = await pacienteService.crearPaciente(nuevoPaciente);
      setState(() {
        pacientes.add(pacienteCreado);
      });

      nombreController.clear();
      apellidoController.clear();
      fechaNacimientoController.clear();
      emailController.clear();
    } catch (e) {
      print("Error al agregar paciente: $e");
    }
  }

  Future<void> _editarPaciente() async {
    if (pacienteIdToEdit == null || nombreController.text.isEmpty || apellidoController.text.isEmpty || fechaNacimientoController.text.isEmpty || emailController.text.isEmpty) {
      return;
    }

    Paciente pacienteEditado = Paciente(
      id: pacienteIdToEdit!,
      nombre: nombreController.text,
      apellido: apellidoController.text,
      fechaNacimiento: fechaNacimientoController.text,
      email: emailController.text,
    );

    try {
      Paciente pacienteActualizado = await pacienteService.editarPaciente(pacienteIdToEdit!, pacienteEditado);
      setState(() {
        int index = pacientes.indexWhere((paciente) => paciente.id == pacienteIdToEdit);
        pacientes[index] = pacienteActualizado;
      });

      nombreController.clear();
      apellidoController.clear();
      fechaNacimientoController.clear();
      emailController.clear();
      pacienteIdToEdit = null;  // Reset after editing
    } catch (e) {
      print("Error al editar paciente: $e");
    }
  }

  Future<void> _eliminarPaciente(int id) async {
    bool confirmar = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar eliminación"),
          content: Text("¿Estás seguro de que deseas eliminar este paciente?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Cancelar
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Confirmar
              child: Text("Eliminar", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      try {
        await pacienteService.eliminarPaciente(id);
        setState(() {
          pacientes.removeWhere((paciente) => paciente.id == id);
        });
      } catch (e) {
        print("Error al eliminar paciente: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pacientes'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              width: 400,
              child: Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: nombreController,
                        decoration: InputDecoration(labelText: 'Nombre'),
                      ),
                      TextField(
                        controller: apellidoController,
                        decoration: InputDecoration(labelText: 'Apellido'),
                      ),
                      TextField(
                        controller: fechaNacimientoController,
                        decoration: InputDecoration(labelText: 'Fecha de Nacimiento (YYYY-MM-DD)'),
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: pacienteIdToEdit == null ? _agregarPaciente : _editarPaciente,
                        child: Text(pacienteIdToEdit == null ? 'Agregar Paciente' : 'Editar Paciente'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 40),

          // Título "Listado de Pacientes"
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Listado de Pacientes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue.shade300),
                  columns: [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Nombre')),
                    DataColumn(label: Text('Apellido')),
                    DataColumn(label: Text('Fecha Nacimiento')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Acciones')), // Nueva columna para acciones
                  ],
                  rows: pacientes.map((paciente) {
                    return DataRow(cells: [
                      DataCell(Text(paciente.id.toString())),
                      DataCell(Text(paciente.nombre)),
                      DataCell(Text(paciente.apellido)),
                      DataCell(Text(paciente.fechaNacimiento)),
                      DataCell(Text(paciente.email)),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                setState(() {
                                  pacienteIdToEdit = paciente.id;
                                  nombreController.text = paciente.nombre;
                                  apellidoController.text = paciente.apellido;
                                  fechaNacimientoController.text = paciente.fechaNacimiento;
                                  emailController.text = paciente.email;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _eliminarPaciente(paciente.id),
                            ),
                          ],
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
