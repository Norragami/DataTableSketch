import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tables/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> _selected = [];

  @override
  void initState() {
    super.initState();
    _selected = List<bool>.generate(people.length, (int index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Работа с таблицами'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: SingleChildScrollView(
                child: DataTable(
                    showCheckboxColumn: true,
                    columnSpacing: 120.0,
                    dataTextStyle: myTextStyle,
                    headingTextStyle: myHeadingTextStyle,
                    border: const TableBorder(
                      top: BorderSide(color: Colors.black, width: 1.0),
                      bottom: BorderSide(color: Colors.black, width: 1.0),
                      horizontalInside:
                          BorderSide(color: Colors.black, width: 1.0),
                      verticalInside: BorderSide(color: Colors.black, width: 1.0),
                      left: BorderSide(color: Colors.black, width: 1.0),
                      right: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    columns: const <DataColumn>[
                      DataColumn(label: Text('Фамилия')),
                      DataColumn(label: Text('Имя')),
                      DataColumn(label: Text('Отчество')),
                      DataColumn(label: Text('Дата рождения')),
                    ],
                    rows: people
                        .map((e) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(e.surname)),
                                  DataCell(Text(e.name)),
                                  DataCell(Text(e.patronymic)),
                                  DataCell(Text(e.dateOfBirth)),
                                ],
                                selected: _selected[people.indexOf(e)],
                                onSelectChanged: (bool? selected) {
                                  setState(() {
                                    _selected[people.indexOf(e)] = selected!;
                                  });
                                }))
                        .toList()),
              ),
            ),
            const SizedBox(height: 40),
            ReactiveForm(
              formGroup: form,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: ReactiveTextField(
                        formControlName: 'lastname',
                        decoration: const InputDecoration(
                          labelText: 'Фамилия',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: ReactiveTextField(
                        formControlName: 'name',
                        decoration: const InputDecoration(
                          labelText: 'Имя',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  Expanded(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: ReactiveTextField(
                            formControlName: 'patronymic',
                            decoration: const InputDecoration(
                              labelText: 'Отчество',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            )),
                      )),
                  
                  Expanded(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                        child: ReactiveTextField(
                            formControlName: 'birthday',
                            decoration: const InputDecoration(
                              labelText: 'Дата рождения',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            )),
                      )),
                ],
              ),
            ),
            const SizedBox( height: 60.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: const Text('Сохранить', style: TextStyle(fontSize: 20.0, ),),
                  onPressed: () {
                    if (form.valid)
                     {
                      var temp = Person(form.control('name').value,form.control('lastname').value,  form.control('patronymic').value, form.control('birthday').value);
                      people.add(temp);
                      form.reset();
                    }
                    else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Заполните все поля, используя требуемые символы'),
                  ));
                }
                setState(() {
                  
                  _selected = List<bool>.generate(people.length, (int index) => false);
                });
                  },
                ),
                ElevatedButton(
                  child: const Text('Удалить', style: TextStyle(fontSize: 20.0, ),),
                  onPressed: () {
                    setState(() {
                      people.removeWhere((element) => _selected[people.indexOf(element)]);
                    });
                  }
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
