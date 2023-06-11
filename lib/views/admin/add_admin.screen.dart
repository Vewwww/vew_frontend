import 'package:flutter/material.dart';
import '../../core/components/backward_arrow.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/default_button.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';

class AddAdminScreen extends StatefulWidget {
  const AddAdminScreen({Key? key}) : super(key: key);

  @override
  _AddAdminScreenState createState() => _AddAdminScreenState();
}

class _AddAdminScreenState extends State<AddAdminScreen> {
  @override
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var nationalIDController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                CustomAppBar(
                  haveBackArrow: true,
                  title: Text(
                    "Add Admin",
                    style: AppTextStyle.mainStyle(size: 25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CustomTextField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '*Required';
                            }
                            return null;
                          },
                          label: 'Name'),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '*Required';
                            }
                            return null;
                          },
                          label: 'Phone Number'),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                          controller: nationalIDController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '*Required';
                            }
                            return null;
                          },
                          label: 'NationalID'),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: emailController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*Required';
                          }
                          return null;
                        },
                        label: 'Email Address',
                        prefix: const Icon(Icons.email),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*Required';
                          }
                          return null;
                        },
                        label: 'Password',
                        prefix: const Icon(Icons.lock),
                        suffix: const Icon(Icons.remove_red_eye),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      defaultButton(
                          function: () {
                            final form = formKey.currentState;
                            if (form!.validate()) {
                              // take data in a model here
                            }
                          },
                          text: 'Add')
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
