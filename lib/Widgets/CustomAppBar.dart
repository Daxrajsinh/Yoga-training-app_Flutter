import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  AnimationController animationController;
  Animation colorsTween, homeTween, yogaTween, iconTween, drawerTween;
  Function()? onPressed;

  CustomAppBar({
    required this.animationController,
    required this.colorsTween,
    required this.drawerTween,
    required this.homeTween,
    required this.iconTween,
    required this.onPressed,
    required this.yogaTween,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.dehaze,
              color: drawerTween.value,
            ),
            onPressed: onPressed,
          ),
          backgroundColor: colorsTween.value,
          elevation: 0,
          title: Row(
            children: [
              Transform.translate(
                offset: Offset(35.0, 0.0), // Customize the left alignment in pixels
                child: Text(
                  "HOME ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                      fontFamily: 'Raleway',
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(45.0, 0.0), // Customize the right alignment in pixels
                child: Text(
                  "YOGA",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                      fontFamily: 'Raleway',
                  ),
                ),
              ),
            ],
          ),
          actions: [],
        ),
      ),
    );
  }
}
