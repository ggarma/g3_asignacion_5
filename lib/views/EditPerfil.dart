import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g3_asignacion_5/components/androidComponents/androidComponent.dart';
import 'package:g3_asignacion_5/components/iosComponents/iosComponent.dart';

import '../api/Services.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final TextEditingController _idController = TextEditingController();

  void updateUser() async {
    if (_nameController.text != "" &&
        _emailController.text != "" &&
        _emailController.text != "" &&
        _idController.text != "") {
      var body = {
        'id': _idController.text,
        'name': _nameController.text,
        'user': _userController.text,
        'email': _emailController.text,
      };
      var responseBody = await updateUserData(body);
      if (responseBody['message'] == "Ok") {
        Navigator.pushReplacementNamed(context, '/home',
            arguments: {'id': _idController.text});
      }
    } else {
      print('No se pudo obtener el usuario después de iniciar sesión.');
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print('Error al cerrar sesión: $e');
      // Aquí puedes manejar el error si ocurre algún problema al cerrar sesión.
    }
  }

  Future<dynamic> getData() async {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    var user = await getUser(arguments!['id'].toString());
    _idController.text = user['id'].toString();

    return user;
  }

  void updatePassword() async {
    if (_oldPasswordController.text != "" &&
        _newPasswordController.text != "" &&
        _repeatPasswordController.text != "") {
      if (_newPasswordController.text == _repeatPasswordController.text) {
        var body = {
          'id': _idController.text,
          'password': _newPasswordController.text,
        };
        var responseBody = await updateUserPassword(body);
        if (responseBody['message'] == "Ok") {
          Navigator.pushReplacementNamed(context, '/home',
              arguments: {'id': _idController.text});
        }
      } else {
        print('Las contraseñas no coinciden.');
      }
    } else {
      print('No se pudo obtener el usuario después de iniciar sesión.');
    }
  }

  // ignore: non_constant_identifier_names
  void Modal(
      BuildContext context,
      TextEditingController oldPasswordController,
      TextEditingController newPasswordController,
      TextEditingController repeatPasswordController) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
            child: SizedBox(
                height: 400,
                child: Container(
                    margin: const EdgeInsets.only(left: 50, right: 50),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Cambiar Contraseña",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center),
                          const SizedBox(height: 20),
                          Platform.isAndroid
                              ? AndroidTextField(
                                  'Contraseña Antigua', oldPasswordController)
                              : IOSTextField(
                                  'Contraseña Antigua', oldPasswordController),
                          Platform.isAndroid
                              ? AndroidTextField(
                                  'Contraseña Nueva', newPasswordController)
                              : IOSTextField(
                                  'Contraseña Nueva', newPasswordController),
                          Platform.isAndroid
                              ? AndroidTextField('Repetir Contraseña Nueva',
                                  repeatPasswordController)
                              : IOSTextField('Repetir Contraseña Nueva',
                                  repeatPasswordController),
                          const SizedBox(height: 20),
                          Platform.isAndroid
                              ? SizedBox(
                                  width: 333,
                                  child: AndroidButton(
                                      const Text("ACTUALIZAR CONTRASEÑA"), () {
                                    updatePassword();
                                  }, const Color.fromARGB(255, 255, 140, 0),
                                      const Color.fromARGB(255, 0, 0, 0)))
                              : Container(
                                  width: 333,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: IOSButton(
                                    const Text("ACTUALIZAR CONTRASEÑA"),
                                    () {
                                      updatePassword();
                                    },
                                    const Color.fromARGB(255, 255, 140, 0),
                                  ),
                                ),
                        ],
                      ),
                    ))));
      },
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFF7F2A),
          actions: [
            InkWell(
              child: Row(
                children: [
                  Text(
                    "Cerrar Sesión",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              onTap: () {
                signOut();
              },
            )
          ],
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return SingleChildScrollView(
                    child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(left: 50, right: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Editar Perfil",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center),
                      const SizedBox(height: 40),
                      SizedBox(
                          width: 200,
                          height: 200,
                          child: CircleAvatar(
                              backgroundImage: Image.network(
                            snapshot.data['image_url'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset('assets/user_default.png',
                                  fit: BoxFit.cover);
                            },
                          ).image)),
                      const SizedBox(height: 20),
                      Platform.isAndroid
                          ? AndroidTextField(
                              'Nombre',
                              _nameController = TextEditingController(
                                  text: snapshot.data['name']))
                          : IOSTextField(
                              'Nombre',
                              _nameController = TextEditingController(
                                  text: snapshot.data['name'])),
                      Platform.isAndroid
                          ? AndroidTextField(
                              'Usuario',
                              _userController = TextEditingController(
                                  text: snapshot.data['user']))
                          : IOSTextField(
                              'Usuario',
                              _userController = TextEditingController(
                                  text: snapshot.data['user'])),
                      Platform.isAndroid
                          ? AndroidTextField(
                              'Correo',
                              _emailController = TextEditingController(
                                  text: snapshot.data['email']))
                          : IOSTextField(
                              'Correo',
                              _emailController = TextEditingController(
                                  text: snapshot.data['email'])),
                      const SizedBox(height: 15),
                      Platform.isAndroid
                          ? SizedBox(
                              width: 333,
                              child: AndroidButton(
                                  const Text("ACTUALIZAR DATOS"), () {
                                updateUser();
                              }, const Color.fromARGB(255, 255, 140, 0),
                                  const Color.fromARGB(255, 0, 0, 0)))
                          : Container(
                              width: 333,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: IOSButton(
                                const Text("ACTUALIZAR DATOS"),
                                () {
                                  updateUser();
                                },
                                const Color.fromARGB(255, 255, 140, 0),
                              ),
                            ),
                      Platform.isAndroid
                          ? SizedBox(
                              width: 333,
                              child: AndroidButton(
                                  const Text("ACTUALIZAR CONTRASEÑA"), () {
                                Modal(
                                    context,
                                    _oldPasswordController,
                                    _newPasswordController,
                                    _repeatPasswordController);
                              }, const Color.fromARGB(255, 255, 140, 0),
                                  const Color.fromARGB(255, 0, 0, 0)))
                          : Container(
                              width: 333,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: IOSButton(
                                const Text("ACTUALIZAR CONTRASEÑA"),
                                () {
                                  Modal(
                                      context,
                                      _oldPasswordController,
                                      _newPasswordController,
                                      _repeatPasswordController);
                                },
                                const Color.fromARGB(255, 255, 140, 0),
                              ),
                            ),
                    ],
                  ),
                ));
              }
            }));
  }
}
