import 'package:flutter/material.dart';

class FollowerView extends StatefulWidget {
  final List<dynamic> followers;

  const FollowerView({super.key, required this.followers});

  @override
  State<FollowerView> createState() => _FollowerViewState(this.followers);
}

class _FollowerViewState extends State<FollowerView> {
  List<dynamic> followers;

  _FollowerViewState(this.followers);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: followers.length,
        itemBuilder: (context, index) {
          final item = followers[index];
          return Column(children: [
            ListTile(
              title:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white)),
                  child: Image.network(
                    item['image_url'],
                    fit: BoxFit.cover,
                  ),
                  clipBehavior: Clip.hardEdge,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    item['user'],
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    item['name'],
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 14),
                  ),
                ]),
              ]),
              onTap: () {
                Navigator.pushNamed(context, '/home',
                    arguments: {'id': item['id']});
              },
            ),
            Divider(
              thickness: 1,
              height: 5,
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
            ),
          ]);
        },
      ),
    );
  }
}
