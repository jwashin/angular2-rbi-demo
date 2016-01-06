library contact_list.components.delete_confirm;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:contact_list/services/contacts.dart';

@Component(
    selector: 'delete-confirm',
    templateUrl: 'delete_confirm.html',
    directives: const [CORE_DIRECTIVES])
class DeleteConfirm {
  Contact contact;

  final Contacts _contacts;
  final Router _router;
  final RouteParams _params;

  DeleteConfirm(this._contacts, this._params, this._router) {
    if (_params.get('uuid') != null) {
      contact = _contacts.contactFromUuid(_params.get('uuid'));
    }
  }

  void deleteItem(String uuid) {
    if (contact != null) _contacts.removeContact(contact);
    _router.navigate([
      'Default',
      {'filter': _contacts.currentFilter}
    ]);
  }

  void cancel() {
    _router.navigate([
      'Default',
      {'filter': _contacts.currentFilter}
    ]);
  }
}
