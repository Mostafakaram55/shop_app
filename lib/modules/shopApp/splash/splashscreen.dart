import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/productscreen/products.dart';
import 'package:shop_app/modules/shopApp/login/log_in.dart';
import 'package:shop_app/modules/shoplayaout/shoplayout.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: AnimatedSplashScreen(
        duration: 400,
          splashIconSize: 250,
          backgroundColor:Color.fromRGBO(33, 24, 143, 1),
          splash: Image(
            image:AssetImage(
              'imag/yora.jpg',
            ),
          ),
          nextScreen:ShopLayout(),
      ),
    );
  }
}
