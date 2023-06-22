// import 'package:flutter/material.dart';

// class RatingBar extends StatelessWidget {
//   double? size;
//   double rating;
//   RatingBar(this.rating, {this.size = 30, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> _starList = [];
//     int realNumber = rating.floor();
//     int partNumber = ((rating - realNumber) * 10).ceil();
//     for (int i = 0; i < 5; i++) {
//       if (i < realNumber) {
//         _starList.add(Icon(Icons.star,
//             color: Theme.of(context).primaryColor, size: size));
//       } else if (i == realNumber) {
//         _starList.add(SizedBox(
//           height: size,
//           width: size,
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               Icon(Icons.star,
//                   color: Theme.of(context).primaryColor, size: size),
//               ClipRect(
//                 clipper: _Clipper(part: partNumber),
//                 child: Icon(Icons.star, color: Colors.grey, size: size),
//               )
//             ],
//           ),
//         ));
//       } else {
//         _starList.add(Icon(Icons.star, color: Colors.grey, size: size));
//       }
//     }
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: _starList,
//     );
//   }
// }

// class _Clipper extends CustomClipper<Rect> {
//   final int part;

//   _Clipper({required this.part});

//   @override
//   Rect getClip(Size size) {
//     return Rect.fromLTRB(
//       (size.width / 10) * part,
//       0.0,
//       size.width,
//       size.height,
//     );
//   }

//   @override
//   bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
// }

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vewww/core/style/app_colors.dart';

class RatingBar extends StatelessWidget {
  double size;
  double rating;
  RatingBar(this.rating, {this.size = 20, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RatingBarIndicator(
        itemSize: size,
        rating: rating,
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: Colors.amberAccent,
        ),
      ),
    );
  }
}
