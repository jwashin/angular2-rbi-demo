library contact_list.components.delete_confirm;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:contact_list/contacts.dart';

@Component(selector: 'delete-confirm')
@View(templateUrl: 'delete_confirm.html', directives: const [CORE_DIRECTIVES])
class DeleteConfirm {
  Contacts contacts;
  Router router;
  Contact contact;
  RouteParams params;
  DeleteConfirm(this.contacts, this.params, this.router) {
    if (params.get('uuid') != null) {
      contact = contacts.contactFromUuid(params.get('uuid'));
    }
  }
  deleteItem(uuid){
    if (contact !=null)
    contacts.removeContact(contact);
    router.navigate(['Default',{'filter':contacts.currentFilter}]);
  }

  cancel(){
    router.navigate(['Default',{'filter':contacts.currentFilter}]);
  }

}
