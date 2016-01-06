library contact_list.components.json_export;

import 'package:angular2/angular2.dart';
import 'package:contact_list/contacts.dart';
import 'dart:convert';

@Component(selector: 'json-export')
@View(
    template: '''
    <code>
    {{asJson()}}
    <code>
    ''')
class JsonExport {
  Contacts data;

  JsonExport(this.data){
  }

  asJson(){return JSON.encode(data);}
}
