import 'package:ent5m/constants/Colors.dart';
import 'package:flutter/material.dart';

class MyGridTile extends StatelessWidget {
  const MyGridTile({Key? key, required this.icon, required this.onTap}) : super(key: key);

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Make Material widget transparent

      child: Ink(
        decoration: BoxDecoration(
          color: myPrimary,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.grey, width: 0.2),
        ),
        child: InkWell(
          splashColor: Colors.green.shade900,
          onTap: onTap,
          borderRadius: BorderRadius.circular(20), // Match the border radius

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  // height: 20,
                  // width: 70,
                  child: Icon(
                icon,
                size: 30,
              )),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
