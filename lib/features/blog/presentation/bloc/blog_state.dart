part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogUploadSuccess extends BlogState {}

final class BlogFailure extends BlogState {
  final String error;

  BlogFailure(this.error);
}

final class BlogLoaded extends BlogState {
  final List<Blog> blogs;

  BlogLoaded(this.blogs);
}
