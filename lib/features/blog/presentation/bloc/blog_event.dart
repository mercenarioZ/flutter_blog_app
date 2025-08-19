part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUploadEvent extends BlogEvent {
  final String title;
  final String content;
  final String ownerId;
  final File image;
  final List<String> topics;

  BlogUploadEvent({
    required this.title,
    required this.content,
    required this.ownerId,
    required this.image,
    required this.topics,
  });
}

final class BlogsFetchEvent extends BlogEvent {}
