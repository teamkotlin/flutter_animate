import 'package:flutter/material.dart';
import 'package:flutter_animate/animation_flutterway/screens/deatils/details_screen.dart';
import 'package:flutter_animate/animation_flutterway/screens/home/components/cart_details_view.dart';
import 'package:flutter_animate/animation_flutterway/screens/home/components/cart_short_view.dart';
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

  void _onDragVertical(DragUpdateDetails details) {
    if (details.primaryDelta! < -0.7) {
      controller.changeHomeState(HomeState.cart);
    } else if (details.primaryDelta! > 1) {
      controller.changeHomeState(HomeState.normal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Color(0xFFEAEAEA),
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) =>
                LayoutBuilder(builder: (context, BoxConstraints constraints) {
              return Stack(
                children: [
                  AnimatedPositioned(
                    duration: panelTransition,
                    top: controller.homeState == HomeState.normal
                        ? headerHeight
                        : -(constraints.maxHeight -
                            headerHeight * 2 -
                            cartBarHeight),
                    left: 0,
                    right: 0,
                    height:
                        constraints.maxHeight - headerHeight - cartBarHeight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(defaultPadding * 1.5),
                          bottomRight: Radius.circular(defaultPadding * 1.5),
                        ),
                      ),
                      child: GridView.builder(
                        itemCount: demo_products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
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
                    ),
                  ),
                  AnimatedPositioned(
                      duration: panelTransition,
                      bottom: 0,
                      height: controller.homeState == HomeState.normal
                          ? cartBarHeight
                          : constraints.maxHeight - headerHeight,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onVerticalDragUpdate: _onDragVertical,
                        child: Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(defaultPadding),
                            color: const Color(0xffeaeaea),
                            child: AnimatedSwitcher(
                              duration: panelTransition,
                              child: controller.homeState == HomeState.normal
                                  ? CardShortView(
                                      controller: controller,
                                    )
                                  : CartDetailsView(controller: controller),
                            )),
                      )),
                  AnimatedPositioned(
                      duration: panelTransition,
                      top: controller.homeState == HomeState.normal
                          ? 0
                          : -headerHeight,
                      left: 0,
                      right: 0,
                      height: headerHeight,
                      child: HomeHeader()),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
