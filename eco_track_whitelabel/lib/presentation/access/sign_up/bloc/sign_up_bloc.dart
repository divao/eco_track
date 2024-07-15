import 'package:bloc/bloc.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/use_case/sign_up_uc.dart';
import 'package:domain/use_case/validate_email_uc.dart';
import 'package:domain/use_case/validate_name_uc.dart';
import 'package:domain/use_case/validate_password_confirmation_uc.dart';
import 'package:domain/use_case/validate_password_uc.dart';
import 'package:eco_track_whitelabel/common/providers/general_provider.dart';
import 'package:eco_track_whitelabel/presentation/access/sign_up/bloc/sign_up_event.dart';
import 'package:eco_track_whitelabel/presentation/access/sign_up/bloc/sign_up_state.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/button_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/input_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/sign_up_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpBlocProvider = Provider.autoDispose<SignUpBloc>((ref) {
  final signUpUC = ref.watch(signUpUCProvider);
  final validateNameUC = ref.watch(validateNameUCProvider);
  final validateEmailUC = ref.watch(validateEmailUCProvider);
  final validatePasswordUC = ref.watch(validatePasswordUCProvider);
  final validatePasswordConfirmationUC =
      ref.watch(validatePasswordConfirmationUCProvider);
  return SignUpBloc(
    signUpUC: signUpUC,
    validateNameUC: validateNameUC,
    validateEmailUC: validateEmailUC,
    validatePasswordUC: validatePasswordUC,
    validatePasswordConfirmationUC: validatePasswordConfirmationUC,
  );
});

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required SignUpUC signUpUC,
    required ValidateNameUC validateNameUC,
    required ValidateEmailUC validateEmailUC,
    required ValidatePasswordUC validatePasswordUC,
    required ValidatePasswordConfirmationUC validatePasswordConfirmationUC,
  })  : _signUpUC = signUpUC,
        _validateNameUC = validateNameUC,
        _validateEmailUC = validateEmailUC,
        _validatePasswordUC = validatePasswordUC,
        _validatePasswordConfirmationUC = validatePasswordConfirmationUC,
        super(
          SignUpState(
            signUpStatus: SignUpStatus.idle,
            buttonStatus: ButtonInactive(),
            name: '',
            email: '',
            password: '',
            passwordConfirmation: '',
            nameInputStatus: InputStatus.undefined,
            emailInputStatus: InputStatus.undefined,
            passwordInputStatus: InputStatus.undefined,
            passwordConfirmationInputStatus: InputStatus.undefined,
          ),
        ) {
    on<NameChanged>(_onNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<PasswordConfirmationChanged>(_onPasswordConfirmationChanged);
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  final SignUpUC _signUpUC;
  final ValidateNameUC _validateNameUC;
  final ValidateEmailUC _validateEmailUC;
  final ValidatePasswordUC _validatePasswordUC;
  final ValidatePasswordConfirmationUC _validatePasswordConfirmationUC;

  Future<void> _onNameChanged(NameChanged event, Emitter emit) async {
    await _updateNameInputStatus(event.name, emit);
    _validateFields(emit);
  }

  Future<void> _onEmailChanged(EmailChanged event, Emitter emit) async {
    await _updateEmailInputStatus(event.email, emit);
    _validateFields(emit);
  }

  Future<void> _onPasswordChanged(PasswordChanged event, Emitter emit) async {
    await _updatePasswordInputStatus(event.password, emit);
    if (event.passwordConfirmation.isNotEmpty) {
      await _updatePasswordConfirmationInputStatus(
        event.password,
        event.passwordConfirmation,
        emit,
      );
    }
    _validateFields(emit);
  }

  Future<void> _onPasswordConfirmationChanged(
      PasswordConfirmationChanged event, Emitter emit) async {
    await _updatePasswordConfirmationInputStatus(
      event.password,
      event.passwordConfirmation,
      emit,
    );
    if (event.password.isNotEmpty) {
      await _updatePasswordInputStatus(event.password, emit);
    }
    _validateFields(emit);
  }

  Future<void> _updateNameInputStatus(String name, Emitter emit) async {
    try {
      await _validateNameUC.getFuture(
        ValidateNameUCParams(name),
      );
      emit(
        state.copyWith(
          name: name,
          nameInputStatus: InputStatus.valid,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          name: name,
          nameInputStatus: mapToInputStatus(e),
        ),
      );
    }
  }

  Future<void> _updateEmailInputStatus(String email, Emitter emit) async {
    try {
      await _validateEmailUC.getFuture(
        ValidateEmailUCParams(email),
      );
      emit(
        state.copyWith(
          email: email,
          emailInputStatus: InputStatus.valid,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          email: email,
          emailInputStatus: mapToInputStatus(e),
        ),
      );
    }
  }

  Future<void> _updatePasswordInputStatus(String password, Emitter emit) async {
    try {
      await _validatePasswordUC.getFuture(
        ValidatePasswordUCParams(password),
      );
      emit(state.copyWith(
        password: password,
        passwordInputStatus: InputStatus.valid,
      ));
    } catch (e) {
      emit(state.copyWith(
        password: password,
        passwordInputStatus: mapToInputStatus(e),
      ));
    }
  }

  Future<void> _updatePasswordConfirmationInputStatus(
    String password,
    String passwordConfirmation,
    Emitter emit,
  ) async {
    try {
      await _validatePasswordConfirmationUC.getFuture(
        ValidatePasswordConfirmationUCParams(
          password: password,
          passwordConfirmation: passwordConfirmation,
        ),
      );
      emit(state.copyWith(
        passwordConfirmation: passwordConfirmation,
        passwordConfirmationInputStatus: InputStatus.valid,
      ));
    } catch (e) {
      emit(state.copyWith(
        passwordConfirmation: passwordConfirmation,
        passwordConfirmationInputStatus: mapToInputStatus(e),
      ));
    }
  }

  void _validateFields(Emitter emit) {
    if (state.nameInputStatus == InputStatus.valid &&
        state.emailInputStatus == InputStatus.valid &&
        state.passwordInputStatus == InputStatus.valid &&
        state.passwordConfirmationInputStatus == InputStatus.valid) {
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

  void _onSignUpSubmitted(SignUpSubmitted event, Emitter emit) async {
    emit(
      state.copyWith(
        buttonStatus: ButtonLoading(),
      ),
    );

    try {
      await _signUpUC.getFuture(
        SignUpUCParams(
          name: event.name,
          email: event.email,
          password: event.password,
          profileImage: event.profileImage,
        ),
      );
      emit(
        state.copyWith(
          buttonStatus: ButtonInactive(),
          signUpStatus: SignUpStatus.success,
        ),
      );
    } catch (e) {
      if (e is EmailAlreadyInUseException) {
        emit(
          state.copyWith(
            buttonStatus: ButtonInactive(),
            signUpStatus: SignUpStatus.emailAlreadyUsed,
            emailInputStatus: InputStatus.invalid,
          ),
        );
      } else {
        emit(
          state.copyWith(
            buttonStatus: ButtonActive(),
            signUpStatus: SignUpStatus.undefinedError,
          ),
        );
      }
    }
  }
}
