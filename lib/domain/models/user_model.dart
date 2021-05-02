class Sucursal {
  String _numeroEmpleado;
  String _nombreCompleto;
  String _nss;
  String _curp;
  String _rfc;
  String _telefono;

  // ignore: unnecessary_getters_setters
  get numeroEmpleado => _numeroEmpleado;
  // ignore: unnecessary_getters_setters
  set numeroEmpleado(String value) {
    _numeroEmpleado = value;
  }

  // ignore: unnecessary_getters_setters
  get nombreCompleto => _nombreCompleto;
  set nombreCompleto(String value) {
    _nombreCompleto = value;
  }

  get nss => _nss;
  set nss(String value) {
    _nss = value;
  }

  get curp => _curp;
  set curp(String value) {
    _curp = value;
  }

  get rfc => _rfc;
  set rfc(String value) {
    _rfc = value;
  }

  get telefono => _telefono;
  set telefono(String value) {
    _telefono = value;
  }

  Sucursal();
}