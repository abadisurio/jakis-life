import 'package:bloc/bloc.dart';

part 'stable_sidewalk_event.dart';
part 'stable_sidewalk_state.dart';

class StableSidewalkBloc
    extends Bloc<StableSidewalkEvent, StableSidewalkState> {
  StableSidewalkBloc() : super(StableSidewalkInitial()) {
    on<StableSidewalkEvent>((event, emit) {
      //
    });
  }
}
