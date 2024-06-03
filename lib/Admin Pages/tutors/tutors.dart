import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tutorpro/Admin%20Pages/tutors/tutorDetails.dart';

class tutorsCollection extends StatefulWidget {
  const tutorsCollection({super.key});

  @override
  State<tutorsCollection> createState() => _tutorsCollectionState();
}

class _tutorsCollectionState extends State<tutorsCollection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tutors Collection",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: TutorsCollectionBody(),
    );
  }
}

class TutorsCollectionBody extends StatefulWidget {
  const TutorsCollectionBody({super.key});

  @override
  State<TutorsCollectionBody> createState() => _TutorsCollectionBodyState();
}

class _TutorsCollectionBodyState extends State<TutorsCollectionBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No tutors found'));
            }

            return SingleChildScrollView(
              child: Column(
                children: snapshot.data!.docs.map((doc) {
                  var userData = doc.data() as Map<String, dynamic>;
                  var tutorName = userData['name'] ?? 'Unknown';
                  var tutorInstitution = userData['institution'] ?? 'Unknown';
                  var hscInstitution = userData['hscInstitution'] ?? 'Unknown';
                  var hscResult = userData['hscResult'] ?? 'Unknown';
                  var hscPassingYear = userData['hscPassingYear'] ?? 'Unknown';
                  var permanentAddress = userData['permanentAddress'] ?? 'Unknown';
                  var phone = userData['phone'] ?? 'Unknown';
                  var presentAddress = userData['presentAddress'] ?? 'Unknown';
                  var sscInstitution = userData['sscInstitution'] ?? 'Unknown';
                  var sscPassingYear = userData['sscPassingYear'] ?? 'Unknown';
                  var sscResult = userData['sscResult'] ?? 'Unknown';
                  var timestamp = userData['timestamp'] ?? 'Unknown';
                   var email = userData['email'] ?? 'Unknown';
                  var profileImageUrl = userData['profileImageUrl'] ?? '';

                  return GestureDetector(
                    onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TutorDetails(tutorData: userData),
                        ),
                      );
                    },
                    child: Container(
                      width: size.width * 0.9,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(profileImageUrl),
                            radius: 40,
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("$tutorName", style: TextStyle(fontSize: size.width*0.9*0.05, fontWeight: FontWeight.bold), overflow: TextOverflow.visible,),
                                Text("$tutorInstitution", style: TextStyle(fontSize: size.width*0.9*0.04, color: Colors.grey),  overflow: TextOverflow.visible,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
