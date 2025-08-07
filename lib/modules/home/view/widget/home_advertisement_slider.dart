import 'package:flutter/material.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';

class HomeAdvertisementSlider extends StatefulWidget {
  const HomeAdvertisementSlider({super.key});

  @override
  State<HomeAdvertisementSlider> createState() =>
      _HomeAdvertisementSliderState();
}

class _HomeAdvertisementSliderState extends State<HomeAdvertisementSlider> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<SliderItem> _sliderItems = [
    SliderItem(
      title: 'احجز اعلانك هنا',
      subtitle: 'هل ترغب بالترويج لمنتجك أو\nمتجرك هنا؟',
      description: 'يمكنك حجز هذه المساحة الآن!',
      buttonText: 'اتصل بنا',
      imagePath: 'assets/images/on1.png',
      backgroundColor: AppColors.primary,
    ),
    SliderItem(
      title: 'روّج لمنتجاتك',
      subtitle: 'وصل إلى آلاف العملاء\nالمحتملين يومياً',
      description: 'ابدأ الآن واحصل على النتائج!',
      buttonText: 'ابدأ الآن',
      imagePath: 'assets/images/on2.png',
      backgroundColor: AppColors.secondary,
    ),
    SliderItem(
      title: 'زد مبيعاتك',
      subtitle: 'استخدم منصتنا للوصول\nلعملاء جدد',
      description: 'خطط مرنة تناسب جميع الأحجام!',
      buttonText: 'اكتشف المزيد',
      imagePath: 'assets/images/on3.png',
      backgroundColor: AppColors.accent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _sliderItems.length,
              itemBuilder: (context, index) {
                return _buildSliderItem(_sliderItems[index]);
              },
            ),
          ),
          const SizedBox(height: 12),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildSliderItem(SliderItem item) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [item.backgroundColor, item.backgroundColor.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // الخلفية الزخرفية
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            left: -30,
            bottom: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          // المحتوى الرئيسي
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                // النصوص والزر
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        textDirection: TextDirection.rtl,
                      ),

                      const SizedBox(height: 4),
                      Text(
                        item.description,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 16),

                      // الزر
                      GestureDetector(
                        onTap: () {
                          print('تم الضغط على: ${item.buttonText}');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Text(
                            item.buttonText,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // الصورة
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(item.imagePath),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _sliderItems.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
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

class SliderItem {
  final String title;
  final String subtitle;
  final String description;
  final String buttonText;
  final String imagePath;
  final Color backgroundColor;

  SliderItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.buttonText,
    required this.imagePath,
    required this.backgroundColor,
  });
}
