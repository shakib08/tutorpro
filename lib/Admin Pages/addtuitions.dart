import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tutorpro/Components/button.dart';
import 'package:tutorpro/Components/textinput.dart';

class add_tuitions extends StatefulWidget {
  const add_tuitions({super.key});

  @override
  State<add_tuitions> createState() => _add_tuitionsState();
}

class _add_tuitionsState extends State<add_tuitions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Tuitions", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: addtuitionbody(),
    );
  }
}





class addtuitionbody extends StatefulWidget {
  const addtuitionbody({super.key});

  @override
  State<addtuitionbody> createState() => _addtuitionbodyState();
}

class _addtuitionbodyState extends State<addtuitionbody> {
  TextEditingController code = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController tuitionclass = TextEditingController();
  TextEditingController days = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController description = TextEditingController();
  String studentgender = 'Male';
  final List<String> _studentgender = ['Male', 'Female'];
  String tutorgender = 'Male';
  final List<String> _tutorgender = ['Male', 'Female'];
  
bool isLoading = false;
  @override


  


  Future<void> addtodb() async {
    if (code.text.isEmpty ||
        location.text.isEmpty ||
        tuitionclass.text.isEmpty ||
        days.text.isEmpty ||
        salary.text.isEmpty ||
        description.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all the fields')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('tuitions')
          .where('code', isEqualTo: code.text)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('This code already exists')),
        );
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
                Text("Adding..."),
              ],
            ),
          ),
        );
      },
    );
      await FirebaseFirestore.instance.collection('tuitions').add({
        'code': code.text,
        'location': location.text,
        'class': tuitionclass.text,
        'days': days.text,
        'salary': salary.text,
        'description': description.text,
        'studentGender': studentgender,
        'tutorGender': tutorgender,
      });
       Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tuition added successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add tuition: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }







  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    return SafeArea(
      child: SingleChildScrollView(
         child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
              SizedBox(height: size.height*0.02,), 
              
              textinput(hintText: "Code", texteditingcontroller: code, inputType: TextInputType.number), 
              SizedBox(height: size.height*0.02,),
              textinput(hintText: "Location", texteditingcontroller: location, inputType: TextInputType.text),
              SizedBox(height: size.height*0.02,),
              textinput(hintText: "class", texteditingcontroller: tuitionclass, inputType: TextInputType.text),
              SizedBox(height: size.height*0.02,),
              textinput(hintText: "Salary", texteditingcontroller: salary, inputType: TextInputType.number),
               SizedBox(height: size.height*0.02,),
              textinput(hintText: "Weekly Days", texteditingcontroller: days, inputType: TextInputType.number),
              SizedBox(height: size.height*0.02,), 

               Text("Student Gender"),
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
                        value: studentgender,
                        items: _studentgender.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            studentgender = newValue!;
                          });
                        },
                      ),
                    ),
                  ),


                SizedBox(height: size.height*0.02,), 
                

                 Text("Teacher Gender"),
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
                        value: tutorgender,
                        items: _tutorgender.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newtutorValue) {
                          setState(() {
                            tutorgender = newtutorValue!;
                          });
                        },
                      ),
                    ),
                  ),

              SizedBox(height: size.height*0.02,),
              textinput(hintText: "Description", texteditingcontroller: description, inputType: TextInputType.text),
           
              SizedBox(height: size.height*0.03,), 

              customButton(
                onPressed: addtodb, 
                hintText: "Submit", 
                backgroundColor: Colors.black
                )
           
           
             ],
           ),
         ),
      )
      );
  }
}