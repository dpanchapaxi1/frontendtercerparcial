import 'package:flutter/material.dart';
import '../models/cita.dart';
import '../services/api_service.dart';

class EditCitaScreen extends StatefulWidget {
  final Cita? cita;
  EditCitaScreen({this.cita});

  @override
  _EditCitaScreenState createState() => _EditCitaScreenState();
}

class _EditCitaScreenState extends State<EditCitaScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController pacienteController;
  late TextEditingController medicoController;
  late TextEditingController fechaController;
  late TextEditingController horaController;
  late TextEditingController consultorioController;

  @override
  void initState() {
    super.initState();
    pacienteController = TextEditingController(text: widget.cita?.paciente_Id.toString() ?? '');
    medicoController = TextEditingController(text: widget.cita?.medico_Id.toString() ?? '');
    fechaController = TextEditingController(text: widget.cita?.fecha ?? '');
    horaController = TextEditingController(text: widget.cita?.hora ?? '');
    consultorioController = TextEditingController(text: widget.cita?.consultorioNumero ?? '');
  }

  void saveCita() async {
    if (_formKey.currentState!.validate()) {
      final cita = Cita(
        id: widget.cita?.id,  // Si es una cita existente, mantiene el ID
        paciente_Id: int.tryParse(pacienteController.text) ?? 0,
        medico_Id: int.tryParse(medicoController.text) ?? 0,
        fecha: fechaController.text,
        hora: horaController.text,
        consultorioNumero: consultorioController.text,
      );

      try {
        await ApiService().saveCita(cita);
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar la cita: ${e.toString()}')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.cita == null ? 'Nueva Cita' : 'Editar Cita')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade900, Colors.blue.shade400],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Formulario de Cita',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
                      SizedBox(height: 20),
                      TextFormField(controller: pacienteController, decoration: InputDecoration(labelText: 'Paciente ID')),
                      TextFormField(controller: medicoController, decoration: InputDecoration(labelText: 'Médico ID')),
                      TextFormField(controller: fechaController, decoration: InputDecoration(labelText: 'Fecha (YYYY-MM-DD)')),
                      TextFormField(controller: horaController, decoration: InputDecoration(labelText: 'Hora (HH:MM)')),
                      TextFormField(controller: consultorioController, decoration: InputDecoration(labelText: 'Consultorio')),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          textStyle: TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.blue.shade900,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: saveCita,
                        child: Text('Guardar'),
                      ),
                    ],
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
