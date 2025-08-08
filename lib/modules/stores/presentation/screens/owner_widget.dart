import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:souq_al_balad/global/data/local/cache_helper.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/endpoints/store/models/store_model.dart';
import 'package:souq_al_balad/global/endpoints/user/models/user_model.dart'; // IMPORTANT: Add this import
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/global/utils/images_file.dart';
import 'package:souq_al_balad/modules/stores/data/repository/get_stores_api.dart';
import 'package:souq_al_balad/modules/stores/data/models/get_stores_model.dart';
import 'package:intl/intl.dart' as intl;
import 'package:souq_al_balad/modules/chat/chat_destinations/bloc/chats_dest_bloc.dart';
import 'package:souq_al_balad/modules/chat/chat_destinations/bloc/chats_dest_event.dart';
import 'package:souq_al_balad/modules/chat/chat_destinations/bloc/chats_dest_states.dart';
import 'package:souq_al_balad/modules/chat/chats_page/view/screen/chats_page_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:souq_al_balad/modules/stores/presentation/bloc/get_stores_cubit.dart';
import 'package:url_launcher/url_launcher.dart'; // For better image handling

class AdOwnerScreen extends StatefulWidget {
  final int id;
  const AdOwnerScreen({
    super.key,
    required this.id,
  });

  @override
  State<AdOwnerScreen> createState() => _AdOwnerScreenState();
}

