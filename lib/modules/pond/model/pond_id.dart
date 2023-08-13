class PondID {
  PondID._();
  static final PondID _instance = PondID._();
  factory PondID() {
    return _instance;
  }
  String? _pondId;

  void Function(String? id) get addId => (String? id) {
        _pondId = id;
      };

  String? get id => _pondId;
}
