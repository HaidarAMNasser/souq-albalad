import 'package:souq_al_balad/modules/add-ad/logic/add_ad_event.dart';
import 'package:souq_al_balad/modules/add-ad/logic/add_ad_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAdBloc extends Bloc<AddAdEvent, AddAdState> {
  AddAdBloc() : super(AddAdState()) {
    on<SetAdType>((event, emit) {
      emit(
        state.copyWith(
          adType: event.adType,
          section: null,
          subSection: null,
          promotionOption: null,
          dynamicFields: {},
        ),
      );
    });

    on<SetSection>((event, emit) {
      emit(
        state.copyWith(
          section: event.section,
          subSection: null,
          promotionOption: null,
          dynamicFields: {},
        ),
      );
    });

    on<SetSubSection>((event, emit) {
      emit(
        state.copyWith(
          subSection: event.subSection,
          promotionOption: null,
          dynamicFields: {},
        ),
      );
    });

    on<SetCondition>((event, emit) {
      emit(state.copyWith(condition: event.condition));
    });

    on<SetGearType>((event, emit) {
      emit(state.copyWith(gearType: event.gearType));
    });

    on<SetPriceType>((event, emit) {
      emit(state.copyWith(priceType: event.priceType));
    });

    on<SetCity>((event, emit) {
      emit(state.copyWith(city: event.city));
    });

    on<SetPromotionOption>((event, emit) {
      emit(state.copyWith(promotionOption: event.promotionOption));
    });

    on<PickImages>((event, emit) {
      // add image picker logic later
      print('Image picker triggered');
    });
  }

  final List<String> adTypes = [
    'إعلان لمنتج',
    'وظيفة شاغرة',
    'أنا أبحث عن عمل',
    'نشر خدمة',
    'تبادل',
  ];
  final List<String> sections = [
    'مركبات',
    'العقارات',
    'ازياء واكسسوارات',
    'الكترونيات',
    'اثاث ومنزل',
    'مستلزمات اطفال',
    'الحيوانات',
    'تكنزلوجيا وترفيه',
    'مستلزمات طبية',
    'رياضة',
    'الاخرى والمتفرقات',
  ];
  final Map<String, List<String>> subSectionsMap = {
    'مركبات': ['سيارات', 'ميتورات', 'دراجات', 'قطع غيار', 'دواليب'],
    'العقارات': [
      'شقق للإيجار',
      'شقق للبيع',
      'مزارع للإيجار',
      'مكاتب',
      'محلات',
      'أراضي',
    ],
    'ازياء واكسسوارات': [
      'ملابس',
      'منتجات تجميل',
      'احذية وحقائب',
      'ساعات واكسسوارات',
    ],
    'اثاث ومنزل': ['beds'],
    'مستلزمات اطفال': ['العاب', 'عربات اطفال', 'مقاعد اطفال'],
    'حيوانات': ['منزلية', 'طيور', 'اسماك', 'حيوانات اخرى'],
    'إلكترونيات': [
      'موبايلات',
      'لابتوبات',
      'كمبيوترات مكتبية',
      'كاميرات',
      'شاشات',
      'ملحقات واكسسوارات',
    ],
    'تكنولوجيا وترفيه': [
      'العاب فيديو',
      'أجهزة بلايستيشن',
      'ادوات موسيقية',
      'كتب ومجلات',
    ],
    'مستلزمات طبية': ['مستلزمات طبية1', 'مستلزمات طبية2'],
    'رياضة': ['رياضة1', 'رياضة2'],
    'الاخرى والمتفرقات': ['الاخرى والمتفرقات'],
  };

  final List<String> cities = [
    'دمشق',
    'ريف دمشق',
    'حمص',
    'حماة',
    'حلب',
    'اللاذقية',
    'طرطوس',
    'دير الزور',
    'الحسكة',
    'الرقة',
    'إدلب',
    'السويداء',
    'القنيطرة',
    'درعا',
  ];

  final List<String> promotionOptions = [
    'إعلان مميز (1\$)',
    'إعادة رفع تلقائي متكرر (2\$)',
    'إعلان مميز في الأعلى (5\$)',
  ];

  List<String> getSubSections(String section) => subSectionsMap[section] ?? [];
}
