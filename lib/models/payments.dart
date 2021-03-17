class Payments{
  String _date;
  String _method;
  double _amount;
  String _recipent;
  String _recipentName;
  String _issuer;

  String get issuer => _issuer;

  set issuer(String value) {
    _issuer = value;
  }

  Payments.blank();

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  Payments(this._date, this._method, this._amount, this._recipent,
      this._recipentName);

  String get method => _method;

  String get recipentName => _recipentName;



  set recipentName(String value) {
    _recipentName = value;
  }

  String get recipent => _recipent;

  set recipent(String value) {
    _recipent = value;
  }

  double get amount => _amount;

  set amount(double value) {
    _amount = value;
  }

  set method(String value) {
    _method = value;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String , dynamic>();
    map['date'] = this._date;
    map['method'] = this._method;
    map['amount'] = this._amount;
    map['recipent'] = this._recipent;
    map['recipentName'] = this._recipentName;
    //map['issuer'] = this._issuer;

    return map;
  }

  Payments.fromMapObject(Map<String, dynamic> map){
    this._amount = map['amount'];
    this._method = map['method'];
    this._date = map['date'];
    this._recipentName = map['recipentName'];
    this._recipent = map['recipent'];
   // this._issuer = map['issuer'];
  }


}