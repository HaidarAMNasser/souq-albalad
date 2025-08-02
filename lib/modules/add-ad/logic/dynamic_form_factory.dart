import 'package:souq_al_balad/modules/add-ad/logic/add_ad_state.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/animals/animals_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/electronics/laptop_computer_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/electronics/mobiles_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/electronics/screens_other_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/fashion-accessories/clothes_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/fashion-accessories/others_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/furniture-home/furniture_home_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/kids-staff/kids_staff_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/medical-supplies/medical_supplies_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/property/apartments_farms_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/property/lands_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/property/offices_shops_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/technology-entertainment/books_magazines_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/technology-entertainment/musical_instruments_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/technology-entertainment/playstation_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/technology-entertainment/video_game_forn.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/vehicles/bicycle_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/vehicles/car_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/vehicles/meteors_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/vehicles/spare_parts_form.dart';
import 'package:flutter/material.dart';

import '../ui/widgets/sport/sport_form.dart' show SportFormSection;

List<Widget> getDynamicFieldsForSubSection({
  required String subSection,
  required AddAdState state,
  required Function(String?) setCondition,
  required Function(String?) setGearType,
  required Function(String?) setPriceType,
  required Function(String?) setCity,
  required Function(String?) setPromotionOption,
  required VoidCallback pickImages,
  required List<String> cities,
}) {
  switch (subSection) {
    case 'سيارات':
      return [
        CarFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
          gearType: state.gearType,
          priceType: state.priceType,
          setGearType: setGearType,
          setPriceType: setPriceType,
        ),
      ];
    case 'ميتورات':
      return [
        MeteorsFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
          priceType: state.priceType,
          setPriceType: setPriceType,
        ),
      ];
    case 'دراجات':
      return [
        BicycleFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
          gearType: state.gearType,
          priceType: state.priceType,
          setGearType: setGearType,
          setPriceType: setPriceType,
        ),
      ];
    case 'قطع غيار':
    case 'دواليب':
      return [
        SparePartsFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
          priceType: state.priceType,
          setPriceType: setPriceType,
        ),
      ];
    case 'شقق للبيع':
    case 'شقق للإيجار':
    case 'مزارع للإيجار':
      return [
        ApartmentsFarmsFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
          gearType: state.gearType,
          priceType: state.priceType,
          setGearType: setGearType,
          setPriceType: setPriceType,
        ),
      ];
    case 'مكاتب':
    case 'محلات':
      return [
        OfficesShopsFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
          priceType: state.priceType,
          setPriceType: setPriceType,
        ),
      ];
    case 'أراضي':
      return [
        LandsFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
        ),
      ];
    case 'ملابس':
      return [
        ClothesFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
        ),
      ];
    case 'منتجات تجميل':
    case 'احذية وحقائب':
    case 'ساعات واكسسوارات':
      return [
        OtherFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
        ),
      ];
    case 'موبايلات':
      return [
        MobilesFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
        ),
      ];
    case 'لابتوبات':
    case 'كمبيوترات مكتبية':
      return [
        LaptopComputerFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
        ),
      ];
    case 'شاشات':
    case 'كاميرات':
    case 'ملحقات واكسسوارات':
      return [
        ScreensOthersFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
        ),
      ];
    case 'beds':
      return [
        FurnitureHomeFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
        ),
      ];
    case 'العاب':
    case 'عربات اطفال':
    case 'مقاعد اطفال':
      return [
        KidsStaffFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
        ),
      ];
    case 'حيوانات منزلية':
    case 'طيور':
    case 'اسماك':
    case 'حيوانات اخرى':
      return [
        AnimalsFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
        ),
      ];
    case 'العاب فيديو':
      return [
        VideoGameFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
        ),
      ];
    case 'أجهزة بلايستيشن':
      return [
        PlaystationFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
        ),
      ];
    case 'ادوات موسيقية':
      return [
        MusicalInstrumentsFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
        ),
      ];
    case 'كتب ومجلات':
      return [
        BooksMagazinesFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
        ),
      ];
    case 'مستلزمات طبية1':
      return [
        MedicalSuppliesFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
        ),
      ];
    case 'رياضة1':
      return [
        SportFormSection(
          condition: state.condition,
          city: state.city,
          promotionOption: state.promotionOption,
          setCondition: setCondition,
          setCity: setCity,
          setPromotionOption: setPromotionOption,
          pickImages: pickImages,
          cities: cities,
        ),
      ];
    default:
      return [const Text('لا توجد حقول مخصصة لهذا النوع')];
  }
}
