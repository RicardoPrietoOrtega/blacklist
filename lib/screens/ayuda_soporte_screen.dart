import 'package:flutter/material.dart';

class AyudaSoporteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Ayuda y Soporte'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 450),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Centro de Ayuda y Soporte',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                ListTile(
                  title: Text('Contactar Soporte Técnico'),
                  subtitle: Text('Envía un mensaje al equipo de soporte técnico'),
                  trailing: IconButton(
                    icon: Icon(Icons.mail),
                    onPressed: () {
                      // Implementa la lógica para abrir un formulario de contacto
                    },
                  ),
                ),
                ListTile(
                  title: Text('Preguntas Frecuentes (FAQ)'),
                  subtitle: Text('Encuentra respuestas a preguntas comunes'),
                  trailing: IconButton(
                    icon: Icon(Icons.help),
                    onPressed: () {
                      // Implementa la lógica para abrir una sección de preguntas frecuentes
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implementa la lógica para navegar a recursos adicionales de ayuda
                    Navigator.pop(context);
                  },
                  child: Text('Recursos Adicionales'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
