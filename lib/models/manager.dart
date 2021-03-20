

class Manager{


  String _name;
  String _email;
  //String _dob;
  String _profilePicUrl;
  String _pass;
  String _dateJoined;
  String _mob;
  //String _id;
  String _documentId;

  Manager.blank();



  Manager(this._name, this._email, this._pass, this._dateJoined,
      this._mob);


  String get profilePicUrl => _profilePicUrl;

  set profilePicUrl(String value) {
    _profilePicUrl = value;
  }

  String get documentId => _documentId;

  set documentId(String value) {
    _documentId = value;
  }



  String get mob => _mob;

  set mob(String value) {
    _mob = value;
  }

  String get dateJoined => _dateJoined;

  set dateJoined(String value) {
    _dateJoined = value;
  }

  String get pass => _pass;

  set pass(String value) {
    _pass = value;
  }



  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }


  Map<String,dynamic> toMap(){

    var map =  Map<String, dynamic> ();
    map['name'] = this._name;
    map['pass'] = this._pass;
    map['email'] = this._email;
    map['dateJoined'] = this._dateJoined;
    //map['dob'] = this._dob;
     map['profilePicUrl'] = this._profilePicUrl;
    map['mob'] = this._mob;
    //map['managerId'] = this._managerId;
    //map['documentId'] = this._documentId;

    return map;

  }

  Manager.fromMapObject(Map<String ,dynamic> map){
    //this._managerId = map['managerId'];
    this._profilePicUrl = map['profilePicUrl'];
    this._name = map['name'];
    this._email = map['email'];
    this._pass = map['pass'];
    this._mob = map['pass'];
    this._dateJoined = map['dateJoined'];
    //this._dob = map['dob'];
    //this._documentId = map['documentId'];


  }

}