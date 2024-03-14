// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, sort_child_properties_last, body_might_complete_normally_nullable
import 'package:akademi_student_app/models/teacher.dart';
import 'package:akademi_student_app/services/data_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeacherForm extends ConsumerStatefulWidget {
  const TeacherForm({super.key});

  @override
  _TeacherFormState createState() => _TeacherFormState();
}

class _TeacherFormState extends ConsumerState<TeacherForm> {
  final Map<String, dynamic> added = {};
  final _formKey = GlobalKey<FormState>();

  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Teacher'),
        backgroundColor: Theme.of(context)
            .colorScheme
            .inversePrimary, // Örnek bir renk belirttim, istediğiniz rengi kullanabilirsiniz
        // Diğer özelleştirmeleri buraya ekleyebilirsiniz
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Name'),
                    ),
                    validator: (value) {
                      if (value?.isNotEmpty != true) {
                        return 'You need to enter the name';
                      }
                    },
                    onSaved: (newValue) {
                      added['name'] = newValue;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Surname'),
                    ),
                    validator: (value) {
                      if (value?.isNotEmpty != true) {
                        return 'You need to enter the surname';
                      }
                    },
                    onSaved: (newValue) {
                      added['surname'] = newValue;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Age'),
                    ),
                    validator: (value) {
                      if (value == null || value.isNotEmpty != true) {
                        return 'You need to enter age';
                      }
                    },
                    keyboardType: TextInputType.number,
                    onSaved: (newValue) {
                      added['age'] = int.parse(newValue!);
                    },
                  ),
                  DropdownButtonFormField(
                    items: const [
                      DropdownMenuItem(child: Text('Erkek'), value: 'Erkek'),
                      DropdownMenuItem(child: Text('Kadın'), value: 'Kadın')
                    ],
                    value: added['gender'],
                    onChanged: (value) {
                      setState(() {
                        added['gender'] = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select gender';
                      }
                    },
                  ),
                  isSaving
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            final formState = _formKey.currentState;
                            if (formState == null) return;
                            if (formState.validate() == true) {
                              formState.save();
                              if (kDebugMode) {
                                print(added);
                              }
                            }
                            _save();
                          },
                          child: const Text('Save'))
                ],
              )),
        ),
      ),
    );
  }

  Future<void> _save() async {
    bool finish = false;

    while (!finish) {
      try {
        setState(() {
          isSaving = true;
        });
        await realSave();
        finish = true;
        Navigator.of(context).pop(true);
      } catch (e) {
       final snackBar = ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
            await snackBar.closed;
      } finally {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  int i =0;

  Future<void> realSave() async {
    i++;
    if(i<3){
      throw 'Did not saved';
    }
    await ref.read(dataServiceProvider).teacherAdd(Teacher.fromMap(added));
  }
}
