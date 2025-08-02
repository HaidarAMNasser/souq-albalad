import 'package:souq_al_balad/global/utils/images_file.dart';
import 'package:souq_al_balad/modules/sections/sub_sections/view/widget/circular_category_widget.dart';
import 'package:flutter/material.dart';

class CategoriesSectionWidget extends StatefulWidget {
  const CategoriesSectionWidget({super.key});

  @override
  State<CategoriesSectionWidget> createState() =>
      _CategoriesSectionWidgetState();
}

class _CategoriesSectionWidgetState extends State<CategoriesSectionWidget> {
  int selectedIndex = 1;

  final List<CategoryItem> categories = [
    CategoryItem(id: 0, title: 'مركبات', imagePath: ImagesApp.instagram),
    CategoryItem(id: 1, title: 'عقارات', imagePath: ImagesApp.instagram),
    CategoryItem(id: 2, title: 'وظائف', imagePath: ImagesApp.instagram),
    CategoryItem(id: 3, title: 'إلكترونيات', imagePath: ImagesApp.instagram),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              textDirection: TextDirection.rtl,
              children:
                  categories.asMap().entries.map((entry) {
                    int index = entry.key;
                    CategoryItem category = entry.value;

                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == categories.length - 1 ? 0 : 20,
                      ),
                      child: CircularCategoryWidget(
                        title: category.title,
                        imagePath: category.imagePath,
                        isSelected: selectedIndex == index,
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          _onCategorySelected(category);
                        },
                        size: 100,
                      ),
                    );
                  }).toList(),
            ),
          ),
          if (selectedIndex >= 0) ...[const SizedBox(height: 20)],
        ],
      ),
    );
  }

  void _onCategorySelected(CategoryItem category) {
    print('تم اختيار الفئة: ${category.title}');
  }
}

class CategoryItem {
  final int id;
  final String title;
  final String imagePath;

  CategoryItem({
    required this.id,
    required this.title,
    required this.imagePath,
  });
}
