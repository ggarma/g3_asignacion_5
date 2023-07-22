import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g3_asignacion_5/components/androidComponents/androidComponent.dart';
import 'package:g3_asignacion_5/components/iosComponents/iosComponent.dart';

import '../api/Services.dart';

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
      return SizedBox(
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
                                const Text("ACTUALIZAR CONTRASEÑA"),
                                () {},
                                const Color.fromARGB(255, 255, 140, 0),
                                const Color.fromARGB(255, 0, 0, 0)))
                        : Container(
                            width: 333,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: IOSButton(
                              const Text("ACTUALIZAR CONTRASEÑA"),
                              () {},
                              const Color.fromARGB(255, 255, 140, 0),
                            ),
                          ),
                  ],
                ),
              )));
    },
  );
}

class EditPerfilView extends StatefulWidget {
  const EditPerfilView({super.key});

  @override
  State<EditPerfilView> createState() => _EditPerfilViewState();
}

class _EditPerfilViewState extends State<EditPerfilView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  Future<dynamic> getData() async {
    // final Map<String, dynamic>? arguments =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    var user = await getUser('1'); //arguments!['id'].toString());

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                      fit: BoxFit.cover)
                                  .image)),
                      const SizedBox(height: 20),
                      Platform.isAndroid
                          ? AndroidTextField('Nombre', _nameController)
                          : IOSTextField('Nombre', _nameController),
                      Platform.isAndroid
                          ? AndroidTextField('Usuario', _userController)
                          : IOSTextField('Usuario', _userController),
                      Platform.isAndroid
                          ? AndroidTextField('Correo', _emailController)
                          : IOSTextField('Correo', _emailController),
                      const SizedBox(height: 15),
                      Platform.isAndroid
                          ? SizedBox(
                              width: 333,
                              child: AndroidButton(
                                  const Text("ACTUALIZAR DATOS"),
                                  () {},
                                  const Color.fromARGB(255, 255, 140, 0),
                                  const Color.fromARGB(255, 0, 0, 0)))
                          : Container(
                              width: 333,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: IOSButton(
                                const Text("ACTUALIZAR DATOS"),
                                () {},
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
