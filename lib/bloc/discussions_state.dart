// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'discussions_bloc.dart';

abstract class DiscussionsState extends Equatable {
  const DiscussionsState();

  @override
  List<Object> get props => [];
}

class DiscussionsInitial extends DiscussionsState {}

class DiscussionsReady extends DiscussionsState {
  final List<ChatModel> discussions;
  const DiscussionsReady({
    required this.discussions,
  });
}
