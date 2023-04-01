class SessionController {
  static final SessionController _session = SessionController._internal();

  String? userId;

  factory SessionController() {
    return _session;
  }
  SessionController._internal();
}

class SessionControllerOwner {
  static final SessionControllerOwner _session =
      SessionControllerOwner._internal();

  String? owneruid;

  factory SessionControllerOwner() {
    return _session;
  }
  SessionControllerOwner._internal();
}

class SessionControllerToken {
  static final SessionControllerToken _session = SessionControllerToken._internal();

  String? dtoken;

  factory SessionControllerToken() {
    return _session;
  }
  SessionControllerToken._internal();
}
