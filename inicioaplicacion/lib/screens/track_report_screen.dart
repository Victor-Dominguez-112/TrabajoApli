import 'package:flutter/material.dart';

class TrackReportScreen extends StatefulWidget {
  const TrackReportScreen({super.key});

  @override
  State<TrackReportScreen> createState() => _TrackReportScreenState();
}

class _TrackReportScreenState extends State<TrackReportScreen> {
  final _folioController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultar Estatus'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinea todo a la izquierda
          children: [
            const Text(
              'Ingresa tus credenciales',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Utiliza el Folio y la Clave que se te dieron al crear tu reporte.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // CAMPO FOLIO
            TextField(
              controller: _folioController,
              decoration: const InputDecoration(
                labelText: 'FOLIO DEL REPORTE',
                hintText: 'Ej: X9J-21',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.folder_open),
              ),
            ),
            const SizedBox(height: 20),

            // CAMPO CONTRASEÑA
            TextField(
              controller: _passwordController,
              obscureText: true, // Oculta el texto con puntitos
              decoration: const InputDecoration(
                labelText: 'CLAVE SECRETA',
                hintText: '****',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.vpn_key),
              ),
            ),
            const SizedBox(height: 30),

            // BOTÓN DE BUSCAR
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Buscando en la base de datos... (Pendiente)')),
                  );
                },
                icon: const Icon(Icons.search),
                label: const Text('BUSCAR REPORTE'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}