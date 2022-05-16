import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie/components/add_contact_page.dart';
import 'package:pie/components/chat_list.dart';
import 'package:pie/components/contact_list.dart';
import 'package:pie/components/control_page.dart';
import 'package:pie/lib/global.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _items = [
    _HomePageItem(
      '通讯录',
      const BottomNavigationBarItem(icon: Icon(Icons.contacts), label: '通讯录'),
      [IconButton(icon: const Icon(Icons.search), onPressed: () {}), IconButton(icon: const Icon(Icons.person_add), onPressed: () {})],
      const ContactList(),
    ),
    _HomePageItem(
      '消息',
      const BottomNavigationBarItem(icon: Icon(Icons.message), label: '消息'),
      [IconButton(icon: const Icon(Icons.search), onPressed: () {}), IconButton(icon: const Icon(Icons.edit), onPressed: () {})],
      const ChatList(),
      isDefault: true,
    ),
    _HomePageItem(
      '控制',
      const BottomNavigationBarItem(icon: Icon(Icons.settings), label: '控制'),
      [IconButton(icon: const Icon(Icons.edit), onPressed: () {})],
      const ControlPage(),
    ),
  ];
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = _items.indexWhere((item) => item.isDefault);
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = _items[_selectedIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        actions: item.appBarActions,
      ),
      body: Column(
        children: [
          if (!ref.watch(isNetWorkingPro)) const Banner(),
          Expanded(child: item.body),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddContactPage())),
        tooltip: '添加联系人',
        child: const Icon(Icons.person_add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _items.map((item) => item.navBarItem).toList(),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class _HomePageItem {
  final String title;
  final BottomNavigationBarItem navBarItem;
  final List<Widget> appBarActions;
  final Widget body;
  final bool isDefault;

  const _HomePageItem(this.title, this.navBarItem, this.appBarActions, this.body, {this.isDefault = false});
}

class Banner extends ConsumerWidget {
  const Banner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialBanner(
      content: const Text('无法连接至服务器'),
      actions: [
        TextButton(
          onPressed: importTrackers,
          child: const Text('从剪贴板导入服务器信息'),
        ),
      ],
      leading: const Icon(Icons.error, color: Colors.red),
    );
  }

  importTrackers() async {
    routingTable.trackerMap.clear();
    routingTable.trackerList.clear();
    routingTable.trackerTree.children.setAll(0, [null, null]);
    routingTable.importTrackers((await Clipboard.getData(Clipboard.kTextPlain))!.text!);
  }
}
