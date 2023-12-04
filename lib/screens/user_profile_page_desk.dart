import 'dart:typed_data';
import 'package:blacklist/screens/desktophome.dart';
import 'package:http/http.dart' as http;

import 'package:blacklist/screens/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserProfilePageDesk extends StatefulWidget {
  const UserProfilePageDesk({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePageDesk> {
  late User _user;
  late Map<String, dynamic> _userData;
  bool _isLoading = true;
  dynamic _pickedImage;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .get();

      setState(() {
        _userData = userSnapshot.data() as Map<String, dynamic>;
        _isLoading = false;

        // Cargar la foto de perfil si hay una URL disponible
        if (_userData.containsKey('profileImageUrl')) {
          _loadProfileImage(_userData['profileImageUrl']);
        }
      });
    } catch (e) {
      print("Error al cargar datos del usuario: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

// Función para cargar la foto de perfil desde la URL
  void _loadProfileImage(String imageUrl) async {
    try {
      final http.Response response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        setState(() {
          _pickedImage = response.bodyBytes;
        });
      } else {
        print(
            "Error al cargar la imagen de perfil - Código de estado: ${response.statusCode}");
      }
    } catch (e) {
      print("Error al cargar la imagen de perfil: $e");
    }
  }

  Future<void> _pickImage() async {
    try {
      final Uint8List? result = await ImagePickerWeb.getImageAsBytes();

      if (result != null) {
        String imageUrl = await _uploadImageAndGetUrl(result);

        setState(() {
          _pickedImage = result;
          _userData['profileImageUrl'] = imageUrl;
        });

        await _updateImageUrlInFirestore(imageUrl);
      }
    } catch (e) {
      print("Error al seleccionar la imagen: $e");
      // Manejar errores específicos para web y dispositivos móviles
      if (kIsWeb) {
        // Lógica de manejo de errores para web
      } else {
        // Lógica de manejo de errores para dispositivos móviles
      }
    }
  }

  Future<String> _uploadImageAndGetUrl(Uint8List imageBytes) async {
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${_user.uid}_${DateTime.now().millisecondsSinceEpoch}.png');

      final UploadTask uploadTask = storageReference.putData(imageBytes);

      final TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() => null);

      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error al subir la imagen: $e");
      throw e;
    }
  }

  Future<void> _updateImageUrlInFirestore(String imageUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .update({'profileImageUrl': imageUrl});
    } catch (e) {
      print("Error al actualizar la URL en Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const DesktopHome(),
              ),
            );
          },
        ),
        title: const Text('Mi Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditProfilePage()));
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 590),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: _pickedImage != null
                            ? MemoryImage(_pickedImage)
                                as ImageProvider<Object>?
                            : CachedNetworkImageProvider(
                                _userData['profileImageUrl'] ?? ''),
                        backgroundColor: Colors.transparent,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton(
                            backgroundColor: Colors.amber,
                            onPressed: () async {
                              await _pickImage();
                            },
                            child: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_userData['name']} ${_userData['lastName']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _userData['city'] ?? 'Ciudad',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              _userData['state'] ?? 'Estado',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Número de Teléfono:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  _userData['phone'] ?? 'No disponible',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Género:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  _userData['gender'] ?? 'No disponible',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            // Puedes agregar más campos según sea necesario
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
