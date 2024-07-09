abstract class EcoTrackException implements Exception {}

class UnexpectedException implements EcoTrackException {}

class NoConnectionException implements EcoTrackException {}

class NullResponseException implements EcoTrackException {}

class ConnectionTimedOutException implements EcoTrackException {}