import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:f_bloc/posts/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

part 'post_event.dart';
part 'post_state.dart';

const _postLimit = 20;

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({required this.httpClient}) : super(const PostState());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is PostFetched) {
      yield await _mapPostFetchedToState(state);
    }
  }

  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(
      Stream<PostEvent> events,
      TransitionFunction<PostEvent, PostState> transitionFn) {
    return super.transformEvents(
      events.throttleTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  Future<PostState> _mapPostFetchedToState(PostState state) async {
    if (state.hasReachedMMax) return state;

    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: false,
        );
      }

      final posts = await _fetchPosts(state.posts.length);
      return posts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PostStatus.success,
              posts: List.of(state.posts)..addAll(posts),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: PostStatus.failure);
    }
  }

  Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'},
      ),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List;
      return body
          .map(
            (dynamic json) => Post.fromJson(json),
          )
          .toList();
    }

    throw Exception('error fetching posts');
  }
}
