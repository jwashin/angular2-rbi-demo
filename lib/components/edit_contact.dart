import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:contact_list/services/contacts.dart';
import 'package:angular2_rbi/directives.dart';
import 'dart:html';

const String IS_DIRTY = 'is-dirty';

@Component(
    selector: 'edit-contact',
    templateUrl: 'edit_contact.html',
    directives: const [
      CORE_DIRECTIVES,
      FORM_DIRECTIVES,
      MaterialTextfield,
      MaterialButton
    ])
class EditContact implements AfterContentChecked {
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

  void ngAfterContentChecked() {
    // hacky stuff to make form elements look right
    // looks like MDL widgets get values after they are initialized, so they
    // don't appear to know their values.

    if (uuid.isNotEmpty) {
      List<Element> textFields = querySelectorAll('.mdl-js-textfield');
      for (Element k in textFields) {
        if (k.firstChild.text.isNotEmpty && k.firstChild.text.length > 0) {
          k.classes.add(IS_DIRTY);
        }
      }
    }
  }

  String get iconGlyph{
    if (iconRepresentations.containsKey(contact.contactType)){
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
    if (uuid == '') {
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
