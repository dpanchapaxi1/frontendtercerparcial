import 'package:flutter/material.dart';
import '../models/cita.dart';

class CitaCard extends StatelessWidget {
  final Cita cita;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  CitaCard({required this.cita, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center, // Centra la tarjeta en el eje horizontal
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6, // Ajusta el ancho (60% de la pantalla)
        child: Card(
          color: Colors.grey[200], // Cambia el color del fondo de la tarjeta
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10), // Espaciado
          elevation: 5, // Agrega sombra a la tarjeta
          child: Padding(
            padding: EdgeInsets.all(10), // Agrega padding interno
            child: ListTile(
              title: Text(
                'Paciente ID: ${cita.paciente_Id} - Médico ID: ${cita.medico_Id}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${cita.fecha} a las ${cita.hora} en consultorio ${cita.consultorioNumero}',
              ),
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
          ),
        ),
      ),
    );
  }
}
