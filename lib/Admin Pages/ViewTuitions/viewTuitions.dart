import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tutorpro/Admin%20Pages/ViewTuitions/viewDetiledTuitions.dart';
import 'package:tutorpro/Components/textinput.dart';

class viewTuitions extends StatefulWidget {
  const viewTuitions({super.key});

  @override
  State<viewTuitions> createState() => _viewTuitionsState();
}

class _viewTuitionsState extends State<viewTuitions> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("View Tuitions", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Center(




          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("tuitions").snapshots(), 
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No tuitions found'));
            }
            
          
            
              return SingleChildScrollView(
              child: Column(
                children: snapshot.data!.docs.map((doc) {
                  var userData = doc.data() as Map<String, dynamic>;
                  var tuitionclass = userData['class'] ?? 'Unknown';
                  var code = userData['code'] ?? 'Unknown';
                  var days = userData['days'] ?? 'Unknown';
                  var description = userData['description'] ?? 'Unknown';
                  var location = userData['location'] ?? 'Unknown';
                  var salary = userData['salary'] ?? 'Unknown';
                  var studentGender = userData['studentGender'] ?? 'Unknown';
                  var tutorGender = userData['tutorGender'] ?? 'Unknown';
                 
              
                 


                  return GestureDetector(
                    onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>viewDetailedTuitions(tuitionData: userData)));
                    },
                    child: Container(
                      width: size.width * 0.9,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      padding: EdgeInsets.all(10),
                      child: 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text("Tuition Code: $code", style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("Location: $location"), 
                              Text("Class: $tuitionclass"), 
                              Text("Salary: $salary")
                            ],
                          ),                       
                        
                    ),
                  );
                }).toList(),
              ),
            );


            }
            ),
        )
        ),
    );
  }
}

