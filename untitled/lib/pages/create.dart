import 'package:flutter/material.dart';
import 'package:untitled/api/tag_api.dart';



class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController relevantTagsController = TextEditingController();
  bool followToPost = false;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 244, 255),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: (){
            Navigator.pushNamed(context, 'home');
          },
        ),
        backgroundColor:Color.fromARGB(255, 243, 244, 255),
        elevation: 1,
        // title: Image.asset("assets/logo.png",
        // width : 100,
        // ),
        // alignment: Alignment.topLeft,
        centerTitle: false,

        bottom: PreferredSize(
          preferredSize: Size(20,20),

          child: Column(

            children: [


              Text('Create Tag',
                style: TextStyle(
                    color: Colors.indigoAccent,fontSize: 20,fontWeight: FontWeight.w700
                ),
              ),



            ],
          ),

        ),


      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Content',
              ),
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: relevantTagsController,
              decoration: InputDecoration(
                labelText: 'Relevant Tags',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: followToPost,
                  onChanged: (value) {
                    setState(() {
                      followToPost = value ?? false;
                    });
                  },
                ),
                Text('Follow to Post'),
              ],
            ),
            SizedBox(height: 16.0),
            Padding(
            padding: const EdgeInsets.only(left: 20, right:200),
            child: Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Color.fromARGB(255, 83,84,176),
                padding: EdgeInsets.symmetric(vertical: 15.0),
                shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
                onPressed: (){
                 createTag(titleController.text, contentController.text, relevantTagsController.text, followToPost);
                 titleController.clear();
                 contentController.clear();
                 relevantTagsController.clear();
            
                          },
                child: Text('Create Tag', style: TextStyle(color: Colors.white,),
                ),
              ),
            ),
          ),
        ],


      )





    );
  }
}
