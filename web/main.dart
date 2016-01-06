import 'package:angular2/bootstrap.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:uuid/uuid.dart';
import 'package:contact_list/services/contacts.dart';

import 'package:contact_list/app.dart';

void main() {
  bootstrap(App, [
    provide(Uuid, useValue: new Uuid()),
    Contacts,
    ROUTER_PROVIDERS,
    provide(LocationStrategy, useClass: HashLocationStrategy),
  ]);
}
