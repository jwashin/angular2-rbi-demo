import 'dart:html';
import 'dart:convert';
import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'package:angular2_rbi/directives.dart';

import 'package:contact_list/services/contacts.dart';
import 'package:contact_list/components/contact_list.dart';
import 'package:contact_list/components/json_export.dart';
import 'package:contact_list/components/delete_confirm.dart';
import 'package:contact_list/components/edit_contact.dart';

// found these in angular2_rbi/src/material_layout.dart
// needed to shut the nav drawer after clicking a link
const String IS_DRAWER_OPEN = 'is-visible';
const String OBFUSCATOR = 'mdl-layout__obfuscator';
const String DRAWER = 'mdl-layout__drawer';

@Component(
    selector: 'app',
    template: '''<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
  <header class="mdl-layout__header">
    <div class="mdl-layout__header-row">
      <!-- Title -->
      <span class="mdl-layout-title">Contacts</span>
      <!-- Add spacer, to align navigation to the right -->
      <div class="mdl-layout-spacer"></div>
      <!-- Navigation -->
      <nav class="mdl-navigation mdl-layout--large-screen-only">
        <a class="mdl-navigation__link" [routerLink]="['/Default', {'filter':''}]">All</a>
        <a class="mdl-navigation__link" [routerLink]="['/Default',{'filter':'family'}]">Family</a>
        <a class="mdl-navigation__link" [routerLink]="['/Default',{'filter':'friend'}]">Friends</a>
        <a class="mdl-navigation__link" [routerLink]="['/Default',{'filter':'work'}]">Work</a>
      </nav>
      <button
          class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon"
          id="hdrbtn">
        <i class="material-icons">more_vert</i>
      </button>
    </div>

  </header>
  <div class="mdl-layout__drawer">
    <span class="mdl-layout-title">Contacts</span>
    <nav class="mdl-navigation" (click)="toggleDrawer()">
      <a class="mdl-navigation__link" [routerLink]="['/Default', {'filter':''}]">All</a>
      <a class="mdl-navigation__link" [routerLink]="['/Default', {'filter':'family'}]">Family</a>
      <a class="mdl-navigation__link" [routerLink]="['/Default', {'filter':'friend'}]">Friends</a>
      <a class="mdl-navigation__link" [routerLink]="['/Default', {'filter':'work'}]">Work</a>
    </nav>
  </div>
    <ul class="mdl-menu mdl-menu--bottom-right mdl-js-menu mdl-js-ripple-effect"
          for="hdrbtn">
     <!--we use buttons here instead of <li> so disabled works.-->
     <button class="mdl-menu__item" [disabled]="examplesLoaded==true" href="#" (click)="loadExampleData()">Load example data</button>
     <button class="mdl-menu__item" href="#" (click)="exportJson()">JSON Export</button>
  </ul>
  <main class="mdl-layout__content">
    <div class="page-content">
      <div *ngIf="loading" class="spinner">
        <div class="mdl-spinner mdl-js-spinner is-active"></div>
      </div>
      <router-outlet></router-outlet>
    </div>
  </main>
</div>
    ''',
    directives: const [
      ContactList,
      MaterialButton,
      MaterialMenu,
      MaterialLayout,
      ROUTER_DIRECTIVES,
      MaterialSpinner,
      NgIf
    ])
@RouteConfig(const [
  const Route(path: '/:filter', component: ContactList, name: 'Default'),
  const Route(path: '/json', component: JsonExport, name: 'Json'),
  const Route(path: '/delete:uuid', component: DeleteConfirm, name: 'Delete'),
  const Route(path: '/edit:uuid', component: EditContact, name: 'Edit')
])
class App {
  bool examplesLoaded = false;
  bool loading = false;

  final Router _router;
  final Contacts _contacts;

  App(this._router, this._contacts) {
    loadExampleData();
  }

  void toggleDrawer() {
    // make the drawer go away when a link is clicked.
    // These elements are dynamically generated for MDL. The constants are
    // found in in angular2_rbi/src/material_layout.dart.
    Element drawer = querySelector('.$DRAWER');
    drawer.classes.toggle(IS_DRAWER_OPEN);
    Element obfuscator = querySelector('.$OBFUSCATOR');
    obfuscator.classes.toggle(IS_DRAWER_OPEN);
  }

  void exportJson() {
    _router.navigate(['Json']);
  }

  Future loadExampleData() async {
    loading = true;
    String data = await HttpRequest.getString('contacts.json');

    // just a bit of delay so the spinner shows
    new Timer(new Duration(seconds: 1), () {
      List exampleData = JSON.decode(data);
      examplesLoaded = true;

      for (Map item in exampleData) {
        _contacts.addContact(item['last'], item['first'], item['phone'],
            item['contactType'], item['uuid']);
      }
      //refresh page with the new data
      _router.navigate([
        'Default',
        {'filter': _contacts.currentFilter}
      ]);
      loading = false;
    });
  }
}
