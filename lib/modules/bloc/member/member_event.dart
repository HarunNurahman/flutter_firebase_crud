part of 'member_bloc.dart';

sealed class MemberEvent extends Equatable {
  const MemberEvent();

  @override
  List<Object> get props => [];
}

// Create member event
final class CreateMemberEvent extends MemberEvent {
  final String userId;
  final MemberModel member;

  const CreateMemberEvent(this.userId, this.member);
}

// Read member event
final class GetMemberEvent extends MemberEvent {
  final String userId;
  final String memberId;

  const GetMemberEvent(this.userId, this.memberId);
}

// Read all member event
final class GetAllMemberEvent extends MemberEvent {
  final String userId;

  const GetAllMemberEvent(this.userId);
}

// Delete member event
final class DeleteMemberEvent extends MemberEvent {
  final String userId;
  final String memberId;

  const DeleteMemberEvent(this.userId, this.memberId);
}

// Update member event
final class EditMemberEvent extends MemberEvent {
  final String userId;
  final String memberId;
  final MemberModel member;

  const EditMemberEvent(this.userId, this.memberId, this.member);
}
