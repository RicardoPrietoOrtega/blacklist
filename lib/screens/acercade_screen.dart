import 'package:flutter/material.dart';

class AcercaDeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Acerca de la Aplicación'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 450),
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Resumen',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'En la actualidad, la extorsión telefónica se ha convertido en un problema cada vez más común y preocupante. Los delincuentes utilizan números de celular para contactar a sus víctimas, intimidándolas y amenazándolas con consecuencias negativas si no cumplen con sus demandas. Ante esta situación, surge la necesidad de contar con herramientas como la aplicación mencionada, que permitan identificar y alertar sobre estos números sospechosos (Núñez, 2020).',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              Text(
                'Objetivos General y Específicos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Desarrollar una aplicación móvil que identifique llamadas de extorsión telefónica, realice bloqueo y genere una alerta para compartir a los ciudadanos como medida de prevención del delito.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              Text(
                'Metodología',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'La adquisición de información y fuente de datos se empleará mediante investigación bibliográfica, utilizando métodos inductivos - deductivos y técnicas como entrevistas, observación y encuestas (Gómez-Luna, 2024); (Romero Fernández, 2021); (Leyva Vázquez, 2021). El desarrollo del proyecto se basa en la metodología Cascada, que ordena rigurosamente las etapas del ciclo de vida del software (Galindo, García, & Martínez, 2010).',
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
