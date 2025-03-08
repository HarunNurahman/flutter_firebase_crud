import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_crud/core/services/data/member_service.dart';
import 'package:flutter_firebase_crud/modules/models/member/member_model.dart';

part 'member_event.dart';
part 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final MemberService memberService;

  MemberBloc({MemberService? member})
    : memberService = member ?? MemberService(),
      super(MemberInitial()) {
    on<CreateMemberEvent>(_createMemberEvent);
    on<GetMemberEvent>(_getMemberEvent);
    on<GetAllMemberEvent>(_getAllMemberEvent);
    on<DeleteMemberEvent>(_deleteMemberEvent);
    on<EditMemberEvent>(_editMemberEvent);
  }

  _createMemberEvent(CreateMemberEvent event, Emitter<MemberState> emit) async {
    try {
      emit(AddMemberLoadingState());
      await memberService.createMember(event.userId, event.member);
      emit(AddMemberSuccessState());
    } catch (e) {
      emit(AddMemberErrorState(e.toString()));
    }
  }

  _getMemberEvent(GetMemberEvent event, Emitter<MemberState> emit) async {
    try {
      emit(ReadMemberLoadingState());
      MemberModel member = await memberService.getMember(
        event.userId,
        event.memberId,
      );
      emit(ReadMemberSuccessState(member));
    } catch (e) {
      emit(ReadMemberErrorState(e.toString()));
    }
  }

  _getAllMemberEvent(GetAllMemberEvent event, Emitter<MemberState> emit) async {
    try {
      emit(ReadAllMemberLoadingState());
      List<MemberModel> members = await memberService.getAllMembers(
        event.userId,
      );
      if (members.isEmpty) {
        emit(ReadAllMemberEmptyState());
      } else {
        emit(ReadAllMemberSuccessState(members));
      }
    } catch (e) {
      emit(ReadAllMemberErrorState(e.toString()));
    }
  }

  _deleteMemberEvent(DeleteMemberEvent event, Emitter<MemberState> emit) async {
    try {
      emit(DeleteMemberLoadingState());
      await memberService.deleteMember(event.userId, event.memberId);
      emit(DeleteMemberSuccessState());
    } catch (e) {
      emit(DeleteMemberErrorState(e.toString()));
    }
  }

  _editMemberEvent(EditMemberEvent event, Emitter<MemberState> emit) async {
    try {
      emit(UpdateMemberLoadingState());
      await memberService.updateMember(
        event.userId,
        event.memberId,
        event.member,
      );
      emit(UpdateMemberSuccessState(event.member));
    } catch (e) {
      emit(UpdateMemberErrorState(e.toString()));
    }
  }
}
