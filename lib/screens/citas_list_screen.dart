import 'package:flutter/material.dart';
import '../models/cita.dart';
import '../services/api_service.dart';
import 'edit_cita_screen.dart';
import '../widgets/cita_card.dart';

class CitasListScreen extends StatefulWidget {
  @override
  _CitasListScreenState createState() => _CitasListScreenState();
}

class _CitasListScreenState extends State<CitasListScreen> {
  final ApiService apiService = ApiService();
  List<Cita> citas = [];

  @override
  void initState() {
    super.initState();
    fetchCitas();
  }

  void fetchCitas() async {
    final data = await apiService.getCitas();
    setState(() {
      citas = data;
    });
  }

  void confirmDeleteCita(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmación"),
          content: Text("¿Está seguro que desea eliminar esta cita?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el diálogo sin hacer nada
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el diálogo
                deleteCita(id); // Llama a la función de eliminación
              },
              child: Text("Eliminar", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void deleteCita(int id) async {
    setState(() {
      citas.removeWhere((cita) => cita.id == id); // Eliminar de la UI inmediatamente
    });

    await apiService.deleteCita(id); // Llamar a la API para eliminar en el servidor
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Citas Médicas'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.blue[500]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: citas.isEmpty
              ? CircularProgressIndicator()
              : ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            itemCount: citas.length,
            itemBuilder: (context, index) {
              final cita = citas[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CitaCard(
                  cita: cita,
                  onEdit: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditCitaScreen(cita: cita),
                      ),
                    );

                    if (result == true) {
                      fetchCitas(); // Actualiza la lista si hubo cambios
                    }
                  },
                  onDelete: () => confirmDeleteCita(cita.id ?? 0),

                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditCitaScreen()),
          );

          if (result == true) {
            fetchCitas(); // Actualiza la lista si se creó una nueva cita
          }
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
