import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:untitled/api/auth/auth_api.dart';
import 'package:untitled/api/comment_api.dart';
import 'package:untitled/constant.dart';
import 'package:untitled/models/comment_model.dart';
import 'package:untitled/widget/reply.dart';

import '../models/post_model.dart';
import '../models/user_models.dart';

class Comments extends StatefulWidget {
  final Post post;

  Comments({required this.post});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  List<Comment> comments = [];
  late User user;
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getComment(widget.post.id.toString()).then((value) {
      setState(() {
        comments = value;
      });
    });
    getUser()?.then((value) {
      setState(() {
        user = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 202,207,250),
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: BackButton(
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Comments",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: CommentList(comments: comments),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: "Add a comment...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    await addComment(
                      widget.post.id.toString(),
                      user.username.toString(),
                      commentController.text,
                    );
                    List<Comment> updatedComments =
                        await getComment(widget.post.id.toString());
                    setState(() {
                      comments = updatedComments;
                    });
                    commentController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommentList extends StatefulWidget {
  final List<Comment> comments;
  
  CommentList({required this.comments});

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  bool showReplies = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.comments.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.comments[index].commentor_by.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                widget.comments[index].comment_time.toString(),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.comments[index].comment.toString(),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  setState(() {
                    showReplies = !showReplies;
                  });
                },
                child: Text(
                  showReplies ? 'Hide Replies' : 'Show Replies',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (showReplies) ...[
                SizedBox(height: 8),
                // ReplyList(replies: widget.comments[index].comment.to),
              ],
            ],
          ),
        );
      },
    );
  }
}

