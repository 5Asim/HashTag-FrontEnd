import 'package:flutter/material.dart';
import 'package:untitled/api/post_api.dart';

import '../api/tag_api.dart';
import '../models/post_model.dart';
import '../models/tag_model.dart';
import 'PostFromTag.dart';
import 'home.dart';

class Recommended extends StatefulWidget {
  const Recommended({Key? key}) : super(key: key);

  @override
  State<Recommended> createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  List<Tag> posts = [];
  void initState() {
    super.initState();
    getRecomendedPost().then((value) 
    // getSelf_tag().then((value) 
    {
    {
      setState(() {
        posts = value;
        // self_tags = value;
      });
    }});
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: Color.fromARGB(255, 202, 207, 250),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 202, 207, 250),
          elevation: 0,
          title: Image.asset("assets/logo.png",
            width: 70,
          ),
          // alignment: Alignment.topLeft,
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
                color: Colors.black),
            IconButton(onPressed: () {},
                icon: Icon(Icons.notifications_active_outlined),
                color: Colors.indigoAccent),

          ],


          bottom: PreferredSize(
            preferredSize: Size(20,20),
            child: Column(


              children: [


                Text('Recommended For You',
                  style: TextStyle(
                      color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700
                  ),
                ),
                SizedBox(
                  height:10 ,
                )

              ],
            ),

          ),
        ),
       body: Column(
          
          children: [
            Expanded(
              child: RecomendedPostsList(posts: posts,
             )),
          ],
        ),


    );
  }
  }


  class RecomendedPostsList extends StatefulWidget {
  final List<Tag> posts;
  
  
  RecomendedPostsList({required this.posts});
  

  @override
  
  _RecomendedPostsListState createState() => _RecomendedPostsListState();
}

class _RecomendedPostsListState extends State<RecomendedPostsList> {
  
  @override
  int updated_upvote =0;
  int updated_downvote = 0;

  @override
  
  Widget build(BuildContext context) {
    
    return ListView.builder(
      
      key: UniqueKey(),
      itemCount: widget.posts.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          
          key: ValueKey(widget.posts[index].id),
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.only(left: 10,top: 25,bottom: 25),
          
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            // borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16,right: 16),
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 
                GestureDetector(
                  onTap: () async{
                    String tag_name = widget.posts[index].title.toString();
                    List<Post> tag_posts = await getTag_Post(tag_name);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PostsFromTag(posts:tag_posts, tag_name: tag_name,),),);
                  },
                  child: Text("# "+ widget.posts[index].title.toString(),
                    style:TextStyle(
                      color: Colors.black,fontSize: 24,fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Text(widget.posts[index].created_by.toString(), style: TextStyle(
                  color: Colors.grey,fontSize: 10,
                ),),
                Text(widget.posts[index].created_at.toString(),
                  style: TextStyle(
                    color: Colors.grey,fontSize: 10,
                  ),),
                SizedBox(
                  height:15,
                ),
                Text(widget.posts[index].content.toString(),style: TextStyle(color: Colors.black,fontSize: 14,
                      ), 
                      
          
            ),
            SizedBox(height: 1,),
            
            // Count(postdata: widget.posts[index]),
            
            SizedBox(height: 10,)],
            //       ),
            ),
          ));
            }
  
        );
    
    
  }
}
