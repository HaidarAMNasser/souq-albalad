import 'package:souq_al_balad/global/endpoints/categories/models/sub_category_model.dart';
import 'package:souq_al_balad/modules/home/view/widget/simple_category_item.dart';
import 'package:flutter/material.dart';

class GridSimpleSubCategoriesItem extends StatelessWidget {
  final List<SubCategoryModel> subCategories;
  const GridSimpleSubCategoriesItem({required this.subCategories, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: subCategories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
          // النسبة بين العرض والارتفاع
        ),
        itemBuilder: (context, index) {
          return SimpleCategoryItem(
            title: subCategories[index].name ?? '',
            imageUrl: subCategories[index].image ?? '',
            onTap: () => print('وظائف'),
          );
        },
      ),
    );
  }
}
