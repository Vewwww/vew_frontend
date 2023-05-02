// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vewww/bloc/select_choice_cubit/select_choice_cubit.dart';

// import '../style/app_colors.dart';

// class AppRadioButton extends StatelessWidget {
//   List<String> choices;
//   var state;
//   AppRadioButton({required this.choices, this.state, Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     SelectChoiceCubit selectChoiceCubit = SelectChoiceCubit.get(context);
//     print(choices.length);
//     return BlocConsumer<SelectChoiceCubit, SelectChoiceState>(
//       listener: (context, snapshot) {},
//       builder: (context, snapshot) {
//         return Container(
//           height: 50,
//           width: double.infinity,
//           child: ListView.builder(
//               scrollDirection:
//                   (choices.length > 2) ? Axis.vertical : Axis.horizontal,
//               itemCount: choices.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width / choices.length,
//                     child: ListTile(
//                       leading: Radio<int>(
//                           value: index,
//                           activeColor: mainColor,
//                           groupValue: selectChoiceCubit.choice,
//                           onChanged: (val) {
//                             print("val:$val");
//                             (val != null)
//                                 ? selectChoiceCubit.chose(val, state: state)
//                                 : selectChoiceCubit.chose(-1, state: state);
//                           }),
//                       title: Text(choices[index]),
//                     ),
//                   ),
//                 );
//               }),
//         );
//       },
//     );
//   }
// }
