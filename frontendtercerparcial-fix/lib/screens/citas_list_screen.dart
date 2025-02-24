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

  void deleteCita(int id) async {
    await apiService.deleteCita(id);
    fetchCitas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Citas Médicas')),
      body: ListView.builder(
        itemCount: citas.length,
        itemBuilder: (context, index) {
          final cita = citas[index];
          return CitaCard(
            cita: cita,
            onEdit: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditCitaScreen(cita: cita)),
            ),
            onDelete: () => deleteCita(cita.id ?? 0),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditCitaScreen()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
