import 'dart:convert';

class Tag {
  int? id;
  String? content;
  String? created_by;
  DateTime? created_at;
  String? title;
  bool? followToPost;
  bool? followToComment;
  bool? followToLike;
  String? generalRules;
  String? relevantTags;
  int? post_count;
  int? follower_count;


  Tag({
    this.id,
    this.content,
    this.created_by,
    this.created_at,
    this.title,
    this.followToPost,
    this.followToComment,
    this.followToLike,
    this.generalRules,
    this.relevantTags,
    this.post_count,
    this.follower_count,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      content: json['content'],
      created_by: json['created_by_username'],
      created_at: DateTime.parse(json['created_at']),
      title: json['title'],
      followToPost: json['follow_to_post'],
      followToComment: json['follow_to_comment'],
      followToLike: json['follow_to_like'],
      generalRules: json['general_rules'],
      relevantTags: json['relevant_tags'],
      post_count: json['post_count'],
      follower_count: json['follower_count']
    );
  }
}