import 'package:flutter/material.dart';
import 'package:tutorpro/Components/button.dart';

class viewDetailedTuitions extends StatefulWidget {
  final Map<String, dynamic> tuitionData;
  const viewDetailedTuitions({Key? key, required this.tuitionData}) : super(key: key);

  @override
  State<viewDetailedTuitions> createState() => _viewDetailedTuitionsState();
}

class _viewDetailedTuitionsState extends State<viewDetailedTuitions> {
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
      body:  Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              SizedBox(height: size.height*0.02),
              Text("Tuition Code: ${widget.tuitionData['code'] ?? 'Unknown'}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), overflow: TextOverflow.visible,),
              SizedBox(height: size.height*0.02),
              Text("Location: ${widget.tuitionData['location'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
              SizedBox(height: size.height*0.02),
              Text("Class: ${widget.tuitionData['class'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
              SizedBox(height: size.height*0.02),
              Text("Weekly days: ${widget.tuitionData['days'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
              SizedBox(height: size.height*0.02),
              Text("Salary: ${widget.tuitionData['salary'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
              SizedBox(height: size.height*0.02),
              Text("Description: ${widget.tuitionData['description'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
              SizedBox(height: size.height*0.02),
              Text("Student Gender: ${widget.tuitionData['studentGender'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
              SizedBox(height: size.height*0.02),
              Text("Teacher Gender: ${widget.tuitionData['tutorGender'] ?? 'Unknown'}", style: TextStyle(fontSize: 18), overflow: TextOverflow.visible,),
              
              SizedBox(height: size.height*0.1,), 

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customButton(onPressed: (){}, hintText: "Update", backgroundColor: Colors.black), 
                  SizedBox(width: size.width*0.3,), 
                  customButton(onPressed: (){}, hintText: "Delete", backgroundColor: Colors.black)
                ],
              )
        
             ],
          ),
        ),
      );
  }
}
