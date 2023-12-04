import 'package:flutter/material.dart';

class ListaBlancaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Lista Blanca'),
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
                  'Gestionar Lista Blanca',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                ListTile(
                  title: Text('Agregar a la Lista Blanca'),
                  subtitle:
                      Text('Permitir notificaciones de contactos específicos'),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // Implementa la lógica para agregar contactos a la Lista Blanca
                    },
                  ),
                ),
                ListTile(
                  title: Text('Ver Lista Blanca'),
                  subtitle:
                      Text('Consultar la lista actual de contactos permitidos'),
                  trailing: IconButton(
                    icon: Icon(Icons.list),
                    onPressed: () {
                      // Implementa la lógica para ver la Lista Blanca
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implementa la lógica para guardar la Lista Blanca
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
