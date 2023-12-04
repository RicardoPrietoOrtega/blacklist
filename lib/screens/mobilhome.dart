import 'package:blacklist/screens/bloqueador_por_serie_numerica.dart';
import 'package:blacklist/screens/configuracion_screen.dart';
import 'package:blacklist/screens/report_form.dart';
import 'package:blacklist/screens/user_profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

List<String> titles = <String>[
  'Bloqueados',
  'Telefonos',
];

class MobilHome extends StatelessWidget {
  const MobilHome({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.grey, useMaterial3: false),
      home: const AppBarExample(),
    );
  }
}

class AppBarExample extends StatelessWidget {
  const AppBarExample({Key? key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.secondary.withOpacity(1);
    final Color evenItemColor = colorScheme.secondary.withOpacity(0.75);
    const int tabsCount = 2;

    return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        appBar: AppBar(
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          scrolledUnderElevation: 4,
          backgroundColor: Colors.black,
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: const Icon(Icons.shield),
                text: titles[0],
              ),
              Tab(
                icon: const Icon(Icons.phone),
                text: titles[1],
              ),
            ],
          ),
        ),
        drawer: const CajonLateral(),
        body: TabBarView(
          children: <Widget>[
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text('${titles[0]} $index',
                      style: const TextStyle(color: Colors.white)),
                );
              },
            ),
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text('${titles[1]} $index',
                      style: const TextStyle(color: Colors.white)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CajonLateral extends StatelessWidget {
  const CajonLateral({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          FutureBuilder<User?>(
            future: FirebaseAuth.instance.authStateChanges().first,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                User? user = snapshot.data;
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user?.uid)
                      .get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic>? userData =
                          userSnapshot.data?.data() as Map<String, dynamic>?;

                      return TarjetaDePresentacion(userData: userData);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Perfil de usuario'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserProfilePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_call),
            title: const Text('Agregar reporte'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ReportForm()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.app_registration_rounded),
            title: const Text('Bloquear por serie numerica'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BloquearNumeroScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuraciones'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfiguracionScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TarjetaDePresentacion extends StatelessWidget {
  final Map<String, dynamic>? userData;

  const TarjetaDePresentacion({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.amber,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleAvatar(
              radius: 36,
              backgroundImage: NetworkImage(userData?['profileImageUrl']),
              backgroundColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              "${userData?['name'] ?? 'Nombre'} ${userData?['lastName'] ?? 'Apellido'}",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Teléfono: ${userData?['phone'] ?? 'No disponible'}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
