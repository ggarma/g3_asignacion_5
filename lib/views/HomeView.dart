import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g3_asignacion_5/components/androidComponents/androidComponent.dart';
import 'package:g3_asignacion_5/components/iosComponents/iosComponent.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late List list = [
    'https://repository-images.githubusercontent.com/260096455/47f1b200-8b2e-11ea-8fa1-ab106189aeb0',
    'https://www.doubledtrailers.com/assets/images/random%20horse%20facts%20shareable.png',
    'https://lh3.googleusercontent.com/hwau7OVWx96XaME5KpRuJ0I_MscrerK6SbRH1UwYHYaxIDQQtn7RZK02LDSfBzCreidFgDsJeXyqDct6EZiH6vsV=w640-h400-e365-rj-sc0x00ffffff',
    'https://repository-images.githubusercontent.com/260096455/47f1b200-8b2e-11ea-8fa1-ab106189aeb0',
    'https://www.doubledtrailers.com/assets/images/random%20horse%20facts%20shareable.png',
    'https://lh3.googleusercontent.com/hwau7OVWx96XaME5KpRuJ0I_MscrerK6SbRH1UwYHYaxIDQQtn7RZK02LDSfBzCreidFgDsJeXyqDct6EZiH6vsV=w640-h400-e365-rj-sc0x00ffffff',
    'https://repository-images.githubusercontent.com/260096455/47f1b200-8b2e-11ea-8fa1-ab106189aeb0',
    'https://www.doubledtrailers.com/assets/images/random%20horse%20facts%20shareable.png',
    'https://lh3.googleusercontent.com/hwau7OVWx96XaME5KpRuJ0I_MscrerK6SbRH1UwYHYaxIDQQtn7RZK02LDSfBzCreidFgDsJeXyqDct6EZiH6vsV=w640-h400-e365-rj-sc0x00ffffff',
    'https://repository-images.githubusercontent.com/260096455/47f1b200-8b2e-11ea-8fa1-ab106189aeb0',
    'https://www.doubledtrailers.com/assets/images/random%20horse%20facts%20shareable.png',
    'https://lh3.googleusercontent.com/hwau7OVWx96XaME5KpRuJ0I_MscrerK6SbRH1UwYHYaxIDQQtn7RZK02LDSfBzCreidFgDsJeXyqDct6EZiH6vsV=w640-h400-e365-rj-sc0x00ffffff',
    'https://repository-images.githubusercontent.com/260096455/47f1b200-8b2e-11ea-8fa1-ab106189aeb0',
    'https://www.doubledtrailers.com/assets/images/random%20horse%20facts%20shareable.png',
    'https://lh3.googleusercontent.com/hwau7OVWx96XaME5KpRuJ0I_MscrerK6SbRH1UwYHYaxIDQQtn7RZK02LDSfBzCreidFgDsJeXyqDct6EZiH6vsV=w640-h400-e365-rj-sc0x00ffffff',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Image.network(
                          'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
                          fit: BoxFit.cover),
                      clipBehavior: Clip.hardEdge,
                    ),
                    Text('Roberto Robotin'),
                  ],
                ),
                Container(
                  width: 80,
                  margin: EdgeInsets.only(left: 10, right: 5),
                  child: Column(
                    children: [
                      Text(
                        '20',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Publicaciones',
                        style: TextStyle(
                            fontSize: 17, overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 80,
                    margin: EdgeInsets.only(right: 5),
                    child: Column(
                      children: [
                        Text(
                          '20',
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
                  onTap: () {},
                  child: Container(
                    width: 78,
                    child: Column(
                      children: [
                        Text(
                          '20',
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
                            style: TextStyle(fontSize: 17, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          () {},
                          Color(0xFFFF7F2A))
                      : IOSButton(
                          Text(
                            'Editar Perfil',
                            style: TextStyle(fontSize: 17, color: Colors.white),
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
                            style: TextStyle(fontSize: 16, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          () {},
                          Color(0xFFFF7F2A))
                      : IOSButton(
                          Text(
                            'Compartir Perfil',
                            style: TextStyle(fontSize: 16, color: Colors.white),
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    shrinkWrap: true,
                    children: list
                        .map(
                          (e) => Container(
                            height: 140,
                            width: 100,
                            child: Image.network(
                              e,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                        .toList())
              ],
            ),
          ],
        )),
      ),
    );
  }
}
