import 'dart:ffi';
import 'dart:math';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie/components/error.dart';
import 'package:pie/lib/config.dart';
import 'package:pie/lib/global.dart';
import 'package:pie/lib/id.dart';
import 'package:pie/lib/notifier.dart';

class ShareIDPage extends ConsumerStatefulWidget {
  const ShareIDPage({Key? key}) : super(key: key);

  @override
  _ContactAddingTokenPageState createState() => _ContactAddingTokenPageState();
}

class _ContactAddingTokenPageState extends ConsumerState<ShareIDPage> {
  final _tokenPro = ChangeNotifierProvider<ListNotifier<String>>((ref) => ListNotifier([]));

  late final FutureProvider _loadingPro;

  @override
  void initState() {
    super.initState();
    _loadingPro = FutureProvider((ref) async {
      final tokens = await providers.read(currAccountPro)!.db.query('contact_adding_token');
      for (final token in tokens) {
        providers.read(_tokenPro).add(token['token'] as String);
      }
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(_loadingPro);
    return Scaffold(
      appBar: AppBar(
        title: const Text('分享我的帐号ID'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: generateToken,
        tooltip: '生成身份码',
        child: const Icon(Icons.add),
      ),
      body: loading.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (data) {
          final tokens = ref.watch(_tokenPro);
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text('我的身份码', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor)),
                    ),
                    Text(
                      '当其他用户想要添加你为联系人时，必须使用以下身份码，以避免垃圾消息',
                      style: TextStyle(color: Theme.of(context).hintColor),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: tokens.length,
                itemBuilder: (context, index) {
                  final token = tokens[index];
                  return ListTile(
                    title: Text(token, style: const TextStyle(fontFamily: 'monospace')),
                    trailing: IconButton(
                      icon: Icon(Icons.copy, color: Theme.of(context).primaryColor),
                      onPressed: () => copyToken(token),
                    ),
                  );
                },
              ),
            ],
          );
        },
        error: (e, s) => CenterError(e),
      ),
    );
  }

  generateToken() async {
    final account = providers.read(currAccountPro)!;
    final randomer = Random.secure();
    final token = List.generate(contactsAddingTokenLen, (_) => randomer.nextInt(0xff)).toHexStr();
    await account.db.insert('contact_adding_token', {'token': token});
    providers.read(_tokenPro).add(token);
  }

  copyToken(String token) {
    final account = providers.read(currAccountPro)!;
    final id = account.id.toIntList().toHexStr();
    final certHashDataPtr = malloc<Uint8>(userCertHashLen);
    hashBytes(account.certDER, certHashDataPtr, userCertHashLen);
    final certHash = certHashDataPtr.asTypedList(userCertHashLen).toHexStr();
    malloc.free(certHashDataPtr);
    Clipboard.setData(ClipboardData(text: '$id:$certHash:$token'));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('已复制')));
  }
}
