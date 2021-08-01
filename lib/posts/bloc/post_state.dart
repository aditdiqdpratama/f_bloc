part of 'post_bloc.dart';

enum PostStatus { initial, success, failure }

class PostState extends Equatable {
  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMMax;

  const PostState(
      {this.status = PostStatus.initial,
      this.posts = const <Post>[],
      this.hasReachedMMax = false});

  @override
  List<Object?> get props => [status, posts, hasReachedMMax];

  @override
  String toString() =>
      'PostState { status: $status, hasReachedMax: $hasReachedMMax, post: ${posts.length} }';

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    bool? hasReachedMax,
  }) =>
      PostState(
          status: status ?? this.status,
          posts: posts ?? this.posts,
          hasReachedMMax: hasReachedMMax);
}
