import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Utils/enums.dart';

class OrderStatusStepper extends StatelessWidget {
  const OrderStatusStepper({
    super.key,
    required this.currentStep,
    required this.status,
  });

  final int currentStep;
  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: currentStep,
      steps: [
        EasyStep(
          activeIcon: const Icon(Icons.list_alt_rounded),
          icon: const Icon(Icons.list_alt_rounded),
          customTitle: Text(
            'Placed',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: currentStep == 0 ? FontWeight.bold : null,
            ),
          ),
          finishIcon: const Icon(Icons.check_rounded),
        ),
        EasyStep(
          activeIcon: Icon(
              status == OrderStatus.REJECTED || status == OrderStatus.CANCELED
                  ? Icons.close_rounded
                  : Icons.inventory_rounded),
          icon: const Icon(Icons.inventory_rounded),
          finishIcon: const Icon(Icons.check_rounded),
          customTitle: Text(
            status == OrderStatus.REJECTED || status == OrderStatus.CANCELED
                ? status.label
                : 'Review',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: currentStep == 1 ? FontWeight.bold : null,
            ),
          ),
        ),
        EasyStep(
          activeIcon: const Icon(Icons.inventory_2_rounded),
          icon: const Icon(Icons.inventory_2_rounded),
          finishIcon: const Icon(Icons.check_rounded),
          customTitle: Text(
            'Packing',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: currentStep == 2 ? FontWeight.bold : null,
            ),
          ),
        ),
        EasyStep(
          activeIcon: const Icon(Icons.local_shipping_rounded),
          icon: const Icon(Icons.local_shipping_rounded),
          finishIcon: const Icon(Icons.check_rounded),
          customTitle: Text(
            'Delivering',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: currentStep == 3 ? FontWeight.bold : null,
            ),
          ),
        ),
        EasyStep(
          activeIcon: const Icon(Icons.check_circle),
          icon: const Icon(Icons.check_circle),
          finishIcon: const Icon(Icons.check_circle),
          customTitle: Text(
            'Delivered',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: currentStep == 4 ? FontWeight.bold : null,
            ),
          ),
        ),
      ],
      activeLineColor: Colors.grey,
      activeStepBackgroundColor:
          status == OrderStatus.REJECTED || status == OrderStatus.CANCELED
              ? Colors.red
              : AppColors.PRIMARY_COLOR,
      activeStepBorderType: BorderType.normal,
      finishedStepBackgroundColor: Colors.green,
      finishedStepBorderType: BorderType.normal,
      lineType: LineType.normal,
      showLoadingAnimation: false,
      activeStepIconColor: Colors.white,
      // showStepBorder: false,
      borderThickness: 4,
      enableStepTapping: false,
      finishedLineColor: Colors.green,
      //unreachedStepBackgroundColor: Colors.grey,
      //AppColors.PRIMARY_COLOR,
      disableScroll: true,
      unreachedLineColor: Colors.grey,
      activeStepBorderColor:
          status == OrderStatus.REJECTED || status == OrderStatus.CANCELED
              ? Colors.red
              : AppColors.PRIMARY_COLOR,
    );
  }
}
