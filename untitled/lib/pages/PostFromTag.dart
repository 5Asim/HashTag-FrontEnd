import 'package:flutter/material.dart';
import 'package:untitled/api/follow_api.dart';
import 'package:untitled/api/post_api.dart';
import 'package:untitled/api/tag_api.dart';
import '../api/auth/auth_api.dart';
import '../models/post_model.dart';
import '../models/tag_model.dart';
import '../models/user_models.dart';
import '../widget/create_post_teg.dart';
import '../widget/like.dart';
import 'home.dart';
class PostsFromTag extends StatefulWidget {
  late  List<Post> posts;
  late String tag_name;
  
  
  PostsFromTag({required this.posts, required this.tag_name});

  @override
  State<PostsFromTag> createState() => _PostsFromTagState();
}

class _PostsFromTagState extends State<PostsFromTag> {
  late Future<int> tagId;
  late List<dynamic> tag_details;
  late Future<String> content;
  // late Future<bool> status1;




  @override
  void initState() {
    super.initState();
    tag_details =[];
    tagId = getTagId(widget.tag_name);
    content = getContent(widget.tag_name);

  
  // // void initState() {
  // //   List followers = [];
  // //   User? user;
  // //   bool status = awa;
  //   // super.initState();
  //   getTagDetail(widget.tag_name).then((value) 
  //   // getSelf_tag().then((value) 
  //   {
  //   {
  //     setState(() {
  //       tag_details = value;
 
  //     });
  //   }});

  }
    // getUser()?.then((value) {
    //   setState(() {
    //     user = value;
    //   });
    // });
    // checkIfFollowingTag(widget.tag_name).then((value) 
    // // getSelf_tag().then((value) 
    // {
    // {
    //   setState(() {
    //     ;
    //     // self_tags = value;
    //   });
    // }});
  @override
  
  Widget build(BuildContext context) {
    String condn = "Follow Tag";
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 202,207,250),
      appBar: AppBar(
        leading: BackButton(color:Color.fromARGB(255, 83, 84, 176 )),
        backgroundColor:Color.fromARGB(255, 202,207,250),
        elevation: 0,
        centerTitle: false,
        
        bottom: PreferredSize(
          preferredSize: Size(20,70),

          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,


                children: [


                  Padding(
                    padding: const EdgeInsets.only(left:16.0),
                    child: Text("# " + widget.tag_name,
                      style: TextStyle(
                          color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                     FutureBuilder<bool>(
  future: checkIfFollowingTag(widget.tag_name),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      bool isFollowing = snapshot.data!;
      return Padding(
        padding: const EdgeInsets.only( right: 0,top: 0),
        child: Container(
              width: 120,
              
              child: RawMaterialButton(
                fillColor: Color.fromARGB(255, 83, 84, 176),
                padding: EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: () async {
                  await followTag(widget.tag_name);
                  setState(() {
                    isFollowing = !isFollowing;
                    // status1 = checkIfFollowingTag(widget.tag_name);
                  });
                },
                child: Text(
                  isFollowing ? 'Following' : 'Follow Tag',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
        ),
      );
    }
  },
),

Container(
  padding: EdgeInsets.only(right: 16),
              width: 120,
              
              child: RawMaterialButton(
                fillColor: Color.fromARGB(255, 83, 84, 176),
                padding: EdgeInsets.symmetric(vertical: 15.0,),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: ()  {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage(tag_id: widget.tag_name,)));
                },
                child: Text("Create Post",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
        ),
              
                ],
              ),
               Padding(
                 padding: const EdgeInsets.only(left: 16,top: 8),
                 child: FutureBuilder<String>(
                    future: content,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        String content = snapshot.data!;
                        return Text(
                          '$content',
                        );
                      }
                    },
                  ),
               ),
            ],
          ),

        ),

      ),
      body: ListView.builder(
        itemCount: widget.posts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(top: 20),
            
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16,top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                   Text(widget.posts[index].posted_by_user.toString(), style: TextStyle(
                  color: Colors.grey,fontSize: 10,
                ),),
                Text(widget.posts[index].created_at.toString(),
                  style: TextStyle(
                    color: Colors.grey,fontSize: 10,
                  ),),
                SizedBox(
                  height:10,
                ),
                Text(widget.posts[index].content.toString(),style: TextStyle(color: Colors.black,fontSize: 14,
                      ), 
                      
          
            ),
            SizedBox(height: 1,),


            // Count(postdata: widget.posts[index]),
            
            SizedBox(height: 10,)
            // ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ()));}, child: child)

                ],
              ),
            ),
          );
          
        },
      ),
    );
  }
}

