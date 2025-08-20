import 'dart:io';

import 'package:flutter_app/core/error/exceptions.dart';
import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:flutter_app/features/blog/data/models/blog_model.dart';
import 'package:flutter_app/features/blog/domain/entities/blog.dart';
import 'package:flutter_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  BlogRepositoryImpl(this.blogRemoteDataSource);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String ownerId,
    required List<String> topics,
  }) async {
    try {
      final blogId = Uuid().v1();

      // Upload the image and get the URL
      String imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blogId: blogId,
      );

      BlogModel blog = BlogModel(
        id: blogId,
        title: title,
        content: content,
        ownerId: ownerId,
        topics: topics,
        imageUrl: imageUrl,
        updatedAt: DateTime.now(),
      );

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blog);

      return right(uploadedBlog);
      // can return the uploaded blog (type Blog) directly instead of BlogModel, because BlogModel extends Blog!!
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.getAllBlogs();

      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
