import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/get_all_cubit/get_all_cubit.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/custom_text_field.dart';

class OtherUsersScreen extends StatefulWidget {
  OtherUsersScreen({super.key, required this.id, required this.role});
  String id;
  String role;
  @override
  State<OtherUsersScreen> createState() => _OtherUsersScreenState(id, role);
}

class _OtherUsersScreenState extends State<OtherUsersScreen> {
  String id;
  String role;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _reportNum = TextEditingController();
  final TextEditingController _rating = TextEditingController();
  final TextEditingController _ratingNum = TextEditingController();
  _OtherUsersScreenState(this.id, this.role);

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
          if (state is GetWinchWithIdSuccessState) {
            _name.text = state.winchDriver.name!;
            _email.text = state.winchDriver.email!;
            _phone.text = state.winchDriver.phoneNumber!;
            _reportNum.text = state.winchDriver.report as String;
            _rating.text = state.winchDriver.rate as String;
            _ratingNum.text = state.winchDriver.numOfRates as String;
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
              CustomTextField(
                validator: (value) {},
                label: 'Rating',
                controller: _rating,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                validator: (value) {},
                label: 'Number of ratings',
                controller: _ratingNum,
              ),
              SizedBox(
                height: 15,
              ),
            ]);
          } else if (state is GetMechanicWithIdSuccessState) {
            _name.text = state.mechanicShop.name!;
            _email.text = state.mechanicShop.email!;
            _phone.text = state.mechanicShop.phoneNumber!;
            _reportNum.text = state.mechanicShop.report as String;
            _rating.text = state.mechanicShop.rate as String;
            _ratingNum.text = state.mechanicShop as String;
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
              CustomTextField(
                validator: (value) {},
                label: 'Rating',
                controller: _rating,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                validator: (value) {},
                label: 'Number of ratings',
                controller: _ratingNum,
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
