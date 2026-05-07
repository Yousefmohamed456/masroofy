import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
///////////
class SliderController extends GetxController {
  static SliderController get instance => Get.find();

  final carousalController = CarouselSliderController();
  final carousalCurrentIndex = 0.obs;

  void updatePageIndicator(index) => carousalCurrentIndex.value = index;

  void dotNavigationClick(index) {
    carousalCurrentIndex.value = index;
    carousalController.jumpToPage(index);
  }
}
