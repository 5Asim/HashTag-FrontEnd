import 'package:flutter/material.dart';
import 'package:untitled/api/follow_api.dart';
import 'package:untitled/api/tag_api.dart';
import '../api/auth/auth_api.dart';
import '../models/post_model.dart';
import '../models/tag_model.dart';
import '../models/user_models.dart';
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
  late Future<bool> status;
  late List tag_details;



  @override
  void initState() {
    super.initState();
    tag_details =[];
    status = checkIfFollowingTag(widget.tag_name);
    getTagDetail(widget.tag_name).then((value) {
      setState(() {
         tag_details= value;
      });
    });
  }
  // void initState() {
  //   List followers = [];
  //   User? user;
  //   bool status = awa;
    // super.initState();
    // getTagFollowers(widget.tag_name).then((value) 
    // // getSelf_tag().then((value) 
    // {
    // {
    //   setState(() {
    //     followers = value;
    //     // self_tags = value;
    //   });
    // }});
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
        actions: [
        // FutureBuilder<bool>(
        //     future: status,
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return CircularProgressIndicator();
        //       } else if (snapshot.hasError) {
        //         return Text('Error: ${snapshot.error}');
        //       } else {
        //         final bool isFollowing = snapshot.data!;
        //         return Container(
                  
        //           width: 100,
        //           height: 20,
        //           child: RawMaterialButton(
        //           fillColor: Color.fromARGB(255, 83,84,176),
        //           padding: EdgeInsets.symmetric(vertical: 15.0),
        //           shape:  RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(12)
        //         ),
        //         onPressed: (){

        //         },
        //           child: Text(isFollowing ? 'Following' : 'Follow Tag')));
        //       }
        //     },
        //   ),
        ],
        bottom: PreferredSize(
          preferredSize: Size(20,50),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,


            children: [


              Padding(
                padding: const EdgeInsets.only(left:16.0),
                child: Column(
                  children: [
                    Text("# " + widget.tag_name,
                      style: TextStyle(
                          color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700
                      ),
                    ),
                    // Text('${tag_details[index]["create*d_by_username"]} posts')
                    // Text(widget.)
                  ],
                ),
              ),
                 FutureBuilder<bool>(
  future: status,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      bool isFollowing = snapshot.data!;
      return Padding(
        padding: const EdgeInsets.only( right: 0,top: 5),
        child: Container(
          width: 130,
          
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
                status = checkIfFollowingTag(widget.tag_name);
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
           SizedBox(
         height:10,
            )
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
                  // Text("# " + widget.posts[index].tag_name.toString(),
                  // style:TextStyle(
                  //     color: Colors.black,fontSize: 24,fontWeight: FontWeight.w500
                  //   )),
                  // SizedBox(height: 10,),
                  // Text(widget.posts[index].content.toString(),
                  // style: TextStyle(color: Colors.black,fontSize: 14,
                  //     ),),
                  
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
            Count(postdata: widget.posts[index]),
            
            SizedBox(height: 10,)

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

