import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/nav_event.dart';

class NavBloc extends Bloc<NavEvent, int> {
  NavBloc() : super(2) {
    on<NavEvent>(
      (event, emit) {
        switch (event) {
          case NavEvent.menu:
            emit(0);
            return;
          case NavEvent.order:
            emit(1);
            return;
          case NavEvent.scanner:
            emit(2);
            return;
          case NavEvent.history:
            emit(3);
            return;
          case NavEvent.profile:
            emit(4);
            return;
        }
      },
    );
  }
}
