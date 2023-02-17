class Telephone {
  final int _numeroTelephone;
  final bool _visible;
  Telephone({required int numeroTelephone, required bool visible})
      : _numeroTelephone = numeroTelephone,
        _visible = visible;

  int get numeroTelephone => _numeroTelephone;
  bool get visible => _visible;
}
