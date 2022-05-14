import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie/components/home_page.dart';
import 'package:pie/components/util.dart';
import 'package:pie/entities/account.dart';
import 'package:pie/lib/config.dart';
import 'package:pie/lib/errors.dart';
import 'package:pie/lib/global.dart';
import 'package:pie/lib/log.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pie'),
      ),
      body: Center(
        child: Padding(
          padding: pagePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/icon/icon.png', width: logoSideLen),
              widgetSpacing,
              Text('Communicate freely', style: TextStyle(color: Theme.of(context).primaryColor)),
              widgetSpacing,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(blockButtonPadding)),
                  child: const Text('登录', style: TextStyle(fontSize: blockButtonTextSize)),
                  onPressed: () {},
                ),
              ),
              widgetSpacing,
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(blockButtonPadding)),
                  child: const Text('注册', style: TextStyle(fontSize: blockButtonTextSize)),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateAccountPage())),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateAccountPage extends ConsumerStatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends ConsumerState<CreateAccountPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PlatformFile? _avatarFile;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('注册')),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: pagePadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: selectAvatar,
                    child: CircleAvatar(
                      radius: logoSideLen / 2,
                      backgroundImage: _avatarFile != null ? Image.file(File(_avatarFile!.path!)).image : null,
                      child: Stack(
                        children: [
                          if (_avatarFile == null) const Icon(Icons.person, size: logoSideLen),
                          Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: <Color>[Colors.black.withAlpha(0), Colors.black26, Colors.black26],
                              ),
                            ),
                            child: const Text('选择头像', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  widgetSpacing,
                  TextFormField(
                    controller: _nameController,
                    validator: requiredValidator,
                    autofocus: true,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: '昵称',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  widgetSpacing,
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: '邮箱（可选）',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  widgetSpacing,
                  TextFormField(
                    controller: _bioController,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: '个人简介（可选）',
                      prefixIcon: Icon(Icons.info),
                    ),
                  ),
                  widgetSpacing,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                        child: Text('注册', style: TextStyle(fontSize: 16)),
                      ),
                      onPressed: createAccount,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  selectAvatar() async {
    tapFeedback(context);
    late final FilePickerResult? results;
    try {
      results = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);
    } on PlatformException catch (e) {
      logger.d('Failed to pick file: $e');
      return;
    }
    if (results == null || results.files.isEmpty) return;
    setState(() {
      _avatarFile = results!.files.first;
    });
  }

  createAccount() async {
    if (_formKey.currentState!.validate()) {
      late final Account account;
      try {
        account = await Account.create(_nameController.text, _emailController.text, _bioController.text, _avatarFile);
      } on NoAvailableAddrException {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('此设备没有可用的网络连接')));
        return;
      }
      await account.startup();
      providers.read(accountsPro).add(account);
      providers.read(currAccountPro.notifier).set(account);
      account.announce();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
    }
  }
}