class _AdOwnerScreenState extends State<AdOwnerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              StoreDetailsCubit()..fetchStoreDetails(widget.id),
        ),
        BlocProvider(
          create: (context) => ChatDestBloc(),
        ),
      ],
      child: Scaffold(
        backgroundColor:
            isDark ? AppColors.darkBackground : AppColors.lightBackground,
        body: BlocBuilder<StoreDetailsCubit, StoreDetailsState>(
            builder: (context, state) {
          if (state is StoreDetailsLoading) {
            return const Center(
                child: CircularProgressIndicator(color: AppColors.primary));
          }
          if (state is StoreDetailsFailure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          if (state is StoreDetailsSuccess) {
            return SafeArea(
              child: Column(
                children: [
                  _buildMerchantInfo(state.storeData),
                  SizedBox(height: 10.h),
                  _buildTabBar(),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildAdsTab(state.storeData),
                        _buildInfoTab(state.storeData),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }

  Widget _buildMerchantInfo(StoreData store) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    String? fullImageUrl;
    const String YOUR_API_BASE_URL = "https://your-api-domain.com";
    if (store.user != null) {
      if (store.user!.profileImage != null &&
          store.user!.profileImage!.isNotEmpty) {
        if (store.user!.profileImage!.startsWith('http')) {
          fullImageUrl = store.user!.profileImage;
        } else {
          fullImageUrl = YOUR_API_BASE_URL + store.user!.profileImage!;
        }
      }
    }

    return Stack(
      children: [
        Container(
          height: 230.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagesApp.sellerProfile),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 20.h,
          width: 80.w,
          right: 0.w,
          child: InkWell(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_outlined,
                color: AppColors.primary2),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 120.h),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25.w),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: (isDark
                  ? AppColors.darkCardBackground
                  : AppColors.lightCardBackground),
              borderRadius: BorderRadius.circular(32.r),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4))
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: (fullImageUrl != null)
                        ? CachedNetworkImage(
                            imageUrl: fullImageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Icon(
                                Icons.person,
                                size: 80,
                                color: AppColors.grey300),
                          )
                        : const Icon(Icons.person,
                            size: 80, color: AppColors.grey300),
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  store.user?.name ?? "",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25.h),
                BlocConsumer<ChatDestBloc, ChatDestState>(
                  listener: (context, chatState) {
                    if (chatState.newlyCreatedChat != null) {
                      print("NAVIGATION: Chat is ready, navigating now...");
                      final int currentUserId = CacheHelper.getUserId();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatsPageScreen(
                            chat: chatState.newlyCreatedChat!,
                            currentUserId: currentUserId,
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, chatState) {
                    return Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            text: store.user?.phone ?? "" ?? 'No Phone',
                            icon: Icons.phone,
                            backgroundColor: AppColors.primary,
                            textColor: Colors.white,
                            onPressed: () {
                              launchUrl(Uri.parse("tel:${store.user?.phone}"));
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: chatState.chatDestState == StateEnum.loading
                              ? const Center(child: CircularProgressIndicator())
                              : _buildActionButton(
                                  text: AppLocalization.of(context)
                                      .translate("chat_here"),
                                  icon: Icons.chat,
                                  backgroundColor: AppColors.primary,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    final UserInfo? userInfo = store.user;
                                    final UserModel userModel = UserModel(
                                      id: userInfo?.id ?? 0,
                                      name: userInfo?.name ?? "",
                                      phone: userInfo?.phone ?? "",
                                    );

                                    context.read<ChatDestBloc>().add(
                                          StartChatWithUserEvent(
                                              otherUser: userModel),
                                        );
                                  },
                                ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
      {required String text,
      required IconData icon,
      required Color backgroundColor,
      required Color textColor,
      required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 20),
            SizedBox(width: 2.w),
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: TabBar(
        dividerColor: Colors.transparent,
        controller: _tabController,
        labelColor:
            isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
        unselectedLabelColor:
            isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
        indicatorColor: AppColors.primary,
        indicatorPadding: EdgeInsets.symmetric(vertical: 10.h),
        labelStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          Tab(text: AppLocalization.of(context).translate("ads")),
          Tab(text: AppLocalization.of(context).translate("info")),
        ],
      ),
    );
  }

  Widget _buildAdsTab(StoreData store) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      itemCount: store.products.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
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
                      store.products[index].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    SizedBox(height: 5.h),
                    if (store.products[index].createdAt != null &&
                        store.products[index].createdAt != "")
                      Text(
                        intl.DateFormat('yyyy-MM-dd')
                            .format(store.products[index].createdAt!),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                      ),
                    SizedBox(height: 8.h),
                    Text(
                      store.products[index].finalPrice,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColors.orange,
                          ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            // todo go to ad details screen
                          },
                          child: Container(
                            width: 100.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                color: AppColors.primary2,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Center(
                              child: Text(
                                AppLocalization.of(context)
                                    .translate("details"),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: AppColors.lightSurface,
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  adsList[index]["image"],
                  height: 120.w,
                  width: 100.w,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoTab(StoreData store) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoItem(
              AppLocalization.of(context).translate("store_classification"),
              store.store != null ? store.store!.storeName : ""),
          _buildInfoItem(AppLocalization.of(context).translate("city"),
              store.store != null ? store.store!.address : ""),
          _buildInfoItem(AppLocalization.of(context).translate("work_hours"),
              '9:00 ص - 9:00 م'),
          _buildInfoItem(AppLocalization.of(context).translate("email"),
              'info@homeappliances.com'),
          _buildInfoItem("اسم مالك المتجر",
              store.store != null ? store.store!.storeOwnerName : ""),
          _buildInfoItem(
              "اسم المتجر", store.store != null ? store.store!.storeName : ""),
          _buildInfoItem(
              "العنوان", store.store != null ? store.store!.address : ""),
          _buildInfoItem(
              "رقم الهاتف", store.store != null ? store.store!.phone : ""),
          _buildInfoItem(
              "الوصف", store.store != null ? store.store!.description : ""),
          _buildInfoItem(
              "مميز؟",
              store.store != null
                  ? store.store!.isFeatured
                      ? "نعم"
                      : "لا"
                  : "لا"),
          if (store.store != null && store.store!.createdAt != null)
            _buildInfoItem("تاريخ الإنشاء",
                intl.DateFormat('yyyy-MM-dd').format(store.store!.createdAt!)),
          if (store.store != null && store.store!.updatedAt != null)
            _buildInfoItem("آخر تحديث",
                intl.DateFormat('yyyy-MM-dd').format(store.store!.updatedAt!)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: Color(0xffD9D9D9),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalization.of(context).translate("description"),
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff676767),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "نقدّم لكم أحدث موديلات الأجهزة المنزلية الكهربائية بأسعار منافسة وضمان لمدة سنة كاملة. لدينا جميع الماركات العالمية. توصيل متاح لكافة المحافظات السورية.",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff676767),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xff676767),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xff676767),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> adsList = [
  {
    "name": "iPhone 13 Pro Max ",
    "image": "assets/images/ad.png",
    "price": "7,000,000",
    "joining_date": "17.03.2025"
  },
  {
    "name": "Canon 700D camera with 18-55mm lens",
    "image": "assets/images/ad.png",
    "price": "8,000,000",
    "joining_date": "20.03.2025"
  },
  {
    "name": "Wooden TV stand - modern design",
    "image": "assets/images/ad.png",
    "price": "12,000,000",
    "joining_date": "17.05.2025"
  },
  {
    "name": "LG 43 TV",
    "image": "assets/images/ad.png",
    "price": "9,000,000",
    "joining_date": "28.04.2025"
  },
  {
    "name": "LG 43 TV",
    "image": "assets/images/ad.png",
    "price": "9,000,000",
    "joining_date": "01.09.2025"
  },
];
