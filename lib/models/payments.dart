class Payments{
  String _date;
  String _method;
  int _amount;
  String _documentId;

  Payments(this._date, this._method, this._amount);

  String get documentId => _documentId;

  set documentId(String value) {
    _documentId = value;
  }

  int get amount => _amount;

  set amount(int value) {
    _amount = value;
  }

  String get method => _method;

  set method(String value) {
    _method = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic> ();

    map['date'] = this._date;
    map['method'] = this.method;
    map['amount'] = this._amount;
    //map['documentId'] = this._documentId;

    return map;

  }

  Payments.fromMapObject(Map<String ,dynamic> map){

    this._date = map['date'];
    this._amount = map['method'];
    this._method = map['amount'];
    //this._documentId = map['documentId'];
  }


}