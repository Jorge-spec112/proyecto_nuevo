abstract class FormEvent {}

class SubmitForm extends FormEvent {
  final String name;
  final String email;

  SubmitForm(this.name, this.email);
}
