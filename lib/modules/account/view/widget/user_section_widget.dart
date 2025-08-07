import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/endpoints/core/app_urls.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/modules/account/bloc/account_bloc.dart';
import 'package:souq_al_balad/modules/account/bloc/account_event.dart';
import 'package:souq_al_balad/modules/account/bloc/account_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserSectionWidget extends StatelessWidget {
  const UserSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc()..add(GetUserProfileEvent(context)),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          return Container(
            width: 1.sw,
            height: 250.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child:
                (state.userProfileState == StateEnum.loading)
                    ? Center(child: AppLoader(size: 20.w))
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 125.w,
                          height: 125.w,
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
                            image: DecorationImage(
                              image: NetworkImage(
                                state.user!.logoPathFromServer == null
                                    ? ""
                                    : AppUrls.imageUrl +
                                        state.user!.logoPathFromServer!,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          state.user!.name!,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
          );
        },
      ),
    );
  }
}
