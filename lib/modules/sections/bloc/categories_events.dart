import 'package:flutter/src/widgets/framework.dart';

abstract class CategoriesEvents {
  const CategoriesEvents();
}

class GetCategoriesEvent extends CategoriesEvents {
  BuildContext context;
  GetCategoriesEvent(this.context);
}
