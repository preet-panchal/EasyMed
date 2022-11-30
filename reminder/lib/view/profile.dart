import 'package:flutter/material.dart';
import 'package:reminder/view/home_page.dart';
import 'package:reminder/view/reminder_list.dart';
import 'package:reminder/view/search.dart';
import 'package:reminder/view/search_table.dart';
import 'package:reminder/view/user.dart';
import 'package:reminder/view/user_info.dart';
import 'package:reminder/view/profile_widget.dart';

import 'package:reminder/main.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = UserInfo.myUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('My Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SearchTable())
              );
            },
            icon: Icon(Icons.search),
          ),

          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ReminderList()));
            },
            icon: Icon(Icons.home),
          ),

          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildProfile(user),
        ],
      ),
    );
  }

  Widget buildProfile(User user) =>
      Column(
        children: [
          Text(
            user.fullName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 16),
          Text(
            user.dateOfBirth,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 16),
          Text(
            user.email,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 16),
          Text(
            user.phone,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 16),
          Text(
            user.healthID,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ],
      );
}
