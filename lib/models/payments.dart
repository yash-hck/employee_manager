class Payments{
  String _date;
  String _method;
  String _amount;
  String _recipent;

  Payments(this._date, this._method, this._amount, this._recipent);

  Payments.blank();
  String get recipent => _recipent;

  set recipent(String value) {
    _recipent = value;
  }


  String get amount => _amount;

  set amount(String value) {
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
    map['recipent'] = this.recipent;
    //map['documentId'] = this._documentId;

    return map;

  }

  Payments.fromMapObject(Map<String ,dynamic> map){

    this._date = map['date'];
    this._amount = map['method'];
    this._method = map['amount'];
    this.recipent = map['recipent'];
    //this._documentId = map['documentId'];
  }


}