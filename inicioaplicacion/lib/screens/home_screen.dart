import 'package:flutter/material.dart';
import 'create_report_screen.dart'; // Importamos la pantalla de crear
import 'track_report_screen.dart';  // Importamos la pantalla de rastrear

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buzón Anónimo RH'),
        backgroundColor: Colors.indigo, // Color serio corporativo
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.security, size: 80, color: Colors.indigo),
              const SizedBox(height: 20),
              const Text(
                'Tu espacio seguro y confidencial.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              
              // Botón 1: Crear Reporte
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreateReportScreen()),
                    );
                  },
                  icon: const Icon(Icons.add_comment),
                  label: const Text('CREAR NUEVO REPORTE'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo, 
                    foregroundColor: Colors.white
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Botón 2: Consultar Folio (YA CONECTADO)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TrackReportScreen()),
                    );
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('YA TENGO UN FOLIO'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}