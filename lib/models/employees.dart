
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Employee{
  //int _employee_id;
  String _name;
  //String _dob;
  String _dateJoined;
  String _email;
  String _mob;
  String _document_id;
  double _wages;
  String _managerDocumentId;
  //String _scheme;
  List<String> _searchKeys;
  Employee.blank();

  Employee( this._name,  this._dateJoined,
      this._email,this._wages , this._mob,this._searchKeys);


  List<String> get searchKeys => _searchKeys;

  set searchKeys(List<String> value) {
    _searchKeys = value;
  }

  String get managerDocumentId => _managerDocumentId;

  set managerDocumentId(String value) {
    _managerDocumentId = value;
  }

  String get document_id => _document_id;

  set document_id(String value) {
    _document_id = value;
  }


  double get wages => _wages;

  set wages(double value) {
    _wages = value;
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


  String get name => _name;

  set name(String value) {
    _name = value;
  }



  Map<String, dynamic> toMap(){
    var map = Map<String , dynamic> ();

    //map['employee_id'] = this.employee_id;
    map['name'] = this._name;
    //map['dob'] = this.dob;
    map['dateJoined'] = this._dateJoined;
    map['email'] = this._email;
    map['wages'] = this._wages;
    map['mob'] = this._mob;
    map['searchKeys'] = this._searchKeys;
    //map['scheme'] = this._scheme;
    //map['documentId'] = this._document_id;
    //map['managerDocumentId'] = this._managerDocumentId;

    return map;

  }

  Employee.fromMapObject(Map<String,dynamic> map){
    this._name = map['name'];
    this._wages = map['wages'];
    //this.employee_id = map['employee_id'];
    //this.dob = map['dob'];
    this._dateJoined =  map['dateJoined'];
    this._email = map['email'];
    this._mob = map['mob'];
    this._searchKeys = map['searchKeys'];
    //this._scheme = map['scheme'];
    //this._document_id = map['documentId'];
    //this._managerDocumentId = map['managerDocumentId'];
  }

  Employee.fromQurrySnapshot(QueryDocumentSnapshot data){
    this.name = data['name'];
    this.email = data['email'];
    this._wages = data['wages'];
    this.mob = data['mob'];
    this.dateJoined = data['dateJoined'];
  }

}