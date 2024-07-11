import 'package:bloc/bloc.dart';
import 'package:domain/use_case/sign_up_uc.dart';
import 'package:eco_track_whitelabel/common/providers/general_provider.dart';
import 'package:eco_track_whitelabel/presentation/access/sign_up/bloc/sign_up_event.dart';
import 'package:eco_track_whitelabel/presentation/access/sign_up/bloc/sign_up_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpBlocProvider =
Provider.autoDispose<SignUpBloc>((ref) {
  final signUpUC = ref.watch(signUpUCProvider);
  return SignUpBloc(
    signUpUC: signUpUC,
  );
});

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required SignUpUC signUpUC,
  })  : _signUpUC = signUpUC,
        super(Loading()) {
    // on<>(_signUp);
  }

  final SignUpUC _signUpUC;

  void _signUp(SignUpEvent event, Emitter emit) async {
    emit(Loading());
    try {

    } catch (e) {

    }
  }
}
