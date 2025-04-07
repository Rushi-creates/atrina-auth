import 'package:auth_app1/core/network/dio_client.dart';
import 'package:auth_app1/features/auth/data/models/post.dart';

class ApiProvider {
  final DioClient _dioClient = DioClient();

  Future<List<Post>> fetchPosts() async {
    final response = await _dioClient.get('/posts');
    return (response.data as List).map((json) => Post.fromJson(json)).toList();
  }

  Future<Post> createPost(Post post) async {
    final response = await _dioClient.post('/posts', data: post.toJson());
    return Post.fromJson(response.data);
  }

  Future<Post> updatePost(int id, Post post) async {
    final response = await _dioClient.put('/posts/$id', data: post.toJson());
    return Post.fromJson(response.data);
  }

  Future<void> deletePost(int id) async {
    await _dioClient.delete('/posts/$id');
  }
}
