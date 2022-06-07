import 'package:flutter/material.dart';

import 'package:frazex_task/provider/data_provider.dart';
import 'package:provider/provider.dart';

import '../helpers/api_helper.dart';
import '../models/http_response.dart';
import '../models/post.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  PostsScreenState createState() => PostsScreenState();
}

class PostsScreenState extends State<PostsScreen> {
  final ScrollController _scrollController = ScrollController();

  _getPosts() async {
    final provider = Provider.of<DataProvider>(context, listen: false);
    final HTTPResponse postsResponse = await APIHelper.getPosts();

    if (postsResponse.isSuccessful) {
      if (postsResponse.data.isNotEmpty) {
        provider.setPostsList(postsResponse.data, notify: false);
      }
    }
    provider.setIsPostsFetching(false);
  }

  @override
  void initState() {
    super.initState();
    _getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, _) => provider.isHomePageProcessing
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : provider.postsListLength > 0
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    itemBuilder: (_, index) {
                      Post post = provider.getPostByIndex(index);
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(post.title ?? ''),
                            subtitle: Text(
                              post.body ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: provider.postsListLength,
                  ),
                )
              : const Center(
                  child: Text('Nothing to show here!'),
                ),
    );
  }
}
