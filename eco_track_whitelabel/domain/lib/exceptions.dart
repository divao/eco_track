abstract class EcoTrackException implements Exception {}

class UnexpectedException implements EcoTrackException {}

class NoConnectionException implements EcoTrackException {}

class NullResponseException implements EcoTrackException {}

class ConnectionTimedOutException implements EcoTrackException {}

class InvalidCredentialsException implements EcoTrackException {}

class EmailAlreadyInUseException implements EcoTrackException {}

class UserNotLoggedException implements EcoTrackException {}

class ResponseParseException implements EcoTrackException {}

class EmptyFormFieldException implements EcoTrackException {}

class InvalidFormFieldException implements EcoTrackException {}

class BackendValidationException implements EcoTrackException {}