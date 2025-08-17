import 'dart:io';

import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/features/blog/domain/entities/blog.dart';
import 'package:flutter_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class BlogRepositoryImpl implements BlogRepository {
  @override
  Future<Either<Failure, Blog>> uploadBlog({required File image, required String title, required String content, required String ownerId, required List<String> topics}) {
    // TODO: implement uploadBlog
    throw UnimplementedError();
  }

  @override
  Future<String> uploadBlogImage({required File image, required Blog blog}) {
    // TODO: implement uploadBlogImage
    throw UnimplementedError();
  }

}