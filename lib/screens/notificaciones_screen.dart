import 'package:flutter/material.dart';

class NotificacionesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Configuración de Notificaciones'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 450),
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Preferencias de Notificaciones',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text('Notificaciones Push'),
                subtitle: Text('Recibir notificaciones en tiempo real'),
                trailing: Switch(
                  value:
                      true, // Valor de ejemplo, debes obtener el valor real de tu lógica de notificaciones
                  onChanged: (bool value) {
                    // Implementa la lógica para cambiar la preferencia de notificaciones
                  },
                ),
              ),
              ListTile(
                title: Text('Sonido'),
                subtitle: Text('Activar sonido para notificaciones'),
                trailing: Switch(
                  value:
                      true, // Valor de ejemplo, debes obtener el valor real de tu lógica de sonido
                  onChanged: (bool value) {
                    // Implementa la lógica para cambiar la preferencia de sonido
                  },
                ),
              ),
              ListTile(
                title: Text('Vibración'),
                subtitle: Text('Activar vibración para notificaciones'),
                trailing: Switch(
                  value:
                      true, // Valor de ejemplo, debes obtener el valor real de tu lógica de vibración
                  onChanged: (bool value) {
                    // Implementa la lógica para cambiar la preferencia de vibración
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implementa la lógica para guardar las preferencias de notificaciones
                  Navigator.pop(context);
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
