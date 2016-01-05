import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:contact-list/contacts.dart';
import 'package:angular2_rbi/directives.dart';
import 'dart:html';

const String IS_DIRTY = 'is-dirty';

@Component(selector: 'edit-contact')
@View(
    templateUrl: 'edit_contact.html',
    directives: const [
      CORE_DIRECTIVES,
      FORM_DIRECTIVES,
      MaterialTextfield,
      MaterialButton
    ])
class EditContact implements AfterContentChecked {
  Contacts contacts;
  Router router;
  Contact contact;
  RouteParams params;
  String uuid = '';
  EditContact(this.contacts, this.params, this.router) {
    if (params.get('uuid') != '') {
      uuid = params.get('uuid');
      Contact oldContact = contacts.contactFromUuid(uuid);
      contact = new Contact(oldContact.last, oldContact.first, oldContact.phone,
          oldContact.contactType, oldContact.uuid);
    } else {
      contact = new Contact('', '', '', 'friend', '');
    }
  }

  ngAfterContentChecked() {
    // hacky stuff to make form elements look right
    // looks like MDL widgets get values after they are initialized, so they
    // don't appear to know their values.

    if (uuid != '') {
      List<Element> textfields = querySelectorAll('.mdl-js-textfield');
      for (Element k in textfields) {
        if (k.firstChild.text != null && k.firstChild.text.length > 0) {
          k.classes.add(IS_DIRTY);
        }
      }
    }
  }

  phoneDisplay(String aString) {
    if (aString.length != 10) {
      aString = aString.padRight(10);
    }
    String a = aString.substring(0, 3);
    String b = aString.substring(3, 6);
    String c = aString.substring(6, 10);
    return '($a) $b-$c';
  }

  saveItem() {
    if (uuid == '') {
      contacts.addContact(
          contact.last, contact.first, contact.phone, contact.contactType);
    } else {
      contacts.updateContact(contact);
    }
    navigateOut();
  }

  navigateOut() {
    router.navigate([
      'Default',
      {'filter': contacts.currentFilter}
    ]);
  }

  cancel() {
    navigateOut();
  }
}
