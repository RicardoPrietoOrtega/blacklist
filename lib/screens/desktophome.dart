import 'package:blacklist/screens/bloqueador_por_serie_numerica.dart';
import 'package:blacklist/screens/configuracion_screen.dart';
import 'package:blacklist/screens/report_form.dart';
import 'package:blacklist/screens/user_profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

List<String> titles = ['Bloqueados', 'Telefonos'];

class DesktopHome extends StatelessWidget {
  const DesktopHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.grey[200], useMaterial3: false),
      home: const AppBarExample(),
    );
  }
}

class AppBarExample extends StatelessWidget {
  const AppBarExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: titles.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(74.0), // Ajusta este valor según tus necesidades
          child: AppBar(
            notificationPredicate: (ScrollNotification notification) {
              return notification.depth == 1;
            },
            scrolledUnderElevation: 4,
            backgroundColor: Colors.black87,
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
        ),
        body: Row(
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 350),
              child: const CajonLateral(),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  ListView.builder(
                    itemCount: 25,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        tileColor:
                            index.isOdd ? Colors.grey[300] : Colors.grey[200],
                        title: Text(
                          '${titles[0]} $index',
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: 25,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        tileColor:
                            index.isOdd ? Colors.grey[300] : Colors.grey[200],
                        title: Text(
                          '${titles[1]} $index',
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class CajonLateral extends StatelessWidget {
  const CajonLateral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder<User?>(
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

                  return ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                  userData?['profileImageUrl'] ??
                                      'https://via.placeholder.com/150',
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "${userData?['name'] ?? 'Nombre'} ${userData?['lastName'] ?? 'Apellido'}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Teléfono: ${userData?['phone'] ?? 'No disponible'}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.account_circle),
                        title: const Text('Perfil de usuario'),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return UserProfilePage();
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.add_call),
                        title: const Text('Agregar reporte'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReportForm(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.app_registration_rounded),
                        title: const Text('Bloquear por serie numerica'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BloquearNumeroScreen(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text('Configuraciones'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfiguracionScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  );
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
    );
  }
}
