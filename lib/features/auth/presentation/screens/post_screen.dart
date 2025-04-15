import 'package:auth_app1/features/auth/data/models/post.dart';
import 'package:auth_app1/features/auth/presentation/controllers/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostView extends GetView<PostController> {
  const PostView({super.key});

  // final PostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Api Posts")),
      body: Obx(() {
        if (controller.status.value.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
         else
        if (controller.status.value.isEmpty) {
          return const Center(child: Text("No posts available"));
        }
         else if (controller.status.value.isError) {
          return Center(
            child: Text(
              controller.status.value.errorMessage ?? "Something went wrong",
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            final post = controller.posts[index];
            return

            //  controller.status.value.isLoading && index == post.id
            //     ? const Center(child: CircularProgressIndicator())
            //     :
                 ListTile(
                  title: Text(post.title, maxLines: 1),
                  subtitle: Text(post.body, maxLines: 2),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => controller.deletePost(post.id!),
                  ),
                  onTap:
                      () => controller.updatePost(
                        post.id!,
                        Post(
                          title: "Updated",
                          body: "Updated Body",
                          userId: post.userId,
                        ),
                      ),
                );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => controller.addPost(
              Post(title: "New Post", body: "This is a new post", userId: 1),),
        child: const Icon(Icons.add),
      ),
    );
  }
}
