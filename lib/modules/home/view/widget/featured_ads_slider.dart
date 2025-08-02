import 'package:souq_al_balad/global/endpoints/product/models/product_bundle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturedAdsSlider extends StatefulWidget {
  final List<ProductBundleModel> products;
  const FeaturedAdsSlider({required this.products, super.key});

  @override
  State<FeaturedAdsSlider> createState() => _FeaturedAdsSliderState();
}

class _FeaturedAdsSliderState extends State<FeaturedAdsSlider> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  // تجميع الإعلانات في مجموعات من 2
  List<List<ProductBundleModel>> get _groupedAds {
    List<List<ProductBundleModel>> groups = [];
    for (int i = 0; i < widget.products.length; i += 2) {
      groups.add(widget.products.skip(i).take(2).toList());
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 320.h,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _groupedAds.length,
              itemBuilder: (context, index) {
                return _buildAdsPair(_groupedAds[index], isDark);
              },
            ),
          ),
          SizedBox(height: 12.h),
          _buildPageIndicator(),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildAdsPair(List<ProductBundleModel> ads, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(child: _buildAdItem(ads[0], isDark)),
          if (ads.length > 1) ...[
            const SizedBox(width: 12),
            Expanded(child: _buildAdItem(ads[1], isDark)),
          ],
        ],
      ),
    );
  }

  Widget _buildAdItem(ProductBundleModel ad, bool isDark) {
    return GestureDetector(
      onTap: () {
        print('تم الضغط على إعلان: ${ad.product!.title}');
      },
      child: Container(
        decoration: BoxDecoration(
          color:
              isDark
                  ? AppColors.darkCardBackground
                  : AppColors.lightCardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الصورة
            Container(
              height: 120.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: '', //ad.images[0],
                fit: BoxFit.contain,
                progressIndicatorBuilder: (context, child, loadingProgress) {
                  return const Center(child: CircularProgressIndicator());
                },
                errorWidget: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported,
                    size: 60,
                    color: Colors.grey[400],
                  );
                },
              ),
            ),

            // المعلومات
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان
                  Text(
                    ad.product!.title!,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color:
                          isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                    ),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),

                  SizedBox(height: 8.h),
                  // السعر
                  Text(
                    '${ad.product!.price} '
                    '${ad.product!.price_type ?? ''}',
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.orange,
                    ),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),

                  SizedBox(height: 8.h),
                  if (ad.product!.address_details != null &&
                      ad.product!.address_details != '')
                    Text(
                      ad.product!.address_details ?? '',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color:
                            isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                      ),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _groupedAds.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: _currentIndex == index ? 12.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color:
                _currentIndex == index ? AppColors.orange : AppColors.grey300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class FeaturedAd {
  final String id;
  final String title;
  final String price;
  final String location;
  final String imagePath;

  FeaturedAd({
    required this.id,
    required this.title,
    required this.price,
    required this.location,
    required this.imagePath,
  });
}
