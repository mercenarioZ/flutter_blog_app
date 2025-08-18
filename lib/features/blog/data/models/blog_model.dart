import 'package:flutter_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.ownerId, // Changed from authorId to ownerId for clarity
    required super.updatedAt,
    required super.topics,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'owner_id': ownerId,
      'updated_at': updatedAt.toIso8601String(),
      'topics': topics,
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['image_url'] as String,
      ownerId: map['owner_id'] as String,
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at'] as String),
      topics: List<String>.from(map['topics'] as List<dynamic>),
    );
  }
}
