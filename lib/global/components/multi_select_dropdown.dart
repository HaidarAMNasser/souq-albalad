import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MultiSelectDropdown extends StatelessWidget {
  final String hint;
  final List<String> selectedItems;
  final List<String> items;
  final void Function(List<String>) onChanged;

  const MultiSelectDropdown({
    super.key,
    required this.hint,
    required this.selectedItems,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor =
        isDark ? const Color(0xFF404040) : const Color(0xFFE0E0E0);

    return GestureDetector(
      onTap: () async {
        final results = await showDialog<List<String>>(
          context: context,
          builder:
              (_) => _MultiSelectDialog(
                items: items,
                initiallySelected: selectedItems,
              ),
        );

        if (results != null) {
          onChanged(results);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          selectedItems.isEmpty ? hint : selectedItems.join('، '),
          style: TextStyle(
            fontSize: 16.sp,
            color:
                selectedItems.isEmpty ? AppColors.grey700 : AppColors.primary2,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}

class _MultiSelectDialog extends StatefulWidget {
  final List<String> items;
  final List<String> initiallySelected;

  const _MultiSelectDialog({
    required this.items,
    required this.initiallySelected,
  });

  @override
  State<_MultiSelectDialog> createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<_MultiSelectDialog> {
  late List<String> selected;

  @override
  void initState() {
    super.initState();
    selected = [...widget.initiallySelected];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('اختر التجهيزات'),
      content: SingleChildScrollView(
        child: Column(
          children:
              widget.items.map((item) {
                final isSelected = selected.contains(item);
                return CheckboxListTile(
                  title: Text(item),
                  value: isSelected,
                  activeColor: AppColors.primary2,
                  onChanged: (checked) {
                    setState(() {
                      if (checked == true) {
                        selected.add(item);
                      } else {
                        selected.remove(item);
                      }
                    });
                  },
                );
              }).toList(),
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            'إلغاء',
            style: TextStyle(
              color: AppColors.primary2,
              fontFamily: 'Montserrat',
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary2,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          child: const Text(
            'موافق',
            style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
          ),
          onPressed: () => Navigator.pop(context, selected),
        ),
      ],
    );
  }
}
