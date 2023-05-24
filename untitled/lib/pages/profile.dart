import 'package:flutter/material.dart';
import 'package:untitled/api/auth/auth_api.dart';
import 'package:untitled/api/post_api.dart';
import 'package:untitled/constant.dart';
import 'package:untitled/models/user_models.dart';
import 'package:untitled/pages/login.dart';
import '../api/tag_api.dart';
import '../models/post_model.dart';
import '../models/tag_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late List<Tag> self_tags = [];
  late List<Post> selfposts = [];
  User? user;
  int? count;
  int? tag_count;


  @override
  void initState() {
    super.initState();
    selfposts = [];
    self_tags = [];
    getSelfPost().then((value) {
      setState(() {
        selfposts = value;
      });
    });
    getUser()?.then((value) {
      setState(() {
        user = value;
      });
    });
    getSelf_tag().then((value) {
      setState(() {
        self_tags = value;
      });
    });
    getTotalSelfPost().then((value) {
      setState(() {
        count = value;
      });
    });
    getTotalSelfTag().then((value) {
      setState(() {
        tag_count = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 202, 207, 250),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 202, 207, 250),
        elevation: 1,
        centerTitle: false,
      ),
      drawer: Drawer(
  backgroundColor: drawer_color,
  child: ListView(
    children: [
      Container(
        height: 80, // Adjust the height according to your preference
        padding: EdgeInsets.symmetric(horizontal: 16), // Add horizontal padding to the header
        // color: Colors.blue, // Set a background color for the header
        alignment: Alignment.centerLeft, // Align the text to the left
        child: Row(
          children: [
            Image.asset("assets/logo.png",
            width : 70,
            ),
            Text(
              "  HashTag",
              style: TextStyle(
                color: dark_blue, // Set text color for the header
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      ListTile(
        title: Text(
          "Logout",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          logout();
          Navigator.push(context, MaterialPageRoute(builder: (context) => const MyLogin()));
        },
      ),
    ],
  ),
),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/avatar1.png"),
                      ),
                    ),
                  ),
                  if (user != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                      child: Center(
                        child: Text(
                          user!.username.toString(),
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (count != null)
                        Column(
                          children: [
                            Text(
                              count.toString(),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const Text(
                              "Post",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      if (tag_count != null)
                      Column(
                        children: [
                          Text(
                            tag_count.toString(),
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Tags",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10),
                    child: Text(
                      "HashTags",
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, left: 12, right: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 83, 84, 176),
                    ),
                    child: TagList(self_tags: self_tags),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
                    child: Text(
                      "Posts",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SelfPostList(selfposts: selfposts),
                ],
              ),
            ),
          ],
        ),
      ])
      ,
    );
  }
}


class TagList extends StatelessWidget {
  final List<Tag> self_tags;

  TagList({required this.self_tags});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: self_tags.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.only(top: 5, left: 10, right: 20),
          padding: EdgeInsets.only(left: 10, right: 20, top: 5, bottom: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 25,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, top: 3),
                      child: Text(
                        "#" + self_tags[index].title.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class SelfPostList extends StatefulWidget {
  final List<Post> selfposts;
  SelfPostList({Key? key, required this.selfposts}) : super(key: key);

  @override
  State<SelfPostList> createState() => _SelfPostListState();
}
class _SelfPostListState extends State<SelfPostList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          widget.selfposts.length,
          (index) {
            return Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "# " + widget.selfposts[index].tag_name.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (widget.selfposts[index].status == "UNVERIFIED" || widget.selfposts[index].status == "unverified")
                          Tooltip(
                            message: 'Click to verify',
                            child: TextButton(
                              onPressed: () async {
                                await verifyPost(widget.selfposts[index].id.toString());

                                
                                setState(() {
                                   widget.selfposts[index].status = "VERIFIED";
                                });
                              },
                              child: Text("Verify Post"),
                            ),
                          )
                        else if (widget.selfposts[index].status == "VERIFIED" || widget.selfposts[index].status == "verified")
                          Text("Verified"),
                      ],
                    ),
                    Text(
                      widget.selfposts[index].posted_by_user.toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      widget.selfposts[index].created_at.toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.selfposts[index].content.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



// class _SelfPostListState extends State<SelfPostList> {
//   @override
//   Widget build(BuildContext context) {
//    return ListView.builder(
//     key: UniqueKey(),
//       itemCount: widget.selfposts.length,
//       itemBuilder: (BuildContext context, int index) {
//         return Container(
          
//           // key: ValueKey(selfposts[index].id),
//           margin: EdgeInsets.only(bottom: 20),
//           padding: EdgeInsets.all(10),
          
//           decoration: BoxDecoration(
//             // border: Border.all(color: Colors.grey),
//             // borderRadius: BorderRadius.circular(10),
//             color: Colors.white
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 16),
//             child: Column(
              
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text("# "+ widget.selfposts[index].tag_name.toString(),
//                       style:TextStyle(
//                         color: Colors.black,fontSize: 24,fontWeight: FontWeight.w500
//                       ),
//                     ),
//                     if(widget.selfposts[index].status == "UNVERIFIED" || widget.selfposts[index].status == "unverified") Tooltip(message: 'Click to verify', child: TextButton(onPressed: ()async{verifyPost(widget.selfposts[index].id.toString());
//                         setState(() {
//                           widget.selfposts[index].status; 
//                         });
                        
                        
//                       }, child: Text("Verify Post")))
//                       else if(widget.selfposts[index].status == "VERIFIED" || widget.selfposts[index].status == "verified") Text("Verified")
//                       // Tooltip(message: 'Click to verify', child: TextButton(onPressed: ()async{verifyPost(widget.selfposts[i?ndex].id.toString());
//                         // setState(() {
//                         //   widget.selfposts[index].status; 
//                         // });
                        
                        
                      
                    
//                   ],
//                 ),
//                 Text(widget.selfposts[index].posted_by_user.toString(), style: TextStyle(
//                   color: Colors.grey,fontSize: 10,
//                 ),),
//                 Text(widget.selfposts[index].created_at.toString(),
//                   style: TextStyle(
//                     color: Colors.grey,fontSize: 10,
//                   ),),
//                 SizedBox(
//                   height:10,
//                 ),
//                 Text(widget.selfposts[index].content.toString(),style: TextStyle(color: Colors.black,fontSize: 14,
//                       ),   
          
//             ),
//             SizedBox(height: 10,)],
//             //       ),
//             ),
//           ));
//             }
  
//         );
    
    
//   }
// }
