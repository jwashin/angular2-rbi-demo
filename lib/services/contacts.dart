library contacts_service;

import 'package:angular2/angular2.dart';
import 'package:uuid/uuid.dart';

@Injectable()
class Contacts {
  List<Contact> contacts = [];
  int get length => contacts.length;
  String currentFilter;

  final Uuid _uuidGenerator;
  final List<String> _types = ['family', 'friend', 'work'];

  Contacts(this._uuidGenerator);

  void addContact(String last, String first, String phone,
      [String contactType, String uuid]) {
    if (uuid == null || uuid.isEmpty) {
      uuid = _uuidGenerator.v4();
    }
    if (contactType == null || contactType.isEmpty) {
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
    return contacts.firstWhere((c) => c.uuid == uuid, orElse: () => null);
  }

  List<Contact> filteredContacts(String aFilter) {
    if (!_types.contains(aFilter)) return contacts;
    return contacts.where((c) {
      return c.contactType == aFilter;
    }).toList();
  }

  List<Contact> toJson() => contacts;
}

class Contact {
  String last, first, phone, contactType;
  final String uuid;

  Contact(this.last, this.first, this.phone, this.contactType, this.uuid);

  Map<String, String> toJson() => {
        'uuid': uuid,
        'last': last,
        'first': first,
        'phone': phone,
        'contactType': contactType
      };
}
