import 'package:flutter/material.dart';
import 'package:flutter_animate/animation_flutterway/screens/deatils/details_screen.dart';
import 'package:flutter_animate/animation_flutterway/screens/home/components/header.dart';
import 'package:flutter_animate/animation_flutterway/screens/home/components/product_card.dart';

import '../models/Product.dart';
import 'constants.dart';
import 'controllers/home_controller.dart';

class TextHomeScreen extends StatefulWidget {
  const TextHomeScreen({Key? key}) : super(key: key);

  @override
  State<TextHomeScreen> createState() => _TextHomeScreenState();
}

class _TextHomeScreenState extends State<TextHomeScreen> {
  final controller = HomeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Color(0xFFEAEAEA),
          child: Column(
            children: [
              HomeHeader(),
              Container(
                padding:  EdgeInsets.symmetric(
                    horizontal: defaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft:
                    Radius.circular(defaultPadding * 1.5),
                    bottomRight:
                    Radius.circular(defaultPadding * 1.5),
                  ),
                ),
                child: GridView.builder(
                  itemCount: demo_products.length,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    mainAxisSpacing: defaultPadding,
                    crossAxisSpacing: defaultPadding,
                  ),
                  itemBuilder: (context, index) => ProductCard(
                    product: demo_products[index],
                    press: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration:
                          const Duration(milliseconds: 500),
                          reverseTransitionDuration:
                          const Duration(milliseconds: 500),
                          pageBuilder: (context, animation,
                              secondaryAnimation) =>
                              FadeTransition(
                                opacity: animation,
                                child: DetailsScreen(
                                  product: demo_products[index],
                                  onProductAdd: () {
                                    controller.addProductToCart(
                                        demo_products[index]);
                                  },
                                ),
                              ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
