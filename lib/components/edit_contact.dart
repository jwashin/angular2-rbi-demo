import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular2_rbi/directives.dart';
import 'package:contact_list/services/contacts.dart';

@Component(
    selector: 'edit-contact',
    templateUrl: 'edit_contact.html',
    directives: const [
      CORE_DIRECTIVES,
      FORM_DIRECTIVES,
      MaterialTextfield,
      MaterialButton
    ])
class EditContact {
  Contact contact;
  String uuid = '';

  final Contacts _contacts;
  final RouteParams _params;
  final Router _router;
  final Map<String, String> iconRepresentations = {
    'friend': 'face',
    'work': 'work',
    'family': 'home'
  };

  EditContact(this._contacts, this._params, this._router) {
    if (_params.get('uuid').isNotEmpty) {
      uuid = _params.get('uuid');
      Contact oldContact = _contacts.contactFromUuid(uuid);
      contact = new Contact(oldContact.last, oldContact.first, oldContact.phone,
          oldContact.contactType, oldContact.uuid);
    } else {
      contact = new Contact('', '', '', 'friend', '');
    }
  }

  String get iconGlyph {
    if (iconRepresentations.containsKey(contact.contactType)) {
      return iconRepresentations[contact.contactType];
    }
    return 'insert_emoticon';
  }

  String phoneDisplay(String aString) {
    if (aString.length != 10) {
      aString = aString.padRight(10);
    }
    String a = aString.substring(0, 3);
    String b = aString.substring(3, 6);
    String c = aString.substring(6, 10);
    return '($a) $b-$c';
  }

  void saveItem() {
    if (uuid.isEmpty) {
      _contacts.addContact(
          contact.last, contact.first, contact.phone, contact.contactType);
    } else {
      _contacts.updateContact(contact);
    }
    navigateOut();
  }

  void navigateOut() {
    _router.navigate([
      'Default',
      {'filter': _contacts.currentFilter}
    ]);
  }

  void cancel() {
    navigateOut();
  }
}
