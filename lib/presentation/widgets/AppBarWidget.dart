import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machinetest/core/colors/colors.dart';

class AppBarWidget extends StatelessWidget {
  final Icon? icons;
  final bool? leadingIcon;
  const AppBarWidget({super.key, this.icons, this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(),
          Center(
            child: Text(
              'Ricky and Morty',
              style: TextStyle(fontSize: 20, color: colorwhite),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
