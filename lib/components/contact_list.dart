library contact_list.components.contact_list;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:contact_list/services/contacts.dart';
import 'package:angular2_rbi/directives.dart';

@Component(selector: 'contact-list', inputs: const ['filter'])
@View(
    templateUrl: 'contact_list.html',
    directives: const [CORE_DIRECTIVES, MaterialButton])
class ContactList {
  String filter = '';
  List contacts;

  final Contacts _data;
  final RouteParams _params;
  final Router _router;

  ContactList(this._data, this._params, this._router) {
    if (_params.get('filter') != null) {
      filter = _params.get('filter');
    }
    contacts = _data.filteredContacts(filter);
    _data.currentFilter = filter;
  }

  String phoneDisplay(String aString) {
    if (aString.length != 10) {
      return aString;
    }
    String a = aString.substring(0, 3);
    String b = aString.substring(3, 6);
    String c = aString.substring(6, 10);
    return '($a) $b-$c';
  }

  void editContact(String uuid) {
    _router.navigate([
      'Edit',
      {'uuid': uuid}
    ]);
  }

  void addContact(String last, String first, String phone) {
    _data.addContact(last, first, phone);
  }

  void deleteItem(String uuid) {
    _router.navigate([
      'Delete',
      {'uuid': uuid}
    ]);
  }
}
