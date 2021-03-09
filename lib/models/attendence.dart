class Attendence{
  String _date;
  int _overtime;
  bool _fullDay;


  Attendence(this._date, this._overtime,this._fullDay);


  bool get fullDay => _fullDay;

  set fullDay(bool value) {
    _fullDay = value;
  }

  String get date => _date;

  set date(String value) {

    _date = value;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String ,dynamic> ();

    map['date'] = this._date;
    map['overtime'] = this._overtime;
    map['fullday'] = this._fullDay;

    return map;

  }

  Attendence.fromMapObject(Map<String ,dynamic> map){
    this._date = map['date'];
    this._overtime = map['overtime'];
    this._fullDay = map['fullday'];
  }

  int get overtime => _overtime;

  set overtime(int value) {
    _overtime = value;
  }


}