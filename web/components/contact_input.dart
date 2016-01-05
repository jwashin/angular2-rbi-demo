String s='''    <div class="addContactControls">
      <input #name placeholder="name">
      <input #phone placeholder="phone">
      <button (click)="addContact(name.value, phone.value)">Add Contact</button>
    </div>''';
