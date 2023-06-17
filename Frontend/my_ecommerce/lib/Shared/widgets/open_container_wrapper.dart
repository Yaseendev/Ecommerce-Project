import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:my_ecommerce/Utils/constants.dart';

class OpenContainerWrapper extends StatelessWidget {
  final Widget openWidget;
  const OpenContainerWrapper({
    required this.closedBuilder,
    required this.transitionType,
    required this.openWidget,
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      closedColor: AppColors.BACKGROUND_COLOR,
      middleColor: Colors.transparent,
      openColor: Colors.transparent,
      transitionType: transitionType,
      openBuilder: (context, openContainer) => openWidget,
      tappable: false,
      closedBuilder: closedBuilder,
      closedElevation: 0,
    );
  }
}
