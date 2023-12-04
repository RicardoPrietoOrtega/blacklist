import 'package:flutter/material.dart';

class BloquearNumeroScreen extends StatefulWidget {
  const BloquearNumeroScreen({Key? key}) : super(key: key);

  @override
  _BloquearNumeroScreenState createState() => _BloquearNumeroScreenState();
}

class _BloquearNumeroScreenState extends State<BloquearNumeroScreen> {
  final numeroController = TextEditingController();
  final List<String> numerosBloqueados = [];

  @override
  void dispose() {
    numeroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Bloquear Número'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 450),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Ingresa los primeros 3 dígitos del número que deseas bloquear:',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: numeroController,
                keyboardType: TextInputType.number,
                maxLength: 3,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Aquí puedes agregar la funcionalidad para bloquear el número
                  setState(() {
                    numerosBloqueados.add(numeroController.text);
                    numeroController.clear();
                  });
                },
                child: const Text('Bloquear Número'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Números bloqueados:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: numerosBloqueados.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        numerosBloqueados[index],
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
