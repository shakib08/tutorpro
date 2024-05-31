import 'package:flutter/material.dart';
import 'package:tutorpro/Components/button.dart';

class tuition_details extends StatelessWidget {
  final String tuitionClass;
  final String tuitionCode;
  final String days;
  final String description;
  final String location;
  final String salary;
  final String studentGender;
  final String tutorGender;

  const tuition_details({
    super.key,
    required this.tuitionClass,
    required this.tuitionCode,
    required this.days,
    required this.description,
    required this.location,
    required this.salary,
    required this.studentGender,
    required this.tutorGender,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Tuition Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height*0.02,),
            Text("Class: $tuitionClass", style: TextStyle(fontSize: 16)),
            Text("Code: $tuitionCode", style: TextStyle(fontSize: 16)),
            Text("Days: $days", style: TextStyle(fontSize: 16)),
            Text("Description: $description", style: TextStyle(fontSize: 16)),
            Text("Location: $location", style: TextStyle(fontSize: 16)),
            Text("Salary: $salary", style: TextStyle(fontSize: 16)),
            Text("Student Gender: $studentGender", style: TextStyle(fontSize: 16)),
            Text("Tutor Gender: $tutorGender", style: TextStyle(fontSize: 16)),
            SizedBox(height: size.height*0.02,),
            customButton(onPressed: (){}, hintText: "Apply", backgroundColor: Colors.black)
          ],
        ),
      ),
    );
  }
}
