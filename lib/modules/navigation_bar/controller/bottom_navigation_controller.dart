import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souq_al_balad/global/components/button_app.dart';
import 'package:souq_al_balad/global/components/show_dialog_app.dart';
import 'package:souq_al_balad/global/data/local/cache_helper.dart';
import 'package:souq_al_balad/global/endpoints/categories/models/category_model.dart';
import 'package:souq_al_balad/global/endpoints/categories/models/sub_category_model.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/key_shared.dart';
import 'package:souq_al_balad/modules/account/view/screen/upgrade_to_merchant_screen.dart';
import 'package:souq_al_balad/modules/add-ad/ui/add_ad_screen.dart';
import 'package:souq_al_balad/modules/account/view/screen/account_screen.dart';
import 'package:souq_al_balad/modules/favorites/view/screen/favorites_screen.dart';
import 'package:souq_al_balad/modules/sections/sub_sections/view/screen/subsections_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/view/screen/home_screen.dart';

class BottomNavigationController extends GetxController
    with GetTickerProviderStateMixin {
  final currentIndex = 0.obs;

  late PageController pageController;
  late List<AnimationController> animationControllers;
  late List<Animation<double>> scaleAnimations;
  late List<Animation<double>> fadeAnimations;

  int previousIndex = 0;

  static const Color inactiveColor = Color(0xFF008081);
  static const Color activeColor = Color(0xFFF49719);

  final List<BottomNavItem> navItems = [
    BottomNavItem(
      index: 0,
      label: 'الرئيسية',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      inactiveColor: inactiveColor,
      activeColor: activeColor,
    ),
    BottomNavItem(
      index: 1,
      label: 'المفضلة',
      icon: Icons.favorite_outline,
      activeIcon: Icons.favorite,
      inactiveColor: inactiveColor,
      activeColor: activeColor,
    ),
    BottomNavItem(
      index: 2,
      label: 'إضافة',
      icon: Icons.add,
      activeIcon: Icons.add,
      inactiveColor: inactiveColor,
      activeColor: activeColor,
      isCenter: true,
    ),
    BottomNavItem(
      index: 3,
      label: 'الفئات',
      icon: Icons.grid_view_outlined,
      activeIcon: Icons.grid_view,
      inactiveColor: inactiveColor,
      activeColor: activeColor,
    ),
    BottomNavItem(
      index: 4,
      label: 'الملف الشخصي',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      inactiveColor: inactiveColor,
      activeColor: activeColor,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
    _initializeAnimations();
    _startInitialAnimation();
  }

  @override
  void onClose() {
    _disposeControllers();
    super.onClose();
  }

  void _initializeControllers() {
    pageController = PageController();

    animationControllers = List.generate(
      navItems.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      ),
    );
  }

  void _initializeAnimations() {
    scaleAnimations =
        animationControllers
            .map(
              (controller) => Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: controller, curve: Curves.elasticOut),
              ),
            )
            .toList();

    fadeAnimations =
        animationControllers
            .map(
              (controller) => Tween<double>(begin: 0.5, end: 1.0).animate(
                CurvedAnimation(parent: controller, curve: Curves.easeInOut),
              ),
            )
            .toList();
  }

  void _startInitialAnimation() {
    Future.delayed(const Duration(milliseconds: 100), () {
      animationControllers[0].forward();
    });
  }

  void _disposeControllers() {
    pageController.dispose();
    for (var controller in animationControllers) {
      controller.dispose();
    }
  }

  Future<void> changeTab(
    int index, {
    required BuildContext context,
    List<CategoryModel>? categories,
    List<SubCategoryModel>? subCategories,
    int? selectedIndex,
  }) async {
    if (index == currentIndex.value) return;

    if (index == 2) {
      _handleAddAction(context);
      return;
    }

    previousIndex = currentIndex.value;
    currentIndex.value = index;

    await _animatePageTransition(index);
    _animateTabChange(index);
    _handleTabSpecificActions(index);
  }

  Future<void> _animatePageTransition(int index) async {
    int pageIndex = index > 2 ? index - 1 : index;

    await pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _animateTabChange(int newIndex) {
    animationControllers[previousIndex].reverse();
    animationControllers[newIndex].forward();

    Future.delayed(const Duration(milliseconds: 100), () {
      _addBounceEffect(newIndex);
    });
  }

  void _addBounceEffect(int index) {
    animationControllers[index].reverse();
    Future.delayed(const Duration(milliseconds: 50), () {
      animationControllers[index].forward();
    });
  }

  void _handleAddAction(BuildContext context) {
    if(CacheHelper.getData(key: accountType) != "customer") {
      Get.to(() => AddAdScreen());
    } else {
      showAnimatedDialog(
        context,
        Center(
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              width: 1.sw * 0.9,
              height: 160.h,
              padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Theme.of(context).scaffoldBackgroundColor
              ),
              child: Column(
                children: [
                  Text(
                    AppLocalization.of(context).translate("you_need_to_become_seller"),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                      text: AppLocalization.of(context).translate("upgrade"),
                      onPressed: () => Get.to(() => UpgradeToMerchantScreen())
                  )
                ],
              ),
            ),
          ),
        ),
        dismissible: true,
      );
    }
  }

  void _handleTabSpecificActions(int index) {
    switch (index) {
      case 0:
        _onHomeTabSelected();
        break;
      case 1:
        _onFavoritesTabSelected();
        break;
      case 2:
        _onAddAd();
        break;
      case 3:
        _onCategoriesTabSelected();
        break;
      case 4:
        _onProfileTabSelected();
        break;
    }
  }

  void _onHomeTabSelected() {
    print('تم اختيار تبويب الرئيسية');
  }

  void _onFavoritesTabSelected() {
    print('تم اختيار تبويب المفضلة');
  }

  void _onAddAd() {
    print('تم اختيار اضافةاعلان');
  }

  void _onCategoriesTabSelected() {
    print('تم اختيار تبويب الفئات');
  }

  void _onProfileTabSelected() {
    print('تم اختيار تبويب الملف الشخصي');
  }

  bool isTabActive(int index) {
    return currentIndex.value == index;
  }

  List<Widget> getPages() {
    return [
      HomeScreen(),
      FavoritesScreen(),
      SubsectionsScreen(
        categories: null,
        subCategories: null,
        selectedCategoryIndex: 0,
      ),
      AccountScreen(),
    ];
  }

  String get currentPageTitle {
    if (currentIndex.value == 2) {
      return navItems[previousIndex].label;
    }
    return navItems[currentIndex.value].label;
  }

  Color get currentTabColor {
    if (currentIndex.value == 2) {
      return navItems[previousIndex].activeColor;
    }
    return navItems[currentIndex.value].activeColor;
  }

  void goToTab(int index,BuildContext context) {
    if (index >= 0 && index < navItems.length && index != 2) {
      changeTab(index,context: context);
    }
  }

  void goToHome(BuildContext context) {
    goToTab(0,context);
  }

  void goToFavorites(BuildContext context) {
    goToTab(1,context);
  }

  void goToAddAd(BuildContext context) {
    goToTab(2,context);
  }

  void goToCategories(BuildContext context) {
    goToTab(3,context);
  }

  void goToProfile(BuildContext context) {
    goToTab(4,context);
  }
}

class BottomNavItem {
  final int index;
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final Color inactiveColor;
  final Color activeColor;
  final bool isCenter;

  BottomNavItem({
    required this.index,
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.inactiveColor,
    required this.activeColor,
    this.isCenter = false,
  });

  Color get color => activeColor;
}
