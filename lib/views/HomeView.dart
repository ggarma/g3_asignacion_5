import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g3_asignacion_5/api/Services.dart';
import 'package:g3_asignacion_5/components/androidComponents/androidComponent.dart';
import 'package:g3_asignacion_5/components/iosComponents/iosComponent.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<dynamic> getData() async {
    var user = await getUser('1');
    List<dynamic> posts = await getUserPosts('1');
    List<dynamic> followings = await getUserFollowings('1');
    List<dynamic> followers = await getUserFollowers('1');

    var response = {
      'id': user['id'],
      'name': user['name'],
      'image_url': user['image_url'],
      'followers': followers.length,
      'followings': followings.length,
      'posts': posts
          .map(
            (e) => Container(
              height: 140,
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
                          Column(
                            children: [
                              Container(
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
                                child: Image.network(snapshot.data['image_url'],
                                    fit: BoxFit.cover),
                                clipBehavior: Clip.hardEdge,
                              ),
                            ],
                          ),
                          Container(
                            width: 80,
                            margin: EdgeInsets.only(left: 10, right: 5),
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
                                  });
                            },
                            child: Container(
                              width: 80,
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
                                  });
                            },
                            child: Container(
                              width: 78,
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
                      Text(
                        snapshot.data['name'],
                        style: TextStyle(overflow: TextOverflow.visible),
                      ),
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
                                          fontSize: 17, color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    () {},
                                    Color(0xFFFF7F2A))
                                : IOSButton(
                                    Text(
                                      'Editar Perfil',
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
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
                                    Color(0xFFFF7F2A))
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
                                      color: Colors.white,
                                    ),
                                    () {},
                                    Color(0xFFFF7F2A))
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
                          Text(
                            "Historias destacadas",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Guarda tus historias favoritas en el perfil"),
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
                          )
                        ],
                      ),
                    ],
                  )),
                );
              }
            }));
  }
}
