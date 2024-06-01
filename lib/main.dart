import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tutorpro/admin.dart';
import 'package:tutorpro/homepage.dart';
import 'package:tutorpro/login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AuthWrapper(),
        ),
    );
  }
}


class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
         


        
         else if (snapshot.hasData) {
          // Check if the logged-in user is an admin
          final currentUser = snapshot.data!;
          final isAdmin = currentUser.email == 'admin@tutorpro.com';
          if (isAdmin) {
            return admin_home_page(); // Redirect to admin page
          } else {
            return home(); // Redirect to regular user home page
          }// Replace with your actual home page
        } else {
          return login(); // Replace with your actual login page
        }
      },
    );
  }
}
