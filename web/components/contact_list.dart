library contact_list.components.contact_list;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:contact-list/contacts.dart';
import 'package:angular2_rbi/directives.dart';

@Component(selector: 'contact-list', inputs: const ['filter'])
@View(
    templateUrl: 'contact_list.html',
    directives: const [CORE_DIRECTIVES, MaterialButton])
class ContactList {
  Contacts data;
  String filter = '';
  RouteParams params;
  List contacts;

// icons: home face work

  ContactList(this.data, this.params) {
    if (params.get('filter') != null) {
      filter = params.get('filter');
    }
    contacts = data.filteredContacts(filter);
  }

  phoneDisplay(String aString) {
    if (aString.length != 10) {
      return aString;
    }
    String a = aString.substring(0, 3);
    String b = aString.substring(3, 6);
    String c = aString.substring(6, 10);
    return '($a) $b-$c';
  }

  addContact(last, first, String phone) {
    data.addContact(last, first, phone);
  }

//  removeContact(contact) => contacts.removeContact(contact);
}
