library contact_list.components.delete_confirm;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:contact_list/services/contacts.dart';

@Component(selector: 'delete-confirm')
@View(templateUrl: 'delete_confirm.html', directives: const [CORE_DIRECTIVES])
class DeleteConfirm {
  final Contacts contacts;
  final Router router;
  final RouteParams params;
  Contact contact;

  DeleteConfirm(this.contacts, this.params, this.router) {
    if (params.get('uuid') != null) {
      contact = contacts.contactFromUuid(params.get('uuid'));
    }
  }

  void deleteItem(String uuid) {
    if (contact != null) contacts.removeContact(contact);
    router.navigate([
      'Default',
      {'filter': contacts.currentFilter}
    ]);
  }

  void cancel() {
    router.navigate([
      'Default',
      {'filter': contacts.currentFilter}
    ]);
  }
}
