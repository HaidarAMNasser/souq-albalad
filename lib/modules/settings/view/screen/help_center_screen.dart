import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/modules/settings/model/faq_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final List<FaqModel> faqItems = [
    FaqModel(questionKey: 'faq_q1', answerKey: 'faq_a1'),
    FaqModel(questionKey: 'faq_q2', answerKey: 'faq_a2'),
    FaqModel(questionKey: 'faq_q3', answerKey: 'faq_a3'),
    FaqModel(questionKey: 'faq_q4', answerKey: 'faq_a4'),
    FaqModel(questionKey: 'faq_q5', answerKey: 'faq_a5'),
    FaqModel(questionKey: 'faq_q6', answerKey: 'faq_a6'),
    FaqModel(questionKey: 'faq_q7', answerKey: 'faq_a7'),
    FaqModel(questionKey: 'faq_q8', answerKey: 'faq_a8'),
  ];

  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          AppLocalization.of(context).translate("help_center"),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: const Icon(Icons.arrow_back_outlined),
          ),
        ),
        foregroundColor: AppColors.primary2,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Text(
              AppLocalization.of(context).translate("welcome_in_center_help"),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontSize: 16),
            ),
            SizedBox(height: 20.h),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: faqItems.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = faqItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8),
                  child: Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      key: Key(index.toString()),
                      title: Text(
                        AppLocalization.of(context).translate(item.questionKey),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(fontSize: 16),
                      ),
                      trailing: Icon(
                        Icons.add_circle_rounded,
                        color: AppColors.primary2,
                      ),
                      onExpansionChanged: (expanded) {
                        setState(() {
                          expandedIndex = expanded ? index : null;
                        });
                      },
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            AppLocalization.of(
                              context,
                            ).translate(item.answerKey),
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
