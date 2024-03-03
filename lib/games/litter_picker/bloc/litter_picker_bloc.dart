import 'package:bloc/bloc.dart';

part 'litter_picker_event.dart';
part 'litter_picker_state.dart';

class LitterPickerBloc extends Bloc<LitterPickerEvent, LitterPickerState> {
  LitterPickerBloc({
    required int level,
  }) : super(
          LitterPickerState(
            litterCount: 2 + level,
            litterPickedCount: 0,
            organicCount: 1 + level ~/ 2,
          ),
        ) {
    on<PickLitter>(_onPickLitter);
  }

  void _onPickLitter(
    PickLitter event,
    Emitter<LitterPickerState> emit,
  ) {
    emit(
      state.copyWith(
        litterPicked: event.litterIndex,
        litterPickedCount: state.litterPickedCount + 1,
      ),
    );
  }
}
