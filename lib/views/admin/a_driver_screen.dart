import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/custom_text_field.dart';

import '../../bloc/get_all_cubit/get_all_cubit.dart';
import '../../model/driver.dart';

class ADriverScreen extends StatefulWidget {
  ADriverScreen({super.key, required this.id, required this.role});
  String id;
  String role;

  @override
  State<ADriverScreen> createState() => _ADriverScreenState(id,role);
}

class _ADriverScreenState extends State<ADriverScreen> {
  String id;
  String role;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _reportNum = TextEditingController();
  final TextEditingController _carType = TextEditingController();

  _ADriverScreenState(this.id, this.role);
  @override
  void initState() {
    super.initState();
    final getAllCubit = context.read<GetAllCubit>();
    getAllCubit.getUserWithId(id, role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetAllCubit, GetAllState>(
        builder: (context, state) {
          if (state is GetDriverWithIdSuccessState) {
            _name.text = state.driver.person!.name!;
            _reportNum.text = state.driver.person!.report! as String;
            //_carType.text=state.driver.cars
            _email.text = state.driver.person!.email!;
            _phone.text = state.driver.person!.phoneNumber!;
            return Column(children: [
              CustomAppBar(
                haveBackArrow: true,
                haveLogo: true,
              ),
              CustomTextField(
                validator: (value) {},
                label: 'Name',
                controller: _name,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                validator: (value) {},
                label: 'Email',
                controller: _email,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                validator: (value) {},
                label: 'Phone Number',
                controller: _phone,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                validator: (value) {},
                label: 'Number of Reports',
                controller: _reportNum,
              ),
              SizedBox(
                height: 15,
              ),
            ]);
          } else {
            return Column(children: [
              CustomAppBar(
                haveBackArrow: true,
                haveLogo: true,
              ),
              CircularProgressIndicator(),
            ]);
          }
        },
      ),
    );
  }
}
