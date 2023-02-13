import 'package:dio/dio.dart';
import 'package:pagenation/data/models/my_response/my_response.dart';
import 'package:pagenation/data/models/post/post_model.dart';
import 'package:pagenation/data/services/api_service/api_client.dart';

class ApiService extends ApiClient {
  Future<MyResponse> getData(int page) async {
    MyResponse myResponse=MyResponse();
    try {
      Response response =
      await dio.get("https://techcrunch.com/wp-json/wp/v2/posts?context=embed&per_page=10&page=$page",);
      if (response.statusCode == 200) {
        myResponse.data = response.data.map((e)=>PostsModel.fromJson(e)).toList();
      }
    } catch (e) {
      myResponse.error = e.toString();
    }
    return myResponse;
  }
}