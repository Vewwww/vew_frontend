import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/auth_cubit/auth_cubit.dart';
import 'package:vewww/core/utils/sp_helper/cache_helper.dart';
import 'package:vewww/model/person.dart';
import 'package:vewww/views/admin/admin_home_screen.dart';
import 'package:vewww/views/common/choose_role_screen.dart';
import 'package:vewww/views/common/forgot_password_screen.dart';
import 'package:vewww/views/mechanic/mechanic_home_screen.dart';
import 'package:vewww/views/winch/winch_home_page.dart';
import '../../bloc/add_car_cubit/add_car_cubit.dart';
import '../../bloc/repairer_requests_cubit.dart/repairer_requests_cubit.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/logo.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';
import 'driver_home_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  IO.Socket? socket;

  initSocket(String id) {
    socket = IO.io("https://vewwwapi.onrender.com/", <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket!.connect();
    socket!.onConnect((_) {
      print('Connection established');
      socket!.emit('join-room', {'room': id});
      print('joined room');
    });
    socket!.on("new-request", (data) {
      print("new request created");
      var requestCubit = context.read<RepairerRequestsCubit>();
      String role = SharedPreferencesHelper.getData(key: "vewRole");
      if (role == "mechanic")
        requestCubit.mechanicUpComingRequests();
      else if (role == "winch") requestCubit.winchUpComingRequests();
    });
    socket!.onDisconnect((_) => print('Connection Disconnection'));
    socket!.onConnectError((err) => print(err));
    socket!.onError((err) => print(err));
  }

  @override
  Widget build(BuildContext context) {
    double constraintsHight = MediaQuery.of(context).size.height;
    AddCarCubit addCarCubit = AddCarCubit.get(context);
    AuthCubit authCubit = AuthCubit.get(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: constraintsHight / 10),
                  Center(child: Logo()),
                  SizedBox(height: constraintsHight / 60),
                  Text(
                    "Login",
                    style: AppTextStyle.titleTextStyle(20),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 1.2,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: "Email",
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    controller: _password,
                    label: "Password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Person person = Person(
                                email: _email.text, password: _password.text);
                            await authCubit.signIn(person);
                            if (authCubit.state is SignInSuccessState) {
                              String role = SharedPreferencesHelper.getData(
                                  key: "vewRole");
                              String id =
                                  SharedPreferencesHelper.getData(key: "vewId");
                              print("role is $role");
                              const snackBar = SnackBar(
                                  content: Text("Loged in successfully !"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Widget screen;
                              if (role == "user")
                                screen = const DriverHomeScreen();
                              else if (role == "winch") {
                                initSocket(id);
                                screen = WinchHomePage();
                              } else if (role == "admin")
                                screen = AdminHomeScreen();
                              else {
                                initSocket(id);
                                screen = MechanicHomeScreen();
                              }
                              NavigationUtils.navigateAndClearStack(
                                  context: context, destinationScreen: screen);
                            } else {
                              const snackBar = SnackBar(
                                  content:
                                      Text("Something went wrong try again !"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        },
                        child: (authCubit.state is SignInLoadingState)
                            ? const CircularProgressIndicator()
                            : const Text("Login"),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account?",
                        style: AppTextStyle.greyStyle(size: 16),
                      ),
                      TextButton(
                        child: Text("Sign Up",
                            style: AppTextStyle.titleTextStyle(14)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChooseRoleScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  TextButton(
                    child: Text("Forgot Password",
                        style: AppTextStyle.titleTextStyle(14)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Divider(
                        color: Color.fromARGB(255, 151, 151, 151),
                        thickness: 1,
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          "or continue with",
                          style: AppTextStyle.greyStyle(size: 12),
                        ),
                      ),
                      const Expanded(
                          child: Divider(
                        color: Color.fromARGB(255, 151, 151, 151),
                        thickness: 1,
                      )),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Image.asset("assets/images/google.png")),
                      InkWell(
                          onTap: () async {},
                          child: Image.asset("assets/images/Facebook.png")),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
