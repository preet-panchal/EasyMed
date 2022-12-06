import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reminder/view/google_sign_in.dart';
import 'package:reminder/view/reminder_list.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
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
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              height: 300,
              width: 300,
            ),
            const Text(""),
            const Text(""),
            const Text(""),
            const Text(""),
            const Text(""),
            const Text(""),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
              icon: const FaIcon(
                FontAwesomeIcons.google,
                color: Colors.white,
              ),
              label: const Text("Login with Google"),
            ),
            const Text(""),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReminderList()));
              },
              child: const Text("Login as Guest"),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> showLoginWidget() async {
    var login = await Navigator.pushNamed(context, '/login');
  }
}
