import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_crud/core/configs/divider_constant.dart';
import 'package:flutter_firebase_crud/core/configs/themes.dart';
import 'package:flutter_firebase_crud/modules/bloc/auth/auth_bloc.dart';
import 'package:flutter_firebase_crud/modules/bloc/member/member_bloc.dart';
import 'package:flutter_firebase_crud/modules/models/member/member_model.dart';
import 'package:flutter_firebase_crud/modules/presentation/pages/home/form_data_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final memberBloc = MemberBloc();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  List<MemberModel> members = [];

  _getBloc() {
    memberBloc.add(GetAllMemberEvent(userId));
  }

  @override
  void initState() {
    super.initState();
    _getBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: blueColor,
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/form-data');
          if (result == true) {
            _getBloc();
          }
        },
        child: Icon(Icons.add, color: whiteColor),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [buildHeader(), divide24, buildMemberList()],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthInitial) {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            }
          },
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dashboard',
                  style: blackTextStyle.copyWith(
                    fontSize: 32,
                    fontWeight: semiBold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: whiteColor,
                          title: Text('Logout?'),
                          content: Text('Are you sure want to logout?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(AuthLogoutEvent());
                              },
                              child: Text(
                                'Logout',
                                style: blackTextStyle.copyWith(color: redColor),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Logout',
                    style: blackTextStyle.copyWith(color: redColor),
                  ),
                ),
              ],
            );
          },
        ),
        divide24,
        Text(
          DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()),
          style: blackTextStyle,
        ),
      ],
    );
  }

  Widget buildMemberList() {
    return BlocProvider(
      create: (context) => memberBloc,
      child: BlocConsumer<MemberBloc, MemberState>(
        listener: (context, state) {
          if (state is ReadAllMemberSuccessState) {
            members = state.members;
          } else if (state is ReadAllMemberErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage, style: whiteTextStyle),
                backgroundColor: redColor,
              ),
            );
          }

          if (state is DeleteMemberSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Member deleted successfully',
                  style: whiteTextStyle,
                ),
                backgroundColor: redColor,
              ),
            );
            _getBloc();
          } else if (state is DeleteMemberErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage, style: whiteTextStyle),
                backgroundColor: redColor,
              ),
            );
          }
        },
        builder: (context, state) {
          print('Current State: $state');
          if (state is ReadAllMemberLoadingState ||
              state is DeleteMemberLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReadAllMemberEmptyState) {
            return Expanded(
              child: Center(
                child: Text(
                  'No data',
                  style: blackTextStyle.copyWith(fontSize: 16),
                ),
              ),
            );
          }
          return Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                MemberModel member = members[index];
                return Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Ink(
                          color: Colors.transparent,
                          child: Column(
                            spacing: 4,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member.name!,
                                style: blackTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: semiBold,
                                ),
                              ),
                              Text(member.email!, style: blackTextStyle),
                              Text(member.phone!, style: blackTextStyle),
                              Text(member.address!, style: blackTextStyle),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => FormDataScreen(member: member),
                              ),
                            );
                            if (result == true) {
                              _getBloc();
                            }
                          },
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.edit),
                          color: blueColor,
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: whiteColor,
                                  title: Text(
                                    'Delete',
                                    style: blackTextStyle.copyWith(
                                      fontSize: 24,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                  content: Text(
                                    'Are you sure want to delete?',
                                    style: blackTextStyle,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: blackTextStyle,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        memberBloc.add(
                                          DeleteMemberEvent(userId, member.id!),
                                        );

                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Delete',
                                        style: blackTextStyle.copyWith(
                                          color: redColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.delete),
                          color: redColor,
                        ),
                      ],
                    ),
                  ],
                );
              },
              separatorBuilder:
                  (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(),
                  ),
              itemCount: members.length,
            ),
          );
        },
      ),
    );
  }
}
