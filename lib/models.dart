import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

TextStyle myTextStyle = const TextStyle(
  fontSize: 20.0,
  color: Colors.black,
);
TextStyle myHeadingTextStyle = const TextStyle(
    fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold);

class Person {
  String name;
  String surname;
  String patronymic;
  DateTime dateOfBirth;

  Person(this.name, this.surname, this.patronymic, this.dateOfBirth);
}

List<Person> people = [

];
  // Person('Иван', 'Иванов', 'Иванович', "01.01.2000"),
  // Person('Владимир', 'Бардышев', 'Николаевич', "01.01.2000"),

final form = fb.group(
  {
    'lastname': FormControl<String>(
      value: '',
      validators: [const OnlyRussianLettersValidator()],
    ),
    'name': FormControl<String>(
      value: '',
      validators: [const OnlyRussianLettersValidator()],
    ),
    'patronymic': FormControl<String>(
      value: '',
      validators: [const OnlyRussianLettersValidator()],
    ),
    'birthday': FormControl<DateTime>(
      
      validators: [],
    ),
  },
);

class OnlyRussianLettersValidator extends Validator<dynamic> {
  static final RegExp emailRegex = RegExp(r'^[а-яА-ЯёЁ\-]+$');

  const OnlyRussianLettersValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    // don't validate empty values to allow optional controls
    return ((control.isNotNull ||
            control.value.toString().isNotEmpty) &&
            emailRegex.hasMatch(control.value.toString()))
        ? null
        : <String, dynamic>{'Только русские буквы': true};
  }
}

class DataValidator extends Validator<dynamic> {
  static final RegExp emailRegex = RegExp(r'^[0-9]{2}.[0-9]{2}.[0-9]{4}$');
  const DataValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    // don't validate empty values to allow optional controls
    return ((control.isNotNull ||
            control.value.toString().isNotEmpty) &&
            emailRegex.hasMatch(control.value.toString()))
        ? null
        : <String, dynamic>{'Введите дату в формате 01.01.2000': true};
  }
}



