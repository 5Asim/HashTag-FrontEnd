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
  // late Future<bool> isFoll?owing;
  
  
  PostsFromTag({required this.posts, required this.tag_name});

  @override
  State<PostsFromTag> createState() => _PostsFromTagState();
}

class _PostsFromTagState extends State<PostsFromTag> {
  // List<Tag> tag_details = [];
  late Future<int> tagId;
  late Future<bool?> isFollowing;
  late Future<Tag> tag;
  bool isFollowingValue = false;
  // isFollowing = checkIfFollowingTag(widget.tag_name);
  // late Future<Tag> tag_details;
  // late Future<String> content;
  // late Future<int> post_count;
  // late Future<int> follower_count;
  // late Future<bool> status1;




  @override
  void initState() {
    super.initState();
    // tag_details;
    tagId = getTagId(widget.tag_name);
    isFollowing = checkIfFollowingTag(widget.tag_name).then((value) => value);
    tag = getTagDetail(widget.tag_name);
    isFollowing.then((value) {
      setState(() {
        isFollowingValue = value ?? false;
      });
    });
  
    // content = getContent(widget.tag_name);  
    // post_count = getpost_count(widget.tag_name);
    // follower_count = getfollower_count(widget.tag_name);
    // tag_details = getTagDetail(widget.tag_name);
   

  }
    
 void refreshPosts(VoidCallback refreshCallback) async {
  List<Post> updatedPosts = await getTag_Post(widget.tag_name);
  setState(() {
    widget.posts = updatedPosts;
  });
  refreshCallback(); // Call the provided refreshCallback function
}

  @override
  
  Widget build(BuildContext context) {
    String condn = "Follow Tag";
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 202,207,250),
      appBar: AppBar(
        leading: BackButton(color:Color.fromARGB(255, 83, 84, 176 ),onPressed: () {
          Navigator.pop(context);
        },),
        backgroundColor:Color.fromARGB(255, 202,207,250),
        elevation: 0,
        centerTitle: false,
        
        bottom: PreferredSize(
          
          preferredSize: Size(30,200),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        isFollowingValue = !isFollowingValue;
                        // refreshPosts(() {});
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

// if()
FutureBuilder<Tag>(future: getTagDetail(widget.tag_name), builder:(context,snapshot){
  if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      Tag tag = snapshot.data!;
                      bool follow_to_post = tag.followToPost ?? false;
                      // Future<bool> isfollowing = checkIfFollowingTag(widget.tag_name);
                     

                      if (follow_to_post && isFollowingValue == true || follow_to_post==false) {
                        return Container(
                          padding: EdgeInsets.only(right: 16),
                          width: 120,
                          child: RawMaterialButton(
                            fillColor: Color.fromARGB(255, 83, 84, 176),
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PostPage(
                                    tag_id: widget.tag_name,
                                    refreshCallback: () => refreshPosts(() {}),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Create Post',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                                            
                      }
                      else{
                        return SizedBox.shrink();
                      }

}
 }),

                  
                    ],
                  ),
                   Padding(
                     padding: const EdgeInsets.only(left: 16,top: 8,right: 5,bottom: 8),
                     child: FutureBuilder<Tag>(
                        future:getTagDetail(widget.tag_name),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
    } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
    } else {
          Tag tag = snapshot.data!;
          String content = tag.content ?? '';
          int postCount = tag.post_count ?? 0;
          int followerCount = tag.follower_count ?? 0;

          return Column(
            children: [
              Column(
                                  children: [
                                    SizedBox(height: 5,),
                                    Text('$content',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, )),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Text("Post",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                            Text('$postCount',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                        // SizedBox(height: 8,),
                                        Column(
                                          children: [
                                            Text("Followers",
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                            Text('$followerCount',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                          ],
                                        )
                                      ],
                                    ),

                                    
                                  ],
                                  
                                ),
            ],
          );
                          }
                        },
                      ),
                   ),

                ],
              ),

      ),
      ),
      body:
        
    
      ListView.builder(
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
                Text(widget.posts[index].content.toString(),style: TextStyle(color: Colors.black,fontSize: 16,letterSpacing: 0.5
                      ), 
                      
          
            ),
            SizedBox(height: 1,),


            Count(postdata: widget.posts[index]),
            
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

// class PostTaglist extends StatefulWidget {
//   final List<Post> posts;
//   const PostTaglist({super.key, required this.posts});

//   @override
//   State<PostTaglist> createState() => _PostTaglistState();
// }

// class _PostTaglistState extends State<PostTaglist> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//       List.generate(
//       widget.posts.length,
//       (index) {
//         return Container(
//           margin: EdgeInsets.only(top: 20),
          
//           child: Padding(
//             padding: const EdgeInsets.only(left: 16, right: 16,top: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
                
//                  Text(widget.posts[index].posted_by_user.toString(), style: TextStyle(
//                 color: Colors.grey,fontSize: 10,
//               ),),
//               Text(widget.posts[index].created_at.toString(),
//                 style: TextStyle(
//                   color: Colors.grey,fontSize: 10,
//                 ),),
//               SizedBox(
//                 height:10,
//               ),
//               Text(widget.posts[index].content.toString(),style: TextStyle(color: Colors.black,fontSize: 14,
//                     ), 
                    
        
//           ),
//           SizedBox(height: 1,),


//           Count(postdata: widget.posts[index]),
          
//           SizedBox(height: 10,)
//           // ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ()));}, child: child)

//               ],
//             ),
//           ),
//         );
        
//       },
//     )
//     ]
//     );
//   }
// }