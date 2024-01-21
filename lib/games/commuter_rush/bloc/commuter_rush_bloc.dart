import 'package:bloc/bloc.dart';

part 'commuter_rush_event.dart';
part 'commuter_rush_state.dart';

class CommuterRushBloc extends Bloc<CommuterRushEvent, CommuterRushState> {
  CommuterRushBloc() : super(CommuterRushInitial()) {
    on<CommuterRushEvent>((event, emit) {
//
    });
  }
}
