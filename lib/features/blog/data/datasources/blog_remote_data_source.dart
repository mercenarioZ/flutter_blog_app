import 'dart:io';

import 'package:flutter_app/core/error/exceptions.dart';
import 'package:flutter_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({required File image, required String blogId});
  Future<List<BlogModel>> getAllBlogs();
  Future<BlogModel> getBlogById(String blogId); // implement this later
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabase;
  BlogRemoteDataSourceImpl(this.supabase);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData = await supabase
          .from('blogs')
          .insert(blog.toJson())
          .select();

      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required String blogId,
  }) async {
    try {
      await supabase.storage.from('blog_images').upload(blogId, image);

      return supabase.storage.from('blog_images').getPublicUrl(blogId);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final response = await supabase
          .from('blogs')
          .select('*, profiles (name)');

      return (response as List)
          .map((blog) => BlogModel.fromJson(blog))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<BlogModel> getBlogById(String blogId) {
    // TODO: implement getBlogById
    throw UnimplementedError();
  }
}
