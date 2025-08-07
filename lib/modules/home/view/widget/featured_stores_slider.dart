import 'package:souq_al_balad/global/endpoints/store/models/store_bundle_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturedStoresSlider extends StatefulWidget {
  final List<StoreBundleModel> stores;
  const FeaturedStoresSlider({required this.stores, super.key});

  @override
  State<FeaturedStoresSlider> createState() => _FeaturedStoresSliderState();
}

class _FeaturedStoresSliderState extends State<FeaturedStoresSlider> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  // تجميع المتاجر في مجموعات من 2
  List<List<StoreBundleModel>> get _groupedStores {
    List<List<StoreBundleModel>> groups = [];
    for (int i = 0; i < widget.stores.length; i += 2) {
      groups.add(widget.stores.skip(i).take(2).toList());
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 340.h,
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
              itemCount: _groupedStores.length,
              itemBuilder: (context, index) {
                return _buildStoresPair(_groupedStores[index], isDark);
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

  Widget _buildStoresPair(List<StoreBundleModel> stores, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(child: _buildStoreItem(stores[0], isDark)),
          if (stores.length > 1) ...[
            const SizedBox(width: 12),
            Expanded(child: _buildStoreItem(stores[1], isDark)),
          ],
        ],
      ),
    );
  }

  Widget _buildStoreItem(StoreBundleModel store, bool isDark) {
    return GestureDetector(
      onTap: () {
        print('تم الضغط على متجر: ${store.store!.storeName}');
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
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
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // الأيقونة الدائرية
              Container(
                width: 65.w,
                height: 65.h,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child:
                    (store.store!.logo != null && store.store!.logo!.isNotEmpty)
                        ? CachedNetworkImage(
                            imageUrl: store.store!.logo!,
                            fit: BoxFit.contain,
                            progressIndicatorBuilder:
                                (context, child, loadingProgress) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                            errorWidget: (context, error, stackTrace) {
                              return Icon(
                                Icons.image_not_supported,
                                size: 60,
                                color: Colors.grey[400],
                              );
                            },
                          )
                        : Icon(
                            Icons.image_not_supported,
                            size: 60,
                            color: Colors.grey[400],
                          ),
              ),

              SizedBox(height: 8.h),

              // العنوان الفرعي (باللون)
              Flexible(
                child: Text(
                  store.store!.storeOwnerName ?? '',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    //color: store.subtitleColor,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              SizedBox(height: 4.h),

              // اسم المتجر
              Flexible(
                child: Text(
                  store.store!.storeName ?? '',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              SizedBox(height: 6.h),

              // الوصف
              Flexible(
                child: Text(
                  store.store!.description ?? '',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              SizedBox(height: 6.h),

              // الموقع
              Flexible(
                child: Text(
                  store.store!.address ?? '',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _groupedStores.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: _currentIndex == index ? 12 : 8,
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

class FeaturedStore {
  final String id;
  final String storeName;
  final String storeSubtitle;
  final String description;
  final String location;
  final IconData iconData;
  final Color iconColor;
  final Color subtitleColor;

  FeaturedStore({
    required this.id,
    required this.storeName,
    required this.storeSubtitle,
    required this.description,
    required this.location,
    required this.iconData,
    required this.iconColor,
    required this.subtitleColor,
  });
}
