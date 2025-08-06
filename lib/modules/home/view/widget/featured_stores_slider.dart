import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/endpoints/core/app_urls.dart';
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

    return Column(
      children: [
        Container(
          height: 340.h,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.symmetric(horizontal: 5),
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
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildStoresPair(List<StoreBundleModel> stores, bool isDark) {
    return Row(
      children: [
        Expanded(child: _buildStoreItem(stores[0], isDark)),
        if (stores.length > 1) ...[
          const SizedBox(width: 12),
          Expanded(child: _buildStoreItem(stores[1], isDark)),
        ],
      ],
    );
  }

  Widget _buildStoreItem(StoreBundleModel store, bool isDark) {
    return GestureDetector(
      onTap: () {
        // todo go to store details page
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCardBackground : AppColors.lightCardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 120.h,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: CachedNetworkImage(
                  imageUrl: store.store!.logo == null ? "" : AppUrls.imageUrl + store.store!.logo!,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, child, loadingProgress) {
                    return const Center(child: AppLoader());
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
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.store!.storeOwnerName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    store.store!.storeName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color:
                      isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    store.store!.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color:
                      isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    store.store!.address!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary2
                    ),
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