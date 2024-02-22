import 'package:bloc/bloc.dart';

part 'litter_picker_event.dart';
part 'litter_picker_state.dart';

class LitterPickerBloc extends Bloc<LitterPickerEvent, LitterPickerState> {
  LitterPickerBloc()
      : super(
          const LitterPickerState(
            litterCount: 5,
            litterPickedCount: 0,
            organicCount: 2,
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
