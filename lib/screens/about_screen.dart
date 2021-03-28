import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:secure_af/widgets/back_navigate.dart';
import 'package:secure_af/constants.dart' as cons;

class AboutScreen extends StatelessWidget {
  final String githubUrl = 'https://github.com/aashu-jha';
  final String linkedInUrl = 'https://www.linkedin.com/in/aashish-jha-8980001b4/';

  static const id = 'about_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [
                          0.2,
                          0.5,
                          0.8
                        ],
                        colors: [
                          Colors.blue,
                          Colors.blueAccent,
                          Colors.lightBlueAccent,
                        ]
                    )
                ),
                height: 350,
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 80),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/me.jpg'),
                    ),
                    SizedBox(height: 10,),
                    Text('@aashu-jha',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Source Sans Pro'
                      ),
                    ),
                    // SizedBox(height: 15,),
                    Text('Flutter Dev',
                      style: TextStyle(
                        color: Colors.teal[100],
                        fontSize: 20.0,
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Source Sans Pro',
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                      width: 150.0,
                      child: Divider(
                        color: Colors.teal.shade100,
                      ),
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: Offset(0, -25),
                child: BackNavigate()
              ),
              ListTile(
                leading: Icon(Icons.person_outline, size: 40,),
                title: Text('Name'),
                subtitle: Text('Aashish Jha'),
              ),
              ListTile(
                leading: Icon(Icons.email, size: 40,),
                title: Text('E-mail'),
                subtitle: Text('aashish2000kumar@gmail.com'),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.github, size: 40,),
                title: Text('GitHub Username'),
                subtitle: Text(githubUrl),
                onTap: () {
                  cons.launchURL(githubUrl, context);
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.linkedin, size: 40,),
                title: Text('LinkedIn'),
                subtitle: Text(linkedInUrl),
                onTap: () {
                  cons.launchURL(linkedInUrl, context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
