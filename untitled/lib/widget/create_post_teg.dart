import 'package:flutter/material.dart';
import 'package:untitled/api/post_api.dart';
import 'package:untitled/pages/PostFromTag.dart';

import '../models/post_model.dart';
class PostPage extends StatefulWidget {
  late  String tag_id;
  final VoidCallback refreshCallback;
  late  List<Post> posts;
  late String tag_name;
  
  PostPage({required this.tag_id,  required this.refreshCallback, });

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

TextEditingController _contentController = TextEditingController();  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 202,207,250),
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 202,207,250),
        title: Text('Create Post',style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                hintText: 'Whats your mind'
              ),
              maxLines: null,
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
                 createPost(widget.tag_id, _contentController.text);
                 _contentController.clear();
                 widget.refreshCallback();
                 Navigator.pop(context);
                
                                 },
                child: Text('Create Post', style: TextStyle(color: Colors.white,),
                ),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}