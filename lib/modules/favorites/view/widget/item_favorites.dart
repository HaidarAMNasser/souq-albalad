import 'package:flutter/material.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';

class ItemFavorites extends StatelessWidget {
  final String productName;
  final String price;
  final String imagePath;
  final String? imageUrl;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;
  final VoidCallback onDetailsPressed;
  final String currency;

  const ItemFavorites({
    super.key,
    required this.productName,
    required this.price,
    required this.imagePath,
    this.imageUrl,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.onDetailsPressed,
    this.currency = 'ل.س',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            isDark
                ? AppColors.darkCardBackground
                : AppColors.lightCardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color:
                        isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 12),
                Text(
                  '$price $currency',
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.orange,
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 16),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        text: 'تفاصيل',
                        onPressed: onDetailsPressed,
                        backgroundColor: AppColors.primary,
                        textColor: Colors.white,
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: _buildActionButton(
                        text: isFavorite ? 'إزالة من المفضلة' : 'إضافة للمفضلة',
                        onPressed: onFavoritePressed,
                        backgroundColor: Colors.transparent,
                        textColor: Color(0xff676767),
                        borderColor: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: _buildImage(),
            ),
          ),
        ],
      ),
    );
  }

  DecorationImage? _buildImage() {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover);
    } else if (imagePath.isNotEmpty) {
      return DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover);
    }
    return null;
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
    Color? borderColor,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border:
              borderColor != null
                  ? Border.all(color: borderColor, width: 1.5)
                  : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
