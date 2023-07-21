import 'package:flutter/material.dart';
import 'package:g3_asignacion_5/views/tabs/FollowerView.dart';
import 'package:g3_asignacion_5/views/tabs/FollowingsView.dart';

import '../api/Services.dart';

class FollowView extends StatefulWidget {
  const FollowView({super.key});

  @override
  State<FollowView> createState() => _FollowViewState();
}

class _FollowViewState extends State<FollowView> with TickerProviderStateMixin {
  late final TabController _tabController;
  late Map<String, dynamic> data = {};

  void initializeController(int index) {
    setState(() {
      _tabController =
          TabController(length: 2, vsync: this, initialIndex: index);
    });
  }

  Future<dynamic> getData(dynamic id, dynamic user_name) async {
    List<dynamic> followings = await getUserFollowings(id.toString());
    List<dynamic> followers = await getUserFollowers(id.toString());

    setState(() {
      data = {
        'name': user_name,
        'followers': followers,
        'followings': followings
      };
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      final Map<String, dynamic>? arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      initializeController(arguments?['index']);
      await getData(arguments?['id'], arguments?['user_name']);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.isNotEmpty ? data['name'] : ''),
        backgroundColor: Color(0xFFFF7F2A),
      ),
      body: data.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(children: [
              TabBar(
                  controller: _tabController,
                  labelColor: MediaQuery.of(context).platformBrightness ==
                          Brightness.light
                      ? Colors.black
                      : Colors.white,
                  tabs: <Widget>[
                    Tab(
                      text: 'seguidores',
                    ),
                    Tab(
                      text: 'seguidos',
                    ),
                  ]),
              Expanded(
                child:
                    TabBarView(controller: _tabController, children: <Widget>[
                  FollowerView(followers: data['followers']),
                  FollowingView(followings: data['followings'])
                ]),
              ),
            ]),
    );
  }
}
