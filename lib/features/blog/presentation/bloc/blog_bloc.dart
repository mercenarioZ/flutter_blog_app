import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;

  BlogBloc(this.uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {});
    on<BlogUploadEvent>(_onBlogUploadEvent);
  }

  void _onBlogUploadEvent(
    BlogUploadEvent event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoading());

    final res = await uploadBlog(
      UploadBlogParams(
        title: event.title,
        content: event.content,
        ownerId: event.ownerId,
        topics: event.topics,
        image: event.image,
      ),
    );

    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blog) => emit(BlogUploadSuccess()),
    );
  }
}
