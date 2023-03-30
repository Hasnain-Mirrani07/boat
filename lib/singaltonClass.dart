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

class SessionControllerCID {
  static final SessionControllerCID _session = SessionControllerCID._internal();

  String? cid;

  factory SessionControllerCID() {
    return _session;
  }
  SessionControllerCID._internal();
}
