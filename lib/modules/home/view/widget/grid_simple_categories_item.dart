import 'package:souq_al_balad/global/endpoints/categories/models/category_model.dart';
import 'package:souq_al_balad/modules/home/view/widget/simple_category_item.dart';
import 'package:souq_al_balad/modules/navigation_bar/controller/bottom_navigation_controller.dart';
import 'package:souq_al_balad/modules/sections/sub_sections/view/screen/subsections_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridSimpleCategoriesItem extends StatelessWidget {
  final List<CategoryModel> categories;
  final int count;
  const GridSimpleCategoriesItem({
    required this.categories,
    required this.count,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final BottomNavigationController controller = Get.put(
      BottomNavigationController(),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: count,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
          // النسبة بين العرض والارتفاع
        ),
        itemBuilder: (context, index) {
          return SimpleCategoryItem(
            title: categories[index].name ?? '',
            imageUrl: categories[index].image ?? '',
            onTap: () async {
              /*
              BottomNavigationController bottomNavigationController =
                  BottomNavigationController();
              bottomNavigationController.onInit();
              await bottomNavigationController.changeTab(3,
                  categories: categories,
                  subCategories: categories[index].subCategories,
                  selectedIndex: index);
                  */
              // Get.to(() => SubsectionsScreen(
              //       subCategories: categories[index].subCategories!,
              //       categories: categories,
              //       selectedCategoryIndex: index,
              //     ));
              controller.goToCategories();
            },
          );
        },
      ),
    );
  }
}
