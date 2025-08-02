import 'package:flutter_bloc/flutter_bloc.dart';

class CarDetailsCubit extends Cubit<bool> {
  CarDetailsCubit() : super(false);

  void toggleFavorite() => emit(!state);
}
