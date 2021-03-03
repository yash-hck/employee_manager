class Employee{
  //int _employee_id;
  String _name;
  String _dob;
  String _dateJoined;
  String _email;
  String _mob;
  String _document_id;
  String _managerDocumentId;

  Employee.blank();

  Employee( this._name, this._dob, this._dateJoined,
      this._email, this._mob);


  String get managerDocumentId => _managerDocumentId;

  set managerDocumentId(String value) {
    _managerDocumentId = value;
  }

  String get document_id => _document_id;

  set document_id(String value) {
    _document_id = value;
  }


  String get mob => _mob;

  set mob(String value) {
    _mob = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }


  String get dateJoined => _dateJoined;

  set dateJoined(String value) {
    _dateJoined = value;
  }

  String get dob => _dob;

  set dob(String value) {
    _dob = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }



  Map<String, dynamic> toMap(){
    var map = Map<String , dynamic> ();

    //map['employee_id'] = this.employee_id;
    map['name'] = this._name;
    map['dob'] = this.dob;
    map['dateJoined'] = this._dateJoined;
    map['email'] = this._email;
    map['mob'] = this._mob;
    //map['documentId'] = this._document_id;
    //map['managerDocumentId'] = this._managerDocumentId;

    return map;

  }

  Employee.fromMapObject(Map<String,dynamic> map){
    this._name = map['name'];
    //this.employee_id = map['employee_id'];
    this.dob = map['dob'];
    this._dateJoined =  map['dateJoined'];
    this._email = map['email'];
    this._mob = map['mob'];
    //this._document_id = map['documentId'];
    //this._managerDocumentId = map['managerDocumentId'];
  }

}