import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tutorpro/login.dart';
import 'package:tutorpro/profile.dart';
import 'package:tutorpro/tuitions.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _HomeState();
}

class _HomeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Home Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: const NavigationDrawer(),
      body: homebody(),
    );
  }
}

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}
class _NavigationDrawerState extends State<NavigationDrawer> {
  User? user = FirebaseAuth.instance.currentUser;
  String userName = "";
   String? _profileImageUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
 DrawerHeader(
  decoration: BoxDecoration(
    color: Colors.blue,
  ),
  child: StreamBuilder(
    stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(), 
    builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {

      if (!snapshot.hasData) {
        return CircularProgressIndicator();
      }


      var userData = snapshot.data!.data() as Map<String, dynamic>?; // Explicit cast



      return Column(
        children: [

           CircleAvatar(
            backgroundImage: NetworkImage(userData?['profileImageUrl'] ?? ''),
            radius: 40,
          ),

          Text('${userData?['name'] ?? "Name not available"}', 
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold, 
            fontSize: size.width*0.05
          ),
          )
        ],
      );
    },
  ),
),









          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Navigate to Home page
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              // Navigate to Profile page
              Navigator.push(context, MaterialPageRoute(builder: (context)=> profile()));
              // Implement navigation to profile page here
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              // Implement logout functionality here
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => login(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


class homebody extends StatefulWidget {
  const homebody({super.key});

  @override
  State<homebody> createState() => _homebodyState();
}

class _homebodyState extends State<homebody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: size.height*0.03,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[ 
                  Text("Welcome to ", style: TextStyle(
                  color: Colors.green, 
                  fontWeight: FontWeight.bold, 
                  fontSize: size.width*0.08        
                  ),),
                  Text("Tutorpro ", style: TextStyle(
                  color: Colors.black, 
                  fontWeight: FontWeight.bold, 
                  fontSize: size.width*0.15        
                  ),),
                  ]
              ), 
        
              SizedBox(height: size.height*0.03,), 
        
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> tuitionsPage()));
                    },
                    child: Container(
                      width: size.width*0.45,
                      height: size.height*0.20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), 
                        color: Colors.orange
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Icon(
                               Icons.search, // You can replace this with your desired icon
                               color: Colors.white, // Icon color
                              ),
                              Text("Search your Tuitions", style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                    ),
                  ), 
                
                  SizedBox(width: size.width*0.05,), 
        
        
                   GestureDetector(
                    onTap: (){},
                    child: Container(
                      width: size.width*0.45,
                      height: size.height*0.20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), 
                        color: Colors.green
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Icon(
                               Icons.info, // You can replace this with your desired icon
                               color: Colors.white, // Icon color
                              ),
                              Text("About Us", style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                    ),
                  ), 
                
                ],
              ), 
        
              SizedBox(height: size.height*0.05,), 
        
        
                 Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      width: size.width*0.45,
                      height: size.height*0.20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), 
                        color: Colors.blue
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Icon(
                               Icons.lightbulb_outline, // You can replace this with your desired icon
                               color: Colors.white, // Icon color
                              ),
                              Text("Tips & Guideline", style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                    ),
                  ), 
                
                  SizedBox(width: size.width*0.05,), 
        
        
                   GestureDetector(
                    onTap: (){},
                    child: Container(
                      width: size.width*0.45,
                      height: size.height*0.20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), 
                        color: Colors.purple
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Icon(
                               Icons.description, // You can replace this with your desired icon
                               color: Colors.white, // Icon color
                              ),
                              Text("Terms & Conditions", style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                    ),
                  ), 
                
                ],
              ), 
        
        
            ],
          ),
        ),
      )
      );
  }
}