import 'package:flutter/material.dart';
import 'package:pagenation/data/models/my_response/my_response.dart';
import 'package:pagenation/data/models/post/post_model.dart';
import 'package:pagenation/data/services/api_service/api_service.dart';

class PageNationScreen extends StatefulWidget {
  const PageNationScreen({Key? key}) : super(key: key);

  @override
  State<PageNationScreen> createState() => _PageNationScreenState();
}

class _PageNationScreenState extends State<PageNationScreen> {
  List<PostsModel> posts = [];
  int page = 1;
  var scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagenation Screen"),
      ),
      body: posts.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: posts.length + 1,
              controller: scrollController,
              itemBuilder: (context, index) => index == posts.length
                  ? const SizedBox(
                      height: 40,
                      child: Center(child: CircularProgressIndicator()))
                  : Container(
                      margin: const EdgeInsets.all(12),
                      child: ListTile(
                        title: Center(
                          child: Text(
                            posts[index].title.rendered.toString(),
                          ),
                        ),
                      ),
                    ),
            )
          : const SizedBox(),
    );
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      page++;
      getData();
    }
  }

  Future<void> getData() async {
    MyResponse result = await ApiService().getData(page);
    posts.addAll(result.data);
    setState(() {});
  }
}
