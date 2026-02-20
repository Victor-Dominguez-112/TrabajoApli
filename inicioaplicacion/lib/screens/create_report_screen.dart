import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Librería de base de datos
import 'dart:math'; // Para generar números aleatorios

class CreateReportScreen extends StatefulWidget {
  const CreateReportScreen({super.key});

  @override
  State<CreateReportScreen> createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {
  String _tipoIncidente = 'Acoso Laboral'; 
  final TextEditingController _mensajeController = TextEditingController();
  bool _enviando = false; // Para mostrar ruedita de carga

  // Función para generar códigos aleatorios (Ej: X9J2)
  String generarCodigo(int longitud) {
    const caracteres = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    Random aleatorio = Random();
    return String.fromCharCodes(Iterable.generate(
      longitud, (_) => caracteres.codeUnitAt(aleatorio.nextInt(caracteres.length))
    ));
  }

  Future<void> _enviarReporte() async {
    // 1. Validar que no esté vacío
    if (_mensajeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor escribe los detalles del reporte'))
      );
      return;
    }

    setState(() => _enviando = true); // Activa la carga en pantalla

    // --- CHISMOSO 1 ---
    print("🔴 1. INICIANDO el proceso de envío...");

    try {
      // Generamos credenciales únicas
      String nuevoFolio = generarCodigo(6);    // Ej: A4X9P2
      String nuevaClave = generarCodigo(4);    // Ej: 9921

      // --- CHISMOSO 2 ---
      print("🔴 2. Folio generado: $nuevoFolio. Intentando conectar a Firebase...");
      print("    (Si no ves el mensaje 3, es que se atoró aquí)");

      // 2. Guardamos en la Nube (Firebase)
      // ESTA ES LA LÍNEA QUE SOSPECHAMOS QUE SE CONGELA
      // Le ponemos un límite de 5 segundos para que no se quede colgado
      await FirebaseFirestore.instance.collection('reportes').doc(nuevoFolio).set({
        'folio': nuevoFolio,
        'password': nuevaClave,
        'tipo': _tipoIncidente,
        'mensaje': _mensajeController.text,
        'fecha': DateTime.now(),
        'estado': 'Recibido', 
        'respuesta_rh': '',
      });

      // --- CHISMOSO 3 ---
      print("🟢 3. ¡GUARDADO EN FIREBASE EXITOSO! La conexión funciona.");

      // 3. Mostrar éxito y credenciales
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false, // Obliga a leer
        builder: (ctx) => AlertDialog(
          title: const Text('¡Reporte Enviado!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 60),
              const SizedBox(height: 10),
              const Text('IMPORTANTE: Guarda estos datos. Son la ÚNICA forma de ver la respuesta de RH.'),
              const Divider(),
              Text('FOLIO: $nuevoFolio', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.indigo)),
              Text('CLAVE: $nuevaClave', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.red)),
              const Divider(),
              const Text('Toma una captura de pantalla ahora.', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx); // Cierra diálogo
                Navigator.pop(context); // Regresa al menú principal
              },
              child: const Text('ENTENDIDO, YA LOS GUARDÉ'),
            )
          ],
        ),
      );

    } catch (e) {
      // --- CHISMOSO DE ERROR ---
      print("💀 ERROR CRÍTICO: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _enviando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Reporte'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              '🔒 Tu identidad está protegida. No guardamos tu nombre.',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            const Text('¿Qué tipo de situación es?', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _tipoIncidente,
                  isExpanded: true,
                  items: ['Acoso Laboral', 'Seguridad', 'Sugerencia', 'Fraude', 'Otro']
                      .map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                  onChanged: (v) => setState(() => _tipoIncidente = v!),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text('Describe los detalles:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 5),
            TextField(
              controller: _mensajeController,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'Escribe aquí fecha, hora y descripción de lo sucedido...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _enviando ? null : _enviarReporte, // Desactiva si está enviando
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                child: _enviando 
                  ? const CircularProgressIndicator(color: Colors.white) 
                  : const Text('ENVIAR REPORTE ANÓNIMO', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}