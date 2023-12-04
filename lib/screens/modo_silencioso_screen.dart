import 'package:flutter/material.dart';

class ModoSilenciosoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Modo Silencioso'),
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
                  'Configuración del Modo Silencioso',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                ListTile(
                  title: Text('Activar Modo Silencioso'),
                  subtitle: Text(
                    'El Modo Silencioso desactivará los sonidos de notificaciones',
                  ),
                  trailing: Switch(
                    value: true, // Tu lógica para activar/desactivar el Modo Silencioso
                    onChanged: (bool value) {
                      // Tu lógica para cambiar el estado del Modo Silencioso
                    },
                  ),
                ),
                ListTile(
                  title: Text('Establecer temporizador'),
                  subtitle: Text(
                    'Configurar un temporizador para el Modo Silencioso',
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.timer),
                    onPressed: () {
                      // Tu lógica para establecer un temporizador
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Tu lógica para guardar la configuración del Modo Silencioso
                    Navigator.pop(context);
                  },
                  child: Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
