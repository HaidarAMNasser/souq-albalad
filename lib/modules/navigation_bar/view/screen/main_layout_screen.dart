import 'package:souq_al_balad/modules/navigation_bar/controller/bottom_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavigationController controller = Get.put(
      BottomNavigationController(),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {},
        physics: const NeverScrollableScrollPhysics(),
        children: controller.getPages(),
      ),
      bottomNavigationBar: CustomBottomNavBar(controller: controller),
    );
  }
}

class CustomBottomNavBar extends StatefulWidget {
  final BottomNavigationController controller;

  const CustomBottomNavBar({super.key, required this.controller});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
              widget.controller.navItems.asMap().entries.map((entry) {
                int index = entry.key;
                BottomNavItem item = entry.value;

                return _buildNavItem(item, index);
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildNavItem(BottomNavItem item, int index) {
    bool isActive = widget.controller.isTabActive(index);

    // الزر الوسط (إضافة) له تصميم خاص
    if (item.isCenter) {
      return _buildCenterButton(item, index);
    }

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        widget.controller.changeTab(index,context: context);
      },
      child: AnimatedBuilder(
        animation: widget.controller.scaleAnimations[index],
        builder: (context, child) {
          return Transform.scale(
            scale: widget.controller.scaleAnimations[index].value,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                          isActive
                              ? item.activeColor.withOpacity(
                                0.1,
                              ) // استخدام activeColor مع شفافية
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      isActive ? item.activeIcon : item.icon,
                      color:
                          isActive
                              ? item
                                  .activeColor // ✅ لون نشط: #F49719
                              : item.inactiveColor, // ✅ لون غير نشط: #008081
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Text(
                  //   item.label,
                  //   style: TextStyle(
                  //     fontSize: 10,
                  //     fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  //     color: isActive
                  //         ? item.activeColor    // ✅ لون النص النشط: #F49719
                  //         : item.inactiveColor, // ✅ لون النص غير النشط: #008081
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCenterButton(BottomNavItem item, int index) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        widget.controller.changeTab(index,context: context);
      },
      child: AnimatedBuilder(
        animation: widget.controller.scaleAnimations[index],
        builder: (context, child) {
          return Transform.scale(
            scale: widget.controller.scaleAnimations[index].value,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: item.activeColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: item.activeColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            ),
          );
        },
      ),
    );
  }
}
