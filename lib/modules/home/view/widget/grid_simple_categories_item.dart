import 'package:souq_al_balad/global/endpoints/categories/models/category_model.dart';
import 'package:souq_al_balad/global/endpoints/core/app_urls.dart';
import 'package:souq_al_balad/modules/home/view/widget/simple_category_item.dart';
import 'package:souq_al_balad/modules/navigation_bar/controller/bottom_navigation_controller.dart';
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

      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: count,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          return SimpleCategoryItem(
            title: categories[index].name ?? '',
            imageUrl: categories[index].image == null ? "" :
            AppUrls.imageUrl + categories[index].image!,
            onTap: () async {
              controller.goToCategories(context);
            },
          );
        },
      ),
    );
  }
}
