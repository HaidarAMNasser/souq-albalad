import 'package:flutter/material.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';

class SpecialOffersSlider extends StatefulWidget {
  const SpecialOffersSlider({super.key});

  @override
  State<SpecialOffersSlider> createState() => _SpecialOffersSliderState();
}

class _SpecialOffersSliderState extends State<SpecialOffersSlider> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<SpecialOffer> _specialOffers = [
    SpecialOffer(
      id: '1',
      title: 'Sony PS4',
      description:
          'بلايستيشن 4 - 1 تيرابايت + 3 ألعاب\nحزمة مميزة تتضمن: Gran...',
      price: '100.000',
      location: 'حمص',
      imagePath: 'assets/images/on1.png',
      hasSpecialBadge: true,
    ),
    SpecialOffer(
      id: '2',
      title: 'Realme 7',
      description: 'ذاكرة قابلة للتوسيع حتى 256GB،\nأداء قوي وسعر مناسب',
      price: '250.000',
      location: 'حمص',
      imagePath: 'assets/images/on2.png',
      hasSpecialBadge: true,
    ),
    SpecialOffer(
      id: '3',
      title: 'Samsung Galaxy A54',
      description: 'هاتف ذكي بمواصفات عالية\nكاميرا 108 ميجابكسل، شاشة AMOLED',
      price: '320.000',
      location: 'دمشق',
      imagePath: 'assets/images/on3.png',
      hasSpecialBadge: true,
    ),
    SpecialOffer(
      id: '4',
      title: 'iPhone 13 Pro',
      description: 'آيفون 13 برو ماكس 128GB\nحالة ممتازة، جميع الإكسسوارات',
      price: '1.200.000',
      location: 'حلب',
      imagePath: 'assets/images/on1.png',
      hasSpecialBadge: true,
    ),
    SpecialOffer(
      id: '5',
      title: 'MacBook Air M2',
      description: 'لابتوب آبل الجديد\n8GB RAM, 256GB SSD',
      price: '2.800.000',
      location: 'دمشق',
      imagePath: 'assets/images/on2.png',
      hasSpecialBadge: true,
    ),
    SpecialOffer(
      id: '6',
      title: 'AirPods Pro 2',
      description: 'سماعات لاسلكية أصلية\nإلغاء الضوضاء النشط',
      price: '450.000',
      location: 'اللاذقية',
      imagePath: 'assets/images/on3.png',
      hasSpecialBadge: true,
    ),
  ];

  // تجميع العروض في مجموعات من 2
  List<List<SpecialOffer>> get _groupedOffers {
    List<List<SpecialOffer>> groups = [];
    for (int i = 0; i < _specialOffers.length; i += 2) {
      groups.add(_specialOffers.skip(i).take(2).toList());
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 340,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(textDirection: TextDirection.rtl, children: [


              ],
            ),
          ),
          const SizedBox(height: 16),

          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _groupedOffers.length,
              itemBuilder: (context, index) {
                return _buildOffersPair(_groupedOffers[index], isDark);
              },
            ),
          ),

          const SizedBox(height: 12),
          _buildPageIndicator(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildOffersPair(List<SpecialOffer> offers, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(child: _buildOfferItem(offers[0], isDark)),
          if (offers.length > 1) ...[
            const SizedBox(width: 12),
            Expanded(child: _buildOfferItem(offers[1], isDark)),
          ],
        ],
      ),
    );
  }

  Widget _buildOfferItem(SpecialOffer offer, bool isDark) {
    return GestureDetector(
      onTap: () {
        print('تم الضغط على عرض: ${offer.title}');
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
            // الصورة مع شارة العرض الخاص
            Stack(
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    image: DecorationImage(
                      image: AssetImage(offer.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),

            // المعلومات
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان
                  Text(
                    offer.title,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color:
                          isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                    ),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),

                  const SizedBox(height: 6),

                  // الوصف
                  Text(
                    offer.description,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color:
                          isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                      height: 1.3,
                    ),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // السعر
                      Text(
                        '${offer.price} ل.س',
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.orange,
                        ),
                        textDirection: TextDirection.rtl,
                      ),

                      // الموقع
                      Text(
                        offer.location,
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
                      ),
                    ],
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
        _groupedOffers.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: _currentIndex == index ? 12 : 8,
          height: 8,
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

class SpecialOffer {
  final String id;
  final String title;
  final String description;
  final String price;
  final String location;
  final String imagePath;
  final bool hasSpecialBadge;

  SpecialOffer({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    required this.imagePath,
    this.hasSpecialBadge = false,
  });
}
