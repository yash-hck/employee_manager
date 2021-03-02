class Attendence{
  String _date;
  int _overtime;
  String _documetId;


  Attendence(this._date, this._overtime);


  String get date => _date;

  set date(String value) {
    _date = value;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String ,dynamic> ();

    map['date'] = this._date;
    map['overtime'] = this._overtime;

    return map;

  }

  Attendence.fromMapObject(Map<String ,dynamic> map){
    this._date = map['date'];
    this._overtime = map['overtime'];
  }

  int get overtime => _overtime;

  set overtime(int value) {
    _overtime = value;
  }


}