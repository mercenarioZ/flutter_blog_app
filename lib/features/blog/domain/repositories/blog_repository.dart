import 'dart:io';

import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String ownerId,
    required List<String> topics,
  });

  Future<String> uploadBlogImage({required File image, required Blog blog});
}
