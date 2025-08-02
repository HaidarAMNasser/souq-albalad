abstract class AddAdEvent {}

class SetAdType extends AddAdEvent {
  final String? adType;
  SetAdType(this.adType);
}

class SetSection extends AddAdEvent {
  final String? section;
  SetSection(this.section);
}

class SetSubSection extends AddAdEvent {
  final String? subSection;
  SetSubSection(this.subSection);
}

class SetCondition extends AddAdEvent {
  final String? condition;
  SetCondition(this.condition);
}

class SetGearType extends AddAdEvent {
  final String? gearType;
  SetGearType(this.gearType);
}

class SetPriceType extends AddAdEvent {
  final String? priceType;
  SetPriceType(this.priceType);
}

class SetCity extends AddAdEvent {
  final String? city;
  SetCity(this.city);
}

class SetPromotionOption extends AddAdEvent {
  final String? promotionOption;
  SetPromotionOption(this.promotionOption);
}

class PickImages extends AddAdEvent {}
