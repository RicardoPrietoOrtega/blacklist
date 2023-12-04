import 'package:blacklist/screens/acercade_screen.dart';
import 'package:blacklist/screens/ayuda_soporte_screen.dart';
import 'package:blacklist/screens/comentarios_sugerencias_screen.dart';
import 'package:blacklist/screens/lista_blanca_screen.dart';
import 'package:blacklist/screens/modo_silencioso_screen.dart';
import 'package:blacklist/screens/notificaciones_screen.dart';
import 'package:flutter/material.dart';

class ConfiguracionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Configuraciones'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            constraints: const BoxConstraints(maxWidth: 450),
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              
              children: ListTile.divideTiles(
                context: context,
                tiles: [
                  _buildConfiguracionItem(
                    icon: Icons.notifications,
                    title: 'Configuración de notificaciones',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificacionesScreen(),
                        ),
                      );
                    },
                  ),
                  _buildConfiguracionItem(
                    icon: Icons.do_not_disturb,
                    title: 'Modo silencioso',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ModoSilenciosoScreen(),
                        ),
                      );
                    },
                  ),
                  _buildConfiguracionItem(
                    icon: Icons.list,
                    title: 'Lista blanca',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListaBlancaScreen(),
                        ),
                      );
                    },
                  ),
                  _buildConfiguracionItem(
                    icon: Icons.help,
                    title: 'Ayuda y soporte',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AyudaSoporteScreen(),
                        ),
                      );
                    },
                  ),
                  _buildConfiguracionItem(
                    icon: Icons.feedback,
                    title: 'Comentarios y sugerencias',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComentariosSugerenciasScreen(),
                        ),
                      );
                    },
                  ),
                  _buildConfiguracionItem(
                    icon: Icons.info,
                    title: 'Acerca de',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AcercaDeScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfiguracionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
