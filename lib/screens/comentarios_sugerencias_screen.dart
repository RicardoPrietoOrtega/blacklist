import 'package:flutter/material.dart';

class ComentariosSugerenciasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Comentarios y Sugerencias'),
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
                  'Envía tus Comentarios y Sugerencias',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ListTile(
                  title: Text('Deja tu Comentario'),
                  subtitle:
                      Text('Comparte tu opinión sobre nuestra aplicación'),
                  trailing: IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: () {
                      // Implementa la lógica para abrir un formulario de comentarios
                    },
                  ),
                ),
                ListTile(
                  title: Text('Envía Sugerencias'),
                  subtitle:
                      Text('Ayúdanos a mejorar, ¡queremos saber tus ideas!'),
                  trailing: IconButton(
                    icon: const Icon(Icons.lightbulb),
                    onPressed: () {
                      // Implementa la lógica para abrir un formulario de sugerencias
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implementa la lógica para enviar comentarios y sugerencias
                    Navigator.pop(context);
                  },
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
