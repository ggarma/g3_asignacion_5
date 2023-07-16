import 'package:flutter/material.dart';

class FollowingView extends StatefulWidget {
  final List<dynamic> followings;
  const FollowingView({super.key, required this.followings});

  @override
  State<FollowingView> createState() => _FollowingViewState(this.followings);
}

class _FollowingViewState extends State<FollowingView> {
  List<dynamic> followings;
  _FollowingViewState(this.followings);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: followings.length,
        itemBuilder: (context, index) {
          final item = followings[index];
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
              onTap: () {},
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
