import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_crud/core/configs/divider_constant.dart';
import 'package:flutter_firebase_crud/core/configs/themes.dart';
import 'package:flutter_firebase_crud/modules/bloc/auth/auth_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserDataModel> users = [
    UserDataModel(
      name: 'Bambang Pamungkas',
      email: 'bambang@email.com',
      phone: '08123456789',
    ),
    UserDataModel(
      name: 'Taufik Hidayat',
      email: 'taufik@email.com',
      phone: '08123456789',
    ),
    UserDataModel(
      name: 'Markus Horison',
      email: 'markus@email.com',
      phone: '08123456789',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: blueColor,
        onPressed: () {
          Navigator.pushNamed(context, '/form-data');
        },
        child: Icon(Icons.add, color: whiteColor),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthInitial) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                      (route) => false,
                    );
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
                                      context.read<AuthBloc>().add(
                                        AuthLogoutEvent(),
                                      );
                                    },
                                    child: Text(
                                      'Logout',
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
              divide24,
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final user = users[index];
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
                                    user.name,
                                    style: blackTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                  Text(user.email, style: blackTextStyle),
                                  Text(user.phone, style: blackTextStyle),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/form-data');
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
                                      title: Text('Delete'),
                                      content: Text(
                                        'Are you sure want to delete?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              users.removeAt(index);
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Text('Delete'),
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
                  itemCount: users.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserDataModel {
  final String name;
  final String email;
  final String phone;

  UserDataModel({required this.name, required this.email, required this.phone});
}
