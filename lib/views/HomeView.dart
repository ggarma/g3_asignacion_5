import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:g3_asignacion_5/api/Services.dart';
import 'package:g3_asignacion_5/components/androidComponents/androidComponent.dart';
import 'package:g3_asignacion_5/components/iosComponents/iosComponent.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    var user = await getUser(arguments!['id'].toString());

    List<dynamic> posts = await getUserPosts(user['id'].toString());
    List<dynamic> followings = await getUserFollowings(user['id'].toString());
    List<dynamic> followers = await getUserFollowers(user['id'].toString());

    var response = {
      'id': user['id'],
      'name': user['name'],
      'image_url': user['image_url'],
      'followers': followers.length,
      'followings': followings.length,
      'posts': posts
          .map(
            (e) => Container(
              height: 100,
              width: 100,
              child: Image.network(
                e['image_url'],
                fit: BoxFit.fill,
              ),
            ),
          )
          .toList()
    };
    return response;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Padding(
                  padding: EdgeInsets.only(left: 5, top: 50, right: 5),
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20, right: 10),
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: MediaQuery.of(context)
                                                      .platformBrightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white)),
                                  child: Image.network(
                                      snapshot.data['image_url'],
                                      fit: BoxFit.cover),
                                  clipBehavior: Clip.hardEdge,
                                ),
                                Text(
                                  snapshot.data['name'],
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 60,
                            margin: EdgeInsets.only(left: 5, right: 3),
                            child: Column(
                              children: [
                                Text(
                                  '${snapshot.data['posts'].length}',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Publicaciones',
                                  style: TextStyle(
                                      fontSize: 17,
                                      overflow: TextOverflow.ellipsis),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/follows',
                                  arguments: {
                                    'id': snapshot.data['id'],
                                    'index': 0,
                                    'user_name': snapshot.data['name'],
                                  });
                            },
                            child: Container(
                              width: 60,
                              margin: EdgeInsets.only(right: 5),
                              child: Column(
                                children: [
                                  Text(
                                    '${snapshot.data['followers']}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Seguidores',
                                    style: TextStyle(fontSize: 17),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/follows',
                                  arguments: {
                                    'id': snapshot.data['id'],
                                    'index': 1,
                                    'user_name': snapshot.data['name'],
                                  });
                            },
                            child: Container(
                              width: 60,
                              child: Column(
                                children: [
                                  Text(
                                    '${snapshot.data['followings']}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Seguidos',
                                    style: TextStyle(fontSize: 17),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       left: 30,
                      //       right: 30,
                      //       top: 10), // Ajusta el valor según tu preferencia
                      //   child: Text(
                      //     snapshot.data['name'],
                      //     style: TextStyle(
                      //       fontSize: 17,
                      //       fontWeight: FontWeight.bold,
                      //       overflow: TextOverflow.visible,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 40,
                            width: 130,
                            child: Platform.isAndroid
                                ? AndroidButton(
                                    Text(
                                      'Editar Perfil',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    () {},
                                    Color(0xFFFF7F2A),
                                    Color.fromARGB(255, 0, 0, 0))
                                : IOSButton(
                                    Text(
                                      'Editar Perfil',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    () {},
                                    Color(0xFFFF7F2A)),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 40,
                            width: 130,
                            child: Platform.isAndroid
                                ? AndroidButton(
                                    Text(
                                      'Compartir Perfil',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    () {},
                                    Color(0xFFFF7F2A),
                                    Color.fromARGB(255, 0, 0, 0))
                                : IOSButton(
                                    Text(
                                      'Compartir Perfil',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    () {},
                                    Color(0xFFFF7F2A)),
                          ),
                          Container(
                            height: 40,
                            width: 70,
                            child: Platform.isAndroid
                                ? AndroidButton(
                                    Icon(
                                      Icons.person_add,
                                      color: Colors.black,
                                    ),
                                    () {},
                                    Color(0xFFFF7F2A),
                                    Color.fromARGB(255, 0, 0, 0))
                                : IOSButton(
                                    Icon(
                                      CupertinoIcons.person_add_solid,
                                      color: Colors.white,
                                    ),
                                    () {},
                                    Color(0xFFFF7F2A)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 30,
                                right:
                                    30), // Ajusta el valor según tu preferencia
                            child: Text(
                              "Historias destacadas",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Text(
                          //   "Historias destacadas",
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 30,
                                  right:
                                      30), // Ajusta el valor según tu preferencia
                              child: Text(
                                "Guarda tus historias favoritas en el perfil",
                                style: TextStyle(fontSize: 14),
                              )),
                          Column(children: [
                            IconButton(
                              iconSize: 100,
                              icon: Icon(
                                Platform.isAndroid
                                    ? Icons.add_circle_outline
                                    : CupertinoIcons.add_circled,
                              ),
                              onPressed: () {},
                            ),
                            Text("Nueva")
                          ]),
                          GridView(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                            ),
                            shrinkWrap: true,
                            children: snapshot.data['posts'],
                          ),

                          Platform.isAndroid
                              ? SizedBox(
                                  width: 333,
                                  child: AndroidButton(Text("CERRAR SESIÓN"),
                                      () {
                                    signOut();
                                  }, Color.fromARGB(255, 255, 0, 0),
                                      Color.fromARGB(255, 0, 0, 0)),
                                )
                              : Container(
                                  width: 333,
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: IOSButton(Text("CERRAR SESIÓN"), () {
                                    signOut();
                                  }, Color.fromARGB(255, 255, 0, 0)),
                                ),
                        ],
                      ),
                    ],
                  )),
                );
              }
            }));
  }
}