import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tutorpro/Components/button.dart';
import 'package:tutorpro/Components/textinput.dart';
import 'package:tutorpro/tuitiondetails.dart';

class tuitionsPage extends StatefulWidget {
  const tuitionsPage({super.key});

  @override
  State<tuitionsPage> createState() => _tuitionsState();
}

class _tuitionsState extends State<tuitionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Find Your Tuitions",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const tuitionBody(),
    );
  }
}

class tuitionBody extends StatefulWidget {
  const tuitionBody({super.key});

  @override
  State<tuitionBody> createState() => _tuitionBodyState();
}

class _tuitionBodyState extends State<tuitionBody> {
  TextEditingController searchID = TextEditingController();
  TextEditingController searchLocation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: SingleChildScrollView(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: size.height * 0.03,
        ),
        //Search Tuition ID
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textinput(
                hintText: "Search ID",
                texteditingcontroller: searchID,
                inputType: TextInputType.number),
            SizedBox(
              width: size.width * 0.02,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(size.width * 0.01),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.black),
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        //Search Location
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textinput(
                hintText: "Search Location",
                texteditingcontroller: searchLocation,
                inputType: TextInputType.text),
            SizedBox(
              width: size.width * 0.02,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(size.width * 0.01),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.black),
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection("tuitions").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No tuitions found'));
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var userData =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  var tuitionlocation = userData['location'] ?? 'Unknown';
                  var tuitionclass = userData['class'] ?? 'Unknown';
                  var tuitionSalary = userData['salary'] ?? 'Unknown';
                  var tuitionCode = userData['code'] ?? 'Unknown';
                  var days = userData['days'] ?? 'Unknown';
                  var description = userData['description'] ?? 'Unknown';
                  var studentGender = userData['studentgender'] ?? 'Unknown';
                  var tutorGender = userData['tutorgender'] ?? 'Unknown';

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: 
                        ((context) => tuition_details( tuitionClass: tuitionclass,
                            tuitionCode: tuitionCode,
                            days: days,
                            description: description,
                            location: tuitionlocation,
                            salary: tuitionSalary,
                            studentGender: studentGender,
                            tutorGender: tutorGender,))));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          "Tuition Code: $tuitionCode\nLocation: $tuitionlocation\nClass: $tuitionclass\nSalary: $tuitionSalary",
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ],
    )));
  }
}
