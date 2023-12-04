import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Map<String, dynamic>>> obtenerUsuarios() async {
  try {
    CollectionReference referenciaColeccionUsuarios = db.collection('usuarios');
    QuerySnapshot consultaUsuarios = await referenciaColeccionUsuarios.get();

    return consultaUsuarios.docs.map((doc) {
      String id = doc.id;
      String nombre = doc['nombre'] ?? '';
      return {'id': id, 'nombre': nombre};
    }).toList();
  } catch (e) {
    print("Error al obtener usuarios: $e");
    return [];
  }
}

// Función para agregar un nuevo usuario a la colección
Future<void> agregarUsuario(String nombre) async {
  try {
    CollectionReference referenciaColeccionUsuarios = db.collection('usuarios');
    await referenciaColeccionUsuarios.add({'nombre': nombre});
    print('Usuario agregado correctamente');
  } catch (e) {
    print("Error al agregar usuario: $e");
  }
}

// Función para actualizar la información de un usuario existente
// Definición de la función actualizarUsuarioEnBaseDeDatos
Future<void> actualizarUsuarioEnBaseDeDatos(
    String idUsuario, String nuevoNombre) async {
  try {
    CollectionReference referenciaColeccionUsuarios = db.collection('usuarios');
    await referenciaColeccionUsuarios
        .doc(idUsuario)
        .update({'nombre': nuevoNombre});
    print('Usuario actualizado correctamente');
  } catch (e) {
    print("Error al actualizar usuario en la base de datos: $e");
  }
}

// Función para eliminar un usuario de la colección
Future<void> eliminarUsuario(String id) async {
  try {
    CollectionReference referenciaColeccionUsuarios = db.collection('usuarios');
    await referenciaColeccionUsuarios.doc(id).delete();
    print('Usuario eliminado correctamente');
  } catch (e) {
    print("Error al eliminar usuario: $e");
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<User?> iniciarSesion(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  } catch (e) {
    print("Error al iniciar sesión: $e");
    return null;
  }
}

Future<void> cerrarSesion() async {
  await _auth.signOut();
}

Future<User?> registrarUsuario(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  } catch (e) {
    print("Error al registrar usuario: $e");
    return null;
  }
}
