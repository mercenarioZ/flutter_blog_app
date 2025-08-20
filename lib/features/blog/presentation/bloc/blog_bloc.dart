import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/core/usecases/usecases.dart';
import 'package:flutter_app/features/blog/domain/entities/blog.dart';
import 'package:flutter_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  // usecases
  final UploadBlog uploadBlog;
  final GetAllBlogs getAllBlogs;

  BlogBloc(this.uploadBlog, this.getAllBlogs) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {});
    on<BlogUploadEvent>(_onBlogUploadEvent);
    on<BlogsFetchEvent>(_onBlogsFetchEvent);
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

  void _onBlogsFetchEvent(
    BlogsFetchEvent event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoading());

    final res = await getAllBlogs(NoParams());

    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blogs) => emit(BlogLoaded(blogs)),
    );
  }
}
