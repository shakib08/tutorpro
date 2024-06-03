import 'package:flutter/material.dart';

class TutorDetails extends StatelessWidget {
  final Map<String, dynamic> tutorData;

  const TutorDetails({super.key, required this.tutorData});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tutor Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
           Center(
              child: ClipOval(
                child: Image.network(
                  tutorData['profileImageUrl'] ?? '',
                  width: size.width * 0.4,
                  height: size.width * 0.4,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text("Name: ${tutorData['name'] ?? 'Unknown'}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), overflow: TextOverflow.visible,),
            SizedBox(height: 10),
            Text("Institution: ${tutorData['institution'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
            SizedBox(height: 10),
            Text("Phone: ${tutorData['phone'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
            SizedBox(height: 10),
            Text("Email: ${tutorData['email'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
            SizedBox(height: 10),
            Text("Permanent Address: ${tutorData['permanentAddress'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
            SizedBox(height: 10),
            Text("Present Address: ${tutorData['presentAddress'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
            SizedBox(height: 10),
            Text("HSC Institution: ${tutorData['hscInstitution'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
            SizedBox(height: 10),
            Text("HSC Result: ${tutorData['hscResult'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
            SizedBox(height: 10),
            Text("HSC Passing Year: ${tutorData['hsccPassingYear'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
            SizedBox(height: 10),
            Text("SSC Institution: ${tutorData['sscInstitution'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
            SizedBox(height: 10),
            Text("SSC Passing Year: ${tutorData['sscPassingYear'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
            SizedBox(height: 10),
            Text("SSC Result: ${tutorData['sscResult'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
            SizedBox(height: 10),
            Text("Timestamp: ${tutorData['timestamp'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
          ],
        ),
      ),
    );
  }
}
