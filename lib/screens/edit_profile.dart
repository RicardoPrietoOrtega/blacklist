import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late User _user;
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _phoneController;
  String _selectedGender = 'Hombre';

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _phoneController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .get();

    final userData = userSnapshot.data() as Map<String, dynamic>;

    setState(() {
      _nameController.text = userData['name'] ?? '';
      _lastNameController.text = userData['lastName'] ?? '';
      _cityController.text = userData['city'] ?? '';
      _stateController.text = userData['state'] ?? '';
      _phoneController.text = userData['phone'] ?? '';
      _selectedGender = userData['gender'] ?? 'Hombre';
    });
  }

  Future<void> _saveChanges() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .update({
        'name': _nameController.text,
        'lastName': _lastNameController.text,
        'city': _cityController.text,
        'state': _stateController.text,
        'phone': _phoneController.text,
        'gender': _selectedGender,
      });

      // Mostrar mensaje de cambios guardados exitosamente
      _showSaveSuccess();
    } catch (e) {
      print("Error al guardar los cambios: $e");
      // Mostrar mensaje de error
      _showSaveError();
    }
  }

  void _showSaveSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cambios Guardados'),
          content: const Text('Tus cambios han sido guardados exitosamente.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar la pantalla de edición
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _showSaveError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error al Guardar'),
          content: const Text('Hubo un error al intentar guardar los cambios.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Editar Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white
              ),
              constraints: const BoxConstraints(maxWidth: 500),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nombre'),
                    TextField(controller: _nameController),
                    const SizedBox(height: 10),
                    const Text('Apellidos'),
                    TextField(controller: _lastNameController),
                    const SizedBox(height: 10),
                    const Text('Ciudad'),
                    TextField(controller: _cityController),
                    const SizedBox(height: 10),
                    const Text('Estado'),
                    TextField(controller: _stateController),
                    const SizedBox(height: 10),
                    const Text('Número de Teléfono'),
                    TextField(controller: _phoneController),
                    const SizedBox(height: 10),
                    const Text('Género'),
                    DropdownButton<String>(
                      value: _selectedGender,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue!;
                        });
                      },
                      items: <String>['Hombre', 'Mujer']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
