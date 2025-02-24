import 'package:flutter/material.dart';
import '../models/medico.dart';
import '../services/medico_service.dart';

class MedicoScreen extends StatefulWidget {
  @override
  _MedicoScreenState createState() => _MedicoScreenState();
}

class _MedicoScreenState extends State<MedicoScreen> {
  final MedicoService medicoService = MedicoService();
  List<Medico> medicos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarMedicos();
  }

  Future<void> _cargarMedicos() async {
    try {
      List<Medico> lista = await medicoService.obtenerMedicos();
      setState(() {
        medicos = lista;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Médicos'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Card(
                color: Colors.blue.shade50,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue.shade300),
                    columns: [
                      DataColumn(label: Row(
                        children: [
                          Icon(Icons.confirmation_number, color: Colors.white),
                          SizedBox(width: 5),
                          Text('ID', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        ],
                      )),
                      DataColumn(label: Row(
                        children: [
                          Icon(Icons.person, color: Colors.white),
                          SizedBox(width: 5),
                          Text('Nombre', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        ],
                      )),
                      DataColumn(label: Text('Apellido', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                      DataColumn(label: Row(
                        children: [
                          Icon(Icons.medical_services, color: Colors.white),
                          SizedBox(width: 5),
                          Text('Especialidad', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        ],
                      )),
                    ],
                    rows: medicos.map((medico) => DataRow(cells: [
                      DataCell(Row(
                        children: [
                          Icon(Icons.confirmation_number, color: Colors.blue.shade900),
                          SizedBox(width: 5),
                          Text(medico.id.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )),
                      DataCell(Row(
                        children: [
                          Icon(Icons.person, color: Colors.blue.shade900),
                          SizedBox(width: 5),
                          Text(medico.nombre, style: TextStyle(color: Colors.blue.shade900)),
                        ],
                      )),
                      DataCell(Text(medico.apellido, style: TextStyle(color: Colors.blue.shade900))),
                      DataCell(Row(
                        children: [
                          Icon(Icons.medical_services, color: Colors.blue.shade900),
                          SizedBox(width: 5),
                          Text(medico.especialidad, style: TextStyle(fontStyle: FontStyle.italic)),
                        ],
                      )),
                    ])).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
