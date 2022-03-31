class PermissionCallBack {
  Function _onAllow;
  Function _onDeny;
  Function _onDisable;

  PermissionCallBack(onAllow, onDeny, onDisable) {
    _onAllow = onAllow;
    _onDeny = onDeny;
    _onDisable = onDisable;
  }

  void onAllow() {
    _onAllow();
  }

  void onDeny() {
    _onDeny();
  }

  void onDisable() {
    _onDisable();
  }
}
