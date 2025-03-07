import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/core/configs/divider_constant.dart';
import 'package:flutter_firebase_crud/core/configs/themes.dart';
import 'package:flutter_firebase_crud/core/configs/validator.dart';
import 'package:flutter_firebase_crud/modules/presentation/widgets/custom_button.dart';
import 'package:flutter_firebase_crud/modules/presentation/widgets/custom_textfield.dart';

class FormDataScreen extends StatefulWidget {
  const FormDataScreen({super.key});

  @override
  State<FormDataScreen> createState() => _FormDataScreenState();
}

class _FormDataScreenState extends State<FormDataScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Form(
            key: formKey,
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add New Data',
                  style: blackTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  ),
                ),
                divide24,
                CustomTextField(
                  controller: nameController,
                  label: 'Full Name',
                  hintText: 'Enter full name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter full name';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: emailController,
                  label: 'Email',
                  hintText: 'Enter valid email',
                  validator: emailValidator,
                ),
                CustomTextField(
                  controller: phoneController,
                  label: 'Phone Number',
                  hintText: 'Enter valid phone number',
                  validator: phoneValidator,
                ),
                CustomButton(
                  label: 'Save',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
