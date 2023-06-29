part of 'admin_add_cubit.dart';

@immutable
abstract class AdminAddState {}

class AdminAddInitial extends AdminAddState {}
class AddAdminLoadingState extends AdminAddState {}
class AddAdminSuccessState extends AdminAddState {}
class AddAdminErrorState extends AdminAddState {}

class AddSignLoadingState extends AdminAddState {}
class AddSignSuccessState extends AdminAddState {}
class AddSignErrorState extends AdminAddState {}