import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_crud/core/configs/divider_constant.dart';
import 'package:flutter_firebase_crud/core/configs/themes.dart';
import 'package:flutter_firebase_crud/core/configs/validator.dart';
import 'package:flutter_firebase_crud/modules/bloc/member/member_bloc.dart';
import 'package:flutter_firebase_crud/modules/models/member/member_model.dart';
import 'package:flutter_firebase_crud/modules/presentation/widgets/custom_button.dart';
import 'package:flutter_firebase_crud/modules/presentation/widgets/custom_textfield.dart';

class FormDataScreen extends StatefulWidget {
  final MemberModel? member;

  const FormDataScreen({super.key, this.member});

  @override
  State<FormDataScreen> createState() => _FormDataScreenState();
}

class _FormDataScreenState extends State<FormDataScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.member != null) {
      nameController.text = widget.member!.name!;
      emailController.text = widget.member!.email!;
      phoneController.text = widget.member!.phone!;
      addressController.text = widget.member!.address!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MemberBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: BlocConsumer<MemberBloc, MemberState>(
              listener: (context, state) {
                if (state is AddMemberSuccessState ||
                    state is UpdateMemberSuccessState) {
                  Navigator.pop(context, true);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state is AddMemberSuccessState
                            ? 'Member added successfully'
                            : 'Member updated successfully',
                        style: whiteTextStyle,
                      ),
                      backgroundColor: greenColor,
                    ),
                  );
                } else if (state is AddMemberErrorState ||
                    state is UpdateMemberErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        (state as AddMemberErrorState).errorMessage,
                        style: whiteTextStyle,
                      ),
                      backgroundColor: redColor,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AddMemberLoadingState ||
                    state is UpdateMemberLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Form(
                  key: formKey,
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.member == null ? 'Add New Data' : 'Edit Member',
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
                        keyboardType: TextInputType.number,
                        validator: phoneValidator,
                      ),
                      CustomTextField(
                        controller: addressController,
                        label: 'Address',
                        hintText: 'Enter address',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter address';
                          }
                          return null;
                        },
                      ),
                      CustomButton(
                        label: 'Save',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final member = MemberModel(
                              id: widget.member?.id,
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              address: addressController.text,
                            );
                            final userId =
                                FirebaseAuth.instance.currentUser!.uid;
                            if (widget.member == null) {
                              context.read<MemberBloc>().add(
                                CreateMemberEvent(userId, member),
                              );
                            } else {
                              context.read<MemberBloc>().add(
                                EditMemberEvent(
                                  userId,
                                  widget.member!.id!,
                                  member,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
