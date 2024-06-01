import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tutorpro/Admin%20Pages/addtuitions.dart';
import 'package:tutorpro/login.dart';

class admin_home_page extends StatefulWidget {
  const admin_home_page({super.key});

  @override
  State<admin_home_page> createState() => _admin_home_pageState();
}

class _admin_home_pageState extends State<admin_home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Admin Page", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
       iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: navigationDrawer(),
      body: adminHomePage(),
    );
  }
}






class navigationDrawer extends StatefulWidget {
  const navigationDrawer({super.key});

  @override
  State<navigationDrawer> createState() => _navigationDrawerState();
}

class _navigationDrawerState extends State<navigationDrawer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, 
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueGrey),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person),
                ), 
                Text("Admin", style: TextStyle(color: Colors.white, fontSize: size.width*0.06, fontWeight: FontWeight.bold),)
              ],
            )
            ), 
            ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
                await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => login(),
                ),
              );
            },
            )
        ],
        ),
    );
  }
}






class adminHomePage extends StatefulWidget {
  const adminHomePage({super.key});

  @override
  State<adminHomePage> createState() => _adminHomePageState();
}

class _adminHomePageState extends State<adminHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column( 
             children: [

              SizedBox(height: size.height*0.02,), 
              Text("Admin Panel", style: TextStyle(fontSize: size.width*0.1, fontWeight: FontWeight.bold),),
              

              SizedBox(height: size.height*0.02,), 
       


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Tutor", 
                  style: TextStyle(
                    color: Colors.green, 
                    fontSize: size.width*0.1, 
                    fontWeight: FontWeight.bold
                    ),
                    ), 

                    Text("Pro", 
                  style: TextStyle(
                    color: Colors.black, 
                    fontSize: size.width*0.1, 
                    fontWeight: FontWeight.bold
                    ),
                    ), 
                ],
              ), 

              SizedBox(height: size.height*0.02,), 



              //Add Tuitions
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>add_tuitions())); 
                },
                child: Container(
                  padding: EdgeInsets.all(size.width * 0.02),
                  width: size.width*0.9,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 61, 47, 3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children:[
                    Icon(Icons.add, color: Colors.white,), 
                    SizedBox(width: size.width*0.02,),
                    Text("Add Tuitions", 
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: size.width*0.08, 
                      fontWeight: FontWeight.bold
                      ),),] 
                  ),
                ),
              ), 


              
              SizedBox(height: size.height*0.02,), 



              //See Tuitions
                GestureDetector(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.all(size.width * 0.02),
                  width: size.width*0.9,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 44, 53, 58),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children:[
                    Icon(Icons.visibility, color: Colors.white,), 
                    SizedBox(width: size.width*0.02,),
                    Text("See Tuitions", 
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: size.width*0.08, 
                      fontWeight: FontWeight.bold
                      ),),] 
                  ),
                ),
              ), 



              SizedBox(height: size.height*0.02,), 



              //See Tutors 
                GestureDetector(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.all(size.width * 0.02),
                  width: size.width*0.9,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 62, 84, 95),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children:[
                    Icon(Icons.school, color: Colors.white,), 
                    SizedBox(width: size.width*0.02,),
                    Text("Tutors", 
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: size.width*0.08, 
                      fontWeight: FontWeight.bold
                      ),),] 
                  ),
                ),
              ), 



              SizedBox(height: size.height*0.02,), 
              
              
              //Write Terms & Conditions
               //See Tutors 
                GestureDetector(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.all(size.width * 0.02),
                  width: size.width*0.9,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 27, 73, 0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children:[
                    Icon(Icons.description, color: Colors.white,), 
                    SizedBox(width: size.width*0.02,),
                    Text("Terms & Conditions", 
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: size.width*0.08, 
                      fontWeight: FontWeight.bold
                      ),),] 
                  ),
                ),
              ), 



              





             ],
          ),
        ),
      )
      );
  }
}