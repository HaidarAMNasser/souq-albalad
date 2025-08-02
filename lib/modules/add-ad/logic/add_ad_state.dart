class AddAdState {
  final String? adType;
  final String? section;
  final String? subSection;
  final String? condition;
  final String? gearType;
  final String? priceType;
  final String? city;
  final String? promotionOption;
  final Map<String, dynamic> dynamicFields;

  AddAdState({
    this.adType,
    this.section,
    this.subSection,
    this.condition,
    this.gearType,
    this.priceType,
    this.city,
    this.promotionOption,
    this.dynamicFields = const {},
  });

  AddAdState copyWith({
    String? adType,
    String? section,
    String? subSection,
    String? condition,
    String? gearType,
    String? priceType,
    String? city,
    String? promotionOption,
    Map<String, dynamic>? dynamicFields,
  }) {
    return AddAdState(
      adType: adType ?? this.adType,
      section: section ?? this.section,
      subSection: subSection ?? this.subSection,
      condition: condition ?? this.condition,
      gearType: gearType ?? this.gearType,
      priceType: priceType ?? this.priceType,
      city: city ?? this.city,
      promotionOption: promotionOption ?? this.promotionOption,
      dynamicFields: dynamicFields ?? this.dynamicFields,
    );
  }
  @override
  List<Object?> get props => [
    adType,
    section,
    subSection,
    condition,
    city,
    promotionOption,
    dynamicFields,
  ];
}