import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tutorpro/Components/button.dart';
import 'package:tutorpro/Components/textinput.dart';
import 'package:tutorpro/login.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController name = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController institution = TextEditingController();
  TextEditingController presentAddress = TextEditingController();
  TextEditingController permanentAddress = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController hscInstitution = TextEditingController();
  TextEditingController hsccpassingyear = TextEditingController();
  TextEditingController hscresult = TextEditingController();
  TextEditingController sscInstitution = TextEditingController();
  TextEditingController sscPassingyear = TextEditingController();
  TextEditingController sscResult = TextEditingController();
  String selectedYear = '1st year';
  final List<String> _years = ['1st year', '2nd year', '3rd year', '4th year'];
  String selectedSSCGroup = 'Science';
  final List<String> _sscgroup = ['Science', 'Commerce', 'Arts'];
  String selectedHSCGroup = 'Science';
  final List<String> _hscgroup = ['Science', 'Commerce', 'Arts'];
  File? _profileImage;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> registerUser() async {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    final phoneRegExp = RegExp(r'^01[3-9]\d{8}$');

    if (name.text.isEmpty ||
        subject.text.isEmpty ||
        institution.text.isEmpty ||
        selectedYear.isEmpty ||
        presentAddress.text.isEmpty ||
        permanentAddress.text.isEmpty ||
        phone.text.isEmpty ||
        email.text.isEmpty ||
        password.text.isEmpty ||
        hscInstitution.text.isEmpty ||
        hsccpassingyear.text.isEmpty ||
        hscresult.text.isEmpty ||
        sscInstitution.text.isEmpty ||
        sscPassingyear.text.isEmpty ||
        sscResult.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill up all the information")));
      return;
    }

    if (!emailRegExp.hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid email address")));
      return;
    }

    if (!phoneRegExp.hasMatch(phone.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid phone number")));
      return;
    }

    if (password.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password should be minimum 6 characters")));
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Registering..."),
              ],
            ),
          ),
        );
      },
    );

    try {
      var emailQuery = await FirebaseFirestore.instance.collection('users')
          .where('email', isEqualTo: email.text).get();
      if (emailQuery.docs.isNotEmpty) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("This email already exists")));
        return;
      }

      var phoneQuery = await FirebaseFirestore.instance.collection('users')
          .where('phone', isEqualTo: phone.text).get();
      if (phoneQuery.docs.isNotEmpty) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("This phone number already exists")));
        return;
      }

      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text
      );

      String? profileImageUrl;
      if (_profileImage != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child('${credential.user!.uid}.jpg');
        await storageRef.putFile(_profileImage!);
        profileImageUrl = await storageRef.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).set({
        'name': name.text,
        'institution': institution.text,
        'Year': selectedYear,
        'subject': subject.text,
        'presentAddress': presentAddress.text,
        'permanentAddress': permanentAddress.text,
        'phone': phone.text,
        'email': email.text,
        'password': password.text,
        'hscInstitution': hscInstitution.text,
        'hscgroup': selectedHSCGroup,
        'hsccPassingYear': hsccpassingyear.text,
        'hscResult': hscresult.text,
        'sscInstitution': sscInstitution.text,
        'sscgroup': selectedSSCGroup,
        'sscPassingYear': sscPassingyear.text,
        'sscResult': sscResult.text,
        'profileImageUrl': profileImageUrl,
        'timestamp': DateTime.now(),
      });

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User Registered Successfully")));

      Navigator.push(context, MaterialPageRoute(builder: ((context) => login())));
    } catch (e) {
      Navigator.of(context).pop();
      print('Error registering user: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error registering user: $e")));
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Registration Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.05),
                Text("Personal Information", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: size.height * 0.02),
                textinput(
                  hintText: "Name",
                  texteditingcontroller: name,
                  inputType: TextInputType.text,
                ),
                SizedBox(height: size.height * 0.02),
                textinput(
                  hintText: "Institution",
                  texteditingcontroller: institution,
                  inputType: TextInputType.text,
                ),
                SizedBox(height: size.height * 0.02),
                textinput(
                  hintText: "Department",
                  texteditingcontroller: subject,
                  inputType: TextInputType.text,
                ),



                SizedBox(height: size.height * 0.02),




                Container(
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedYear,
                      items: _years.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedYear = newValue!;
                        });
                      },
                    ),
                  ),
                ),



                
                SizedBox(height: size.height * 0.02),
                textinput(
                  hintText: "Present Address",
                  texteditingcontroller: presentAddress,
                  inputType: TextInputType.text,
                ),
                SizedBox(height: size.height * 0.02),
                textinput(
                  hintText: "Permanent Address",
                  texteditingcontroller: permanentAddress,
                  inputType: TextInputType.text,
                ),
                SizedBox(height: size.height * 0.02),
                Text("Higher Secondary Certificate Information", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: size.height * 0.02),
                textinput(
                  hintText: "Hsc Institute",
                  texteditingcontroller: hscInstitution,
                  inputType: TextInputType.text,
                ),
                SizedBox(height: size.height * 0.02),
                Container(
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedHSCGroup,
                      items: _hscgroup.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newvalue) {
                        setState(() {
                          selectedHSCGroup = newvalue!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                textinput(
                  hintText: "Passing Year",
                  texteditingcontroller: hsccpassingyear,
                  inputType: TextInputType.number,
                ),
                SizedBox(height: size.height * 0.02),
                textinput(
                  hintText: "Hsc Result",
                  texteditingcontroller: hscresult,
                  inputType: TextInputType.number,
                ),
                SizedBox(height: size.height * 0.02),
                Text("Secondary School Certificate Information", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: size.height * 0.02),
                textinput(
                  hintText: "SSC Institute",
                  texteditingcontroller: sscInstitution,
                  inputType: TextInputType.text,
                ),
                SizedBox(height: size.height * 0.02),
                Container(
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedSSCGroup,
                      items: _sscgroup.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? sscvalue) {
                        setState(() {
                          selectedSSCGroup = sscvalue!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                textinput(
                  hintText: "Passing Year",
                  texteditingcontroller: sscPassingyear,
                  inputType: TextInputType.number,
                ),
                SizedBox(height: size.height * 0.02),
                textinput(
                  hintText: "SSC Result",
                  texteditingcontroller: sscResult,
                  inputType: TextInputType.number,
                ),
                SizedBox(height: size.height * 0.02),
                Text("Contact Details"),
                textinput(
                  hintText: "Phone",
                  texteditingcontroller: phone,
                  inputType: TextInputType.number,
                ),
                SizedBox(height: size.height * 0.02),
                textinput(
                  hintText: "Email",
                  texteditingcontroller: email,
                  inputType: TextInputType.text,
                ),
                SizedBox(height: size.height * 0.02),
                textinput(
                  hintText: "Password",
                  texteditingcontroller: password,
                  inputType: TextInputType.text,
                ),
                SizedBox(height: size.height * 0.02),



                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text("Select Profile Picture"),
                ),
                if (_profileImage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      _profileImage!,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),


                SizedBox(height: size.height * 0.02),


                customButton(
                  onPressed: registerUser,
                  hintText: "Register",
                  backgroundColor: Colors.black,
                ),
                SizedBox(height: size.height * 0.02),
                Text("Already have an account?"),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
