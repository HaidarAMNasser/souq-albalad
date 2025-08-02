import 'package:souq_al_balad/global/components/custom_button_home.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/modules/home/view/widget/grid_simple_categories_item.dart';
import 'package:souq_al_balad/modules/home/view/widget/home_appbar_app.dart';
import 'package:souq_al_balad/modules/sections/bloc/categories_bloc.dart';
import 'package:souq_al_balad/modules/sections/bloc/categories_events.dart';
import 'package:souq_al_balad/modules/sections/bloc/categories_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionsScreen extends StatefulWidget {
  const SectionsScreen({super.key});

  @override
  State<SectionsScreen> createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesBloc()..add(GetCategoriesEvent(context)),
      child: Scaffold(
        body: Column(
          children: [
            HomeAppBar(viewTextSearch: false),
            SizedBox(height: 20),
            CustomButtonHome(
              width: 270,
              height: 36,
              text: AppLocalization.of(context).translate("sections"),
            ),
            BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state.categoryState == StateEnum.loading) {
                  return Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return GridSimpleCategoriesItem(
                  categories: state.categories!,
                  count: state.categories!.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
