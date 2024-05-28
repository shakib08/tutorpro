import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
      ),
      body: ShowData(),
    );
  }
}

class ShowData extends StatelessWidget {
  const ShowData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return UserStream(user: user);
    } else {
      return Text('User not logged in');
    }
  }
}

class UserStream extends StatelessWidget {
  final User user;

  const UserStream({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('No data found for the user.');
        }

       
        var userData = snapshot.data!.data() as Map<String, dynamic>?; 

        return SafeArea(
          child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userData?['profileImageUrl'] ?? ''),
                      radius: 60,
                    ),

                Text("Personal Information", style: TextStyle(fontWeight: FontWeight.bold),),
                Text('Name: ${userData!['name']}'),
                Text('Location: ${userData!['presentAddress']}'),
                Text('Permanent Address: ${userData!['permanentAddress']}'),
                


                SizedBox(height: size.height*0.05,),

                Text("Educational Information", style: TextStyle(fontWeight: FontWeight.bold),),
                Text("Current Institution Information", style: TextStyle(fontWeight: FontWeight.bold),),
                Text('Institution: ${userData!['institution']}'),
                Text('Department: ${userData!['subject']}'),
                Text('Year: ${userData!['Year']}'),
                
                SizedBox(height: size.height*0.02,),

                Text("HSC Information", style: TextStyle(fontWeight: FontWeight.bold),),
                Text('College Name: ${userData!['hscInstitution']}'),
                Text('Passsing Year: ${userData!['hsccPassingYear']}'),
                Text('Group: ${userData!['hscgroup']}'),
                Text('Hsc Result: ${userData!['hscResult']}'),

                SizedBox(height: size.height*0.02,),

                Text("SSC Information", style: TextStyle(fontWeight: FontWeight.bold),),
                Text('School Name: ${userData!['sscInstitution']}'),
                Text('Passing Year: ${userData!['sscPassingYear']}'),
                Text('Group: ${userData!['sscgroup']}'),
                Text('SSC Result: ${userData!['sscResult']}'),

                SizedBox(height: size.height*0.02,),
                Text("Contact Information", style: TextStyle(fontWeight: FontWeight.bold),),
                Text('Phone Number: ${userData!['phone']}'),
                Text('Email: ${userData!['email']}'),
                // Add more fields as needed
              ],
            ),
          ),
        );
      },
    );
  }
}