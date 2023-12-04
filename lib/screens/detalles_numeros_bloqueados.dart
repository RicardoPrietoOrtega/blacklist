import 'package:flutter/material.dart';

class DetallesNumeroBloqueado extends StatelessWidget {
  final String numero;
  final DateTime fechaHora;
  final String detalleLlamada;
  final String accionesTomadas;

  const DetallesNumeroBloqueado({
    required this.numero,
    required this.fechaHora,
    required this.detalleLlamada,
    required this.accionesTomadas,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Detalles del Número Bloqueado'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DetalleItem(titulo: 'Número de Teléfono', contenido: numero),
                  DetalleItem(
                      titulo: 'Fecha y Hora',
                      contenido: '${fechaHora.toLocal()}'),
                  DetalleItem(
                      titulo: 'Detalle de la Llamada', contenido: detalleLlamada),
                  DetalleItem(
                      titulo: 'Acciones Tomadas', contenido: accionesTomadas),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DetalleItem extends StatelessWidget {
  final String titulo;
  final String contenido;

  const DetalleItem({
    required this.titulo,
    required this.contenido,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          titulo,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 4),
        Text(
          contenido,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DetallesNumeroBloqueado(
      numero: 'Número Bloqueado',
      fechaHora: DateTime.now(),
      detalleLlamada: 'Detalle de la llamada',
      accionesTomadas: 'Acciones tomadas',
    ),
  ));
}
