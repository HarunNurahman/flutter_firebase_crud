part of 'member_bloc.dart';

sealed class MemberState extends Equatable {
  const MemberState();

  @override
  List<Object> get props => [];
}

final class MemberInitial extends MemberState {}

// Create
final class AddMemberLoadingState extends MemberState {}

final class AddMemberSuccessState extends MemberState {}

final class AddMemberErrorState extends MemberState {
  final String errorMessage;

  const AddMemberErrorState(this.errorMessage);
}

// Read
final class ReadMemberLoadingState extends MemberState {}

final class ReadMemberEmptyState extends MemberState {}

final class ReadMemberSuccessState extends MemberState {
  final MemberModel member;

  const ReadMemberSuccessState(this.member);
}

final class ReadMemberErrorState extends MemberState {
  final String errorMessage;

  const ReadMemberErrorState(this.errorMessage);
}

// Read all
final class ReadAllMemberLoadingState extends MemberState {}

final class ReadAllMemberEmptyState extends MemberState {}

final class ReadAllMemberSuccessState extends MemberState {
  final List<MemberModel> members;

  const ReadAllMemberSuccessState(this.members);
}

final class ReadAllMemberErrorState extends MemberState {
  final String errorMessage;

  const ReadAllMemberErrorState(this.errorMessage);
}

// Delete
final class DeleteMemberLoadingState extends MemberState {}

final class DeleteMemberSuccessState extends MemberState {}

final class DeleteMemberErrorState extends MemberState {
  final String errorMessage;

  const DeleteMemberErrorState(this.errorMessage);
}

// Update
final class UpdateMemberLoadingState extends MemberState {}

final class UpdateMemberSuccessState extends MemberState {
  final MemberModel member;

  const UpdateMemberSuccessState(this.member);
}

final class UpdateMemberErrorState extends MemberState {
  final String errorMessage;

  const UpdateMemberErrorState(this.errorMessage);
}
