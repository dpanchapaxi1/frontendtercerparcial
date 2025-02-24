import 'package:flutter/material.dart';
import '../models/cita.dart';

class CitaCard extends StatelessWidget {
  final Cita cita;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  CitaCard({required this.cita, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 5,
      child: ListTile(
        title: Text('Paciente ID: ${cita.paciente_Id} - Médico ID: ${cita.medico_Id}'),
        subtitle: Text('${cita.fecha} a las ${cita.hora} en consultorio ${cita.consultorioNumero}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
