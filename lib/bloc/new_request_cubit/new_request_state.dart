part of 'new_request_cubit.dart';

@immutable
abstract class NewRequestState {}

class NewRequestInitial extends NewRequestState {}
class HasNewState extends NewRequestState {}
class NoNewRequestsState extends NewRequestState {}
