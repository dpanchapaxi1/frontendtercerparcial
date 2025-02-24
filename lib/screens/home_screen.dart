import 'package:flutter/material.dart';
import 'citas_list_screen.dart';
<<<<<<< HEAD
import 'medico_list_screen.dart'; // Importar la pantalla de médicos
=======
>>>>>>> dcdac479fc5ff24cec8d6452647fdc487cb1962e

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      body: Stack(
        children: [
          // Imagen de fondo con transparencia
          Opacity(
            opacity: 0.8, // Ajusta la opacidad según lo necesites (0.0 - 1.0)
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/fondo.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Contenido principal
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Cambiado a start
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100), // Espacio para subir el texto
                Text(
                  'Bienvenido al Sistema de Gestión de Citas Médicas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                // Botón para agendar citas
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade900,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CitasListScreen()),
                    );
                  },
                  child: Text('Agendar Citas Médicas'),
                ),
                SizedBox(height: 20), // Espaciado entre los botones
                // Nuevo botón para ver la lista de médicos
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade900, // Color diferente
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MedicoScreen()),
                    );
                  },
                  child: Text('Ver Lista de Médicos'),
                ),
              ],
            ),
          ),
        ],
=======
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade900, Colors.blue.shade400],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bienvenido a la Gestión de Citas Médicas',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              textStyle: TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.white,  // Reemplaza "primary" por "backgroundColor"
              foregroundColor: Colors.blue.shade900,  // Reemplaza "onPrimary" por "foregroundColor"
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CitasListScreen()),
              );
            },
            child: Text('Ver Citas Médicas'),
          ),
            ],
          ),
        ),
>>>>>>> dcdac479fc5ff24cec8d6452647fdc487cb1962e
      ),
    );
  }
}
