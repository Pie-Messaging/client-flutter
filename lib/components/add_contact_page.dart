import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie/components/chat_page.dart';
import 'package:pie/entities/chat.dart';
import 'package:pie/entities/message.dart';
import 'package:pie/entities/user.dart';
import 'package:pie/lib/config.dart';
import 'package:pie/lib/global.dart';
import 'package:pie/lib/id.dart';
import 'package:pie/lib/log.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class AddContactPage extends ConsumerStatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  createState() => _AddContactPageState();
}

class _AddContactPageState extends ConsumerState<AddContactPage> {
  final _tokenController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final int ctx;
  bool _loading = false;
  _FindUserResult? _userResult;

  @override
  void initState() {
    super.initState();
    ctx = core.NewContext();
  }

  @override
  void dispose() {
    _tokenController.dispose();
    _nameController.dispose();
    core.CancelContext(ctx);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加联系人'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: logoSideLen / 2,
                    backgroundImage: _userResult?.user == null || !ref.watch(_userResult!.user!.pro.select((user) => user.hasAvatar))
                        ? Image.asset('assets/icon/icon.png', width: logoSideLen).image
                        : Image.memory(ref.watch(_userResult!.user!.pro.select((user) => user.avatarBytes!)).toUint8List()).image,
                  ),
                  widgetSpacing,
                  Text(_userResult?.user?.name ?? 'Pie', style: Theme.of(context).textTheme.headline6),
                  if (_userResult?.user != null && _userResult!.user!.email.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(_userResult!.user!.email, style: Theme.of(context).textTheme.subtitle1),
                    ),
                  if (_userResult?.user != null && _userResult!.user!.bio.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(_userResult!.user!.bio, style: Theme.of(context).textTheme.subtitle1),
                    ),
                  widgetSpacing,
                  TextFormField(
                    controller: _tokenController,
                    autofocus: true,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: '对方的身份码',
                      suffixIcon: IconButton(
                        onPressed: _tokenController.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                    validator: (_) {
                      switch (_userResult?.state) {
                        case _FindUserState.wrongFormat:
                          return '身份码格式错误';
                        case _FindUserState.isSelf:
                          return '不能添加自己为联系人';
                        case _FindUserState.alreadyExists:
                          return '该联系人已存在';
                        case _FindUserState.notFound:
                          return '找不到此用户，请稍后再试';
                        default:
                          return null;
                      }
                    },
                    onChanged: (value) => findUser(value),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: '联系人名称（备注，可选）',
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: _loading
                          ? SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Theme.of(context).hintColor, strokeWidth: 3))
                          : const Icon(Icons.person_add),
                      label: const Text('添加', style: TextStyle(fontSize: blockButtonTextSize)),
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(blockButtonPadding)),
                      onPressed:
                          _userResult?.user == null || _loading ? null : () => addContact(context, ctx, _tokenController.text, _nameController.text),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future findUser(String text) async {
    setState(() {
      _loading = true;
    });
    returnHook(_FindUserResult result) {
      setState(() {
        _userResult = result;
        _loading = false;
      });
      logger.d('findUser: ${result.state} ${result.user != null}');
      _formKey.currentState!.validate();
    }

    const pattern = '^(?<id>\\w{${idLen * 2}}):(?<hash>\\w{${userCertHashLen * 2}}):(?<token>\\w{${contactsAddingTokenLen * 2}})\$';
    final match = RegExp(pattern).allMatches(text);
    if (match.isEmpty) return returnHook(_FindUserResult(_FindUserState.wrongFormat));
    final idStr = match.first.namedGroup('id')!;
    final certHash = match.first.namedGroup('hash')!;
    final token = match.first.namedGroup('token')!;
    final id = idStr.toID();
    final account = providers.read(currAccountPro)!;
    if (id == account.id) return returnHook(_FindUserResult(_FindUserState.isSelf));
    final result = await account.db.rawQuery(
      'SELECT EXISTS(SELECT * FROM user WHERE hex(u_id) = ? AND u_state > ?)',
      [hex(id.l), UserState.noRelation.index],
    );
    if (Sqflite.firstIntValue(result) == 1) return returnHook(_FindUserResult(_FindUserState.alreadyExists));
    final user = await routingTable.findUserForAddingContact(ctx, id, certHash);
    if (user == null) return returnHook(_FindUserResult(_FindUserState.notFound));
    logger.d('add contact: user addr: ${user.addr.keys}');
    return returnHook(_FindUserResult(_FindUserState.found, user: user, id: id, certHash: certHash, token: token));
  }

  addContact(BuildContext context, int ctx, String tokenStr, String contactName) async {
    setState(() {
      _loading = true;
    });
    returnHook() {
      setState(() {
        _loading = false;
      });
    }

    switch (_userResult!.state) {
      case _FindUserState.wrongFormat:
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('身份码格式错误')));
        return returnHook();
      case _FindUserState.isSelf:
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('不能添加自己为联系人')));
        return returnHook();
      case _FindUserState.alreadyExists:
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('该联系人已存在')));
        return returnHook();
      case _FindUserState.notFound:
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('找不到此用户，请稍后再试')));
        return returnHook();
      case _FindUserState.found:
    }
    final account = providers.read(currAccountPro)!;
    _userResult!.user!.contactName = contactName;
    try {
      await _userResult!.user!.addContact(ctx, _userResult!.token!);
    } catch (e, s) {
      logger.e('Failed to add contact', e, s);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('网络错误，请稍后再试')));
      return returnHook();
    }
    final chat = Chat(account, user: _userResult!.user!);
    final message = Message(account, chat, ID.generate(), DateTime.now(), '已向对方发送联系人添加请求', isSysMsg: true);
    chat.addMessage(message);
    try {
      await account.db.transaction((txn) async {
        await _userResult!.user!.save(txn);
        await chat.save(txn);
        await message.save(txn);
      });
    } catch (e) {
      logger.e('Failed to add contact', e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('保存联系人失败: $e')));
      return returnHook();
    }
    account.chats.add(chat);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('已发送联系人添加请求')));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatPage(chat)));
    return returnHook();
  }
}

class _FindUserResult {
  final _FindUserState state;
  final User? user;
  final ID? id;
  final String? certHash;
  final String? token;

  _FindUserResult(this.state, {this.user, this.id, this.certHash, this.token});
}

enum _FindUserState {
  wrongFormat,
  isSelf,
  alreadyExists,
  notFound,
  found,
}
