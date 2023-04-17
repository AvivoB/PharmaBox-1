part of 'discussions_bloc.dart';

abstract class DiscussionsEvent extends Equatable {
  const DiscussionsEvent();

  @override
  List<Object> get props => [];
}

class GetDiscussions extends DiscussionsEvent {
  final String userId;
  const GetDiscussions({
    required this.userId,
  });
}
