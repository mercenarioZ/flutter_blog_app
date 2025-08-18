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
  BlogRepositoryImpl({required this.blogRemoteDataSource});

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

      BlogModel blogModel = BlogModel(
        id: blogId,
        title: title,
        content: content,
        ownerId: ownerId,
        topics: topics,
        imageUrl: imageUrl,
        updatedAt: DateTime.now(),
      );

      return Right(blogModel);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<String> uploadBlogImage({required File image, required Blog blog}) {
    // TODO: implement uploadBlogImage
    throw UnimplementedError();
  }
}
