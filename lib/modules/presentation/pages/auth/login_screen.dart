import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_crud/core/configs/divider_constant.dart';
import 'package:flutter_firebase_crud/core/configs/themes.dart';
import 'package:flutter_firebase_crud/core/configs/validator.dart';
import 'package:flutter_firebase_crud/modules/bloc/auth/auth_bloc.dart';
import 'package:flutter_firebase_crud/modules/presentation/widgets/custom_button.dart';
import 'package:flutter_firebase_crud/modules/presentation/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   super.initState();
  //   context.read<AuthBloc>().add(AuthCheckCurrentUserEvent());
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthCheckCurrentUserSuccessState) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }

        if (state is AuthLoginSuccessState) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else if (state is AuthLoginErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        if (state is AuthCheckCurrentUserLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: blackTextStyle.copyWith(
                        fontSize: 32,
                        fontWeight: semiBold,
                      ),
                    ),
                    divide8,
                    CustomTextField(
                      controller: emailController,
                      label: 'Email',
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      validator: emailValidator,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      label: 'Password',
                      hintText: 'Enter your password',
                      isObsecure: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoginLoadingState) {
                          return Center(
                            child: const CircularProgressIndicator(),
                          );
                        }
                        return CustomButton(
                          label: 'Login',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                AuthLoginEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                    Center(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          'Create an account',
                          style: blackTextStyle.copyWith(color: blueColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
