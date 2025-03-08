import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_crud/core/configs/divider_constant.dart';
import 'package:flutter_firebase_crud/core/configs/themes.dart';
import 'package:flutter_firebase_crud/core/configs/validator.dart';
import 'package:flutter_firebase_crud/modules/bloc/auth/auth_bloc.dart';
import 'package:flutter_firebase_crud/modules/presentation/widgets/custom_button.dart';
import 'package:flutter_firebase_crud/modules/presentation/widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),

            child: Form(
              key: formKey,
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Register',
                    style: blackTextStyle.copyWith(
                      fontSize: 32,
                      fontWeight: semiBold,
                    ),
                  ),
                  divide8,
                  CustomTextField(
                    controller: nameController,
                    label: 'Name',
                    hintText: 'Enter your name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    controller: emailController,
                    label: 'Email',
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                  CustomTextField(
                    controller: phoneController,
                    label: 'Mobile Phone',
                    hintText: 'Enter your phone number',
                    keyboardType: TextInputType.number,
                    validator: phoneValidator,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    label: 'Password',
                    hintText: 'Enter your password',
                    isObsecure: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthRegisterSuccessState) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/login',
                          (route) => false,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Register success, please login',
                              style: whiteTextStyle,
                            ),
                            backgroundColor: greenColor,
                          ),
                        );
                      } else if (state is AuthRegisterErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.errorMessage,
                              style: whiteTextStyle,
                            ),
                            backgroundColor: redColor,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthRegisterLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return CustomButton(
                        label: 'Register',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              AuthRegisterEvent(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
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
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text(
                        'Already have an account? Login',
                        style: blackTextStyle.copyWith(color: blueColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
