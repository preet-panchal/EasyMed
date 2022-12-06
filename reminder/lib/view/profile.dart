import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reminder/view/profile_widget.dart';
import 'package:reminder/view/reminder_list.dart';
import 'NavBar.dart';
import 'search_table.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('My Profile'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchTable()));
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReminderList()));
              },
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Profile()));
              },
              icon: const Icon(Icons.person),
            ),
          ],
          automaticallyImplyLeading: false,
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(height: 24),
                user.photoURL == null
                    ? Text("")
                    : ProfileWidget(
                        imagePath: user.photoURL!,
                        onClicked: () async {},
                      ),
                const SizedBox(height: 24),
                user.displayName == null
                    ? Text("Guest")
                    : TextFormField(
                        enabled: false,
                        readOnly: true,
                        initialValue: user.displayName,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Full name:',
                        ),
                      ),
                user.email == null
                    ? Text("")
                    : TextFormField(
                        enabled: false,
                        readOnly: true,
                        initialValue: user.email,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Email:',
                        ),
                      ),
                user.phoneNumber == null
                    ? Text("")
                    : TextFormField(
                        enabled: false,
                        readOnly: true,
                        initialValue: user.phoneNumber!,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Phone number:',
                        ),
                      ),
                user.displayName == null
                    ? Text("")
                    : TextFormField(
                        enabled: false,
                        readOnly: true,
                        initialValue: "2000-03-10",
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Date of birth:',
                        ),
                      ),
                user.uid == null
                    ? Text("")
                    : TextFormField(
                        enabled: false,
                        readOnly: true,
                        initialValue: user.uid,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Health ID:',
                        ),
                      )
              ],
            )));
  }
}
