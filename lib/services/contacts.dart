library contacts_service;

import 'package:angular2/angular2.dart';
import 'package:uuid/uuid.dart';

Uuid uuidGenerator = new Uuid();

@Injectable()
class Contacts {
  List<Contact> contacts = [];
  List<String> types = ['family', 'friend', 'work'];
  int get length => contacts.length;
  String currentFilter;

  void addContact(String last, String first, String phone,
      [String contactType, String uuid]) {
    if (uuid == null || uuid == '') {
      uuid = uuidGenerator.v4();
    }
    if (contactType == null || contactType == '') {
      contactType = 'friend';
    }
    contacts.add(new Contact(last, first, phone, contactType, uuid));
    sortContacts();
  }

  void sortContacts() {
    contacts.sort((a, b) {
      return (a.last + a.first).compareTo(b.last + b.first);
    });
  }

  void updateContact(Contact aContact) {
    Contact oldContact = contactFromUuid(aContact.uuid);
    int idx = contacts.indexOf(oldContact);
    contacts[idx] = aContact;
    sortContacts();
  }

  bool removeContact(Contact contact) => contacts.remove(contact);

  Contact contactFromUuid(String uuid) {
    for (Contact item in contacts) {
      if (item.uuid == uuid) {
        return item;
      }
    }
    return null;
  }

  List<Contact> filteredContacts(String aFilter) {
    if (!types.contains(aFilter)) return contacts;
    return contacts.where((c) {
      return c.contactType == aFilter;
    }).toList();
  }

  List<Contact> toJson() {
    return contacts;
  }
}

class Contact {
  String uuid, last, first, phone, contactType;

  Contact(this.last, this.first, this.phone, this.contactType, this.uuid);

  Map<String, String> toJson() => {
        'uuid': uuid,
        'last': last,
        'first': first,
        'phone': phone,
        'contactType': contactType
      };
}
