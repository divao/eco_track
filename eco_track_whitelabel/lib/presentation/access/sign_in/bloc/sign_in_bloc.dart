import 'package:bloc/bloc.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/use_case/sign_in_uc.dart';
import 'package:eco_track_whitelabel/common/providers/general_provider.dart';
import 'package:eco_track_whitelabel/presentation/access/sign_in/bloc/sign_in_event.dart';
import 'package:eco_track_whitelabel/presentation/access/sign_in/bloc/sign_in_state.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/button_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/input_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/sign_in_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInBlocProvider = Provider.autoDispose<SignInBloc>((ref) {
  final signInUC = ref.watch(signInUCProvider);
  return SignInBloc(
    signInUC: signInUC,
  );
});

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required SignInUC signInUC,
  })  : _signInUC = signInUC,
        super(
          SignInState(
            signInStatus: SignInStatus.idle,
            buttonStatus: ButtonInactive(),
            email: '',
            password: '',
            emailInputStatus: InputStatus.empty,
            passwordInputStatus: InputStatus.empty,
          ),
        ) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<SignInSubmitted>(_onSignInSubmitted);
  }

  final SignInUC _signInUC;

  void _onEmailChanged(
    EmailChanged event,
    Emitter<SignInState> emit,
  ) {
    _updatePasswordInputStatus(
      event.email,
      event.password,
      emit,
    );
  }

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<SignInState> emit,
  ) {
    _updatePasswordInputStatus(
      event.email,
      event.password,
      emit,
    );
  }

  void _updateEmailInputStatus(
    String email,
    String password,
    Emitter<SignInState> emit,
  ) {
    if (email.isNotEmpty) {
      emit(
        state.copyWith(
          email: email,
          emailInputStatus: InputStatus.valid,
        ),
      );

      if (state.passwordInputStatus == InputStatus.wrong ||
          state.passwordInputStatus == InputStatus.empty) {
        _updatePasswordInputStatus(email, password, emit);
      } else {
        _validateFields(
          email,
          password,
          emit,
        );
      }

    } else {
      emit(
        state.copyWith(
          email: email,
          emailInputStatus: InputStatus.empty,
        ),
      );
      _validateFields(
        email,
        password,
        emit,
      );
    }
  }

  void _updatePasswordInputStatus(
    String email,
    String password,
    Emitter<SignInState> emit,
  ) {
    if (password.isNotEmpty) {
      emit(
        state.copyWith(
          password: password,
          passwordInputStatus: InputStatus.valid,
        ),
      );

      if (state.emailInputStatus == InputStatus.wrong ||
          state.emailInputStatus == InputStatus.empty) {
        _updateEmailInputStatus(email, password, emit);
      } else {
        _validateFields(
          email,
          password,
          emit,
        );
      }

    } else {
      emit(
        state.copyWith(
          password: password,
          passwordInputStatus: InputStatus.empty,
        ),
      );
      _validateFields(
        email,
        password,
        emit,
      );
    }
  }

  void _validateFields(
      String email, String password, Emitter<SignInState> emit) {
    final isEmailValid = state.emailInputStatus == InputStatus.valid;
    final isPasswordValid = state.passwordInputStatus == InputStatus.valid;
    if (isEmailValid && isPasswordValid) {
      emit(
        state.copyWith(
          buttonStatus: ButtonActive(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          buttonStatus: ButtonInactive(),
        ),
      );
    }
  }

  Future<void> _onSignInSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    // if (state.emailInputStatus == InputStatus.valid && state.passwordInputStatus == InputStatus.valid) {
    emit(
      state.copyWith(
        buttonStatus: ButtonLoading(),
      ),
    );
    try {
      await _signInUC.getFuture(
        SignInUCParams(
          email: event.email,
          password: event.password,
        ),
      );
      emit(
        state.copyWith(
          signInStatus: SignInStatus.success,
          buttonStatus: ButtonInactive(),
        ),
      );
    } catch (err) {
      if (err is InvalidCredentialsException ||
          err is EmptyFormFieldException ||
          err is BackendValidationException) {
        emit(
          state.copyWith(
            signInStatus: SignInStatus.invalidEmailOrPassword,
            buttonStatus: ButtonInactive(),
            emailInputStatus: InputStatus.wrong,
            passwordInputStatus: InputStatus.wrong,
          ),
        );
      } else {
        emit(
          state.copyWith(
            signInStatus: SignInStatus.undefinedError,
            buttonStatus: ButtonActive(),
          ),
        );
      }
    }
    // }
  }
}
