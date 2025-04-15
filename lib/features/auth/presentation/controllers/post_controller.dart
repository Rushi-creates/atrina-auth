import 'package:auth_app1/features/auth/data/models/post.dart';
import 'package:auth_app1/features/auth/data/repositories/post_repo.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  final ApiProvider apiProvider = ApiProvider();

  RxList<Post> posts = <Post>[].obs;
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.empty());
  RxInt loadingIndex = 0.obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {
    try {
      status.value = RxStatus.loading();
      final data = await apiProvider.fetchPosts();
      if (data.isEmpty) {
        status.value = RxStatus.empty();
      } else {
        posts.value = data;
        status.value = RxStatus.success();
      }
    } catch (e) {
      status.value = RxStatus.error('Failed to load posts');
    }
  }

  void addPost(Post post) async {
    try {
      status.value = RxStatus.loading();
      final newPost = await apiProvider.createPost(post);
      posts.add(newPost);
      status.value = RxStatus.success();
    } catch (e) {
      status.value = RxStatus.error('Failed to add post');
    }
  }

  void updatePost(int id, Post post) async {
    try {
      // status.value = RxStatus.loading();
      final updatedPost = await apiProvider.updatePost(id, post);
      loadingIndex.value = posts.indexWhere((p) => p.id == id);
      if (loadingIndex.value != -1) {
        posts[loadingIndex.value] = updatedPost;
      }
      status.value = RxStatus.success();
    } catch (e) {
      status.value = RxStatus.error('Failed to update post');
    }
  }

  void deletePost(int id) async {
    try {
      // status.value = RxStatus.loading();
      await apiProvider.deletePost(id);
      posts.removeWhere((p) => p.id == id);
      if (posts.isEmpty) {
        status.value = RxStatus.empty();
      } else {
        status.value = RxStatus.success();
      }
    } catch (e) {
      status.value = RxStatus.error('Failed to delete post');
    }
  }
}
