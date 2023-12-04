import 'package:blacklist/firebase_options.dart';
import 'package:blacklist/screens/login-register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool _isFirebaseInitialized;

  @override
  void initState() {
    super.initState();
    _isFirebaseInitialized = false;
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    setState(() {
      _isFirebaseInitialized = true;
    });

    // Después de que Firebase se haya inicializado, navegar a la pantalla principal con una transición
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 120.0),
            child: Center(
              child: SvgPicture.asset(
                'assets/images/LogoSinFondo.svg',
                width: 350.0,
                height: 350.0,
                color: Colors.white,
              ),
            ),
          ),
          if (!_isFirebaseInitialized)
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          else
            const Icon(
              Icons.check,
              color: Colors.green,
              size: 40.0,
            ),
          const SizedBox(height: 20),
          const Text(
            '©Fraudfighter 2023',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
