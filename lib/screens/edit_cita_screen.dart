import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/cita.dart';
import '../services/api_service.dart';

class EditCitaScreen extends StatefulWidget {
  final Cita? cita;
  final VoidCallback? onCitaSaved;

  EditCitaScreen({this.cita, this.onCitaSaved});

  @override
  _EditCitaScreenState createState() => _EditCitaScreenState();
}

class _EditCitaScreenState extends State<EditCitaScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController pacienteController;
  late TextEditingController medicoController;
  late TextEditingController fechaController;
  late TextEditingController consultorioController;
  String? selectedHora;

  @override
  void initState() {
    super.initState();
    pacienteController = TextEditingController(text: widget.cita?.paciente_Id.toString() ?? '');
    medicoController = TextEditingController(text: widget.cita?.medico_Id.toString() ?? '');
    fechaController = TextEditingController(text: widget.cita?.fecha ?? '');
    consultorioController = TextEditingController(text: widget.cita?.consultorioNumero ?? '');
    selectedHora = widget.cita?.hora;
  }

  @override
  void dispose() {
    pacienteController.dispose();
    medicoController.dispose();
    fechaController.dispose();
    consultorioController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime firstAvailableDate = today.add(Duration(days: 1));

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: firstAvailableDate,
      firstDate: firstAvailableDate,
      lastDate: DateTime(today.year + 1),
    );

    if (pickedDate != null) {
      setState(() {
        fechaController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  List<String> getHorariosDisponibles() {
    List<String> horarios = [];
    for (int hour = 8; hour <= 15; hour++) {
      for (int minute = 0; minute < 60; minute += 30) {
        String hora = '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00';
        horarios.add(hora);
      }
    }
    return horarios;
  }

  void saveCita() async {
    if (_formKey.currentState!.validate()) {
      final cita = Cita(
        id: widget.cita?.id,
        paciente_Id: int.tryParse(pacienteController.text) ?? 0,
        medico_Id: int.tryParse(medicoController.text) ?? 0,
        fecha: fechaController.text,
        hora: selectedHora ?? '',
        consultorioNumero: consultorioController.text,
      );

      try {
        await ApiService().saveCita(cita);
        if (widget.onCitaSaved != null) {
          widget.onCitaSaved!();
        }
        Navigator.pop(context, true);
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
                      TextFormField(
                        controller: pacienteController,
                        decoration: InputDecoration(labelText: 'Paciente ID'),
                        keyboardType: TextInputType.number,
                        validator: (value) => value == null || value.isEmpty ? 'Ingrese el ID del paciente' : null,
                      ),
                      TextFormField(
                        controller: medicoController,
                        decoration: InputDecoration(labelText: 'Médico ID'),
                        keyboardType: TextInputType.number,
                        validator: (value) => value == null || value.isEmpty ? 'Ingrese el ID del médico' : null,
                      ),
                      TextFormField(
                        controller: fechaController,
                        decoration: InputDecoration(
                          labelText: 'Fecha (YYYY-MM-DD)',
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        validator: (value) => value == null || value.isEmpty ? 'Seleccione una fecha' : null,
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(labelText: 'Seleccione la hora de la cita'),
                        value: selectedHora,
                        items: getHorariosDisponibles().map((String hora) {
                          return DropdownMenuItem<String>(
                            value: hora,
                            child: Text(hora),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedHora = newValue;
                          });
                        },
                        validator: (value) => value == null ? 'Seleccione una hora' : null,
                      ),
                      TextFormField(
                        controller: consultorioController,
                        decoration: InputDecoration(labelText: 'Consultorio'),
                        validator: (value) => value == null || value.isEmpty ? 'Ingrese el número de consultorio' : null,
                      ),
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