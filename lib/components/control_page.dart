import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie/components/login_page.dart';
import 'package:pie/components/share_id_page.dart';
import 'package:pie/entities/account.dart';
import 'package:pie/lib/config.dart';
import 'package:pie/lib/global.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('control_page'),
      children: const [
        _Profile(),
        _ControlList(),
      ],
    );
  }
}

class _Profile extends ConsumerWidget {
  const _Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(currAccountPro)!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        children: [
          CircleAvatar(
            radius: logoSideLen / 2,
            backgroundImage: ref.watch(account.pro.select((user) => user.hasAvatar))
                ? Image.memory(account.avatarBytes!).image
                : Image.asset('assets/icon/icon.png', width: logoSideLen).image,
          ),
          widgetSpacing,
          Text(
            ref.watch(account.pro.select((user) => user.name)),
            style: Theme.of(context).textTheme.headline6,
          ),
          if (ref.watch(account.pro.select((user) => user.email)).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(ref.watch(account.pro.select((user) => user.email)), style: Theme.of(context).textTheme.subtitle1),
            ),
          if (ref.watch(account.pro.select((user) => user.bio)).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(ref.watch(account.pro.select((user) => user.bio)), style: Theme.of(context).textTheme.subtitle1),
            )
        ],
      ),
    );
  }
}

class _ControlList extends StatelessWidget {
  const _ControlList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = <_ControlGroup>[
      _ControlGroup('帐号', [
        _ControlItem(widget: _SwitchAccount()),
        _ControlItem(
          title: '分享帐号ID',
          icon: Icons.share,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ShareIDPage()));
          },
        ),
      ]),
      _ControlGroup('设置', [
        _ControlItem(title: '通知和提示音', icon: Icons.notifications_active, onTap: () {}),
        _ControlItem(title: '隐私和安全', icon: Icons.security, onTap: () {}),
        _ControlItem(title: '数据和存储', icon: Icons.storage, onTap: () {}),
        _ControlItem(title: '聊天设置', icon: Icons.chat, onTap: () {}),
      ]),
    ];
    return ListView.separated(
      key: const PageStorageKey('control_list'),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _ControlGroupTile(items[index]);
      },
      separatorBuilder: (context, index) {
        return const Divider(height: 3);
      },
    );
  }
}

class _ControlGroupTile extends StatelessWidget {
  final _ControlGroup group;

  const _ControlGroupTile(this.group, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Text(group.title, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor)),
        ),
        ListView.builder(
          key: PageStorageKey('control_list_${group.title}'),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: group.items.length,
          itemBuilder: (context, index) {
            return _ControlItemTile(group.items[index]);
          },
        ),
      ],
    );
  }
}

class _ControlItemTile extends StatelessWidget {
  final _ControlItem item;

  const _ControlItemTile(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return item.widget ??
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          title: Text(item.title!, style: const TextStyle(fontSize: 15)),
          leading: Icon(item.icon, color: Theme.of(context).hintColor),
          onTap: item.onTap,
        );
  }
}

class _ControlGroup {
  final String title;
  final List<_ControlItem> items;

  _ControlGroup(this.title, this.items);
}

class _ControlItem {
  final Widget? widget;
  final String? title;
  final IconData? icon;
  final Function()? onTap;

  _ControlItem({this.widget, this.title, this.icon, this.onTap});
}

class _SwitchAccount extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DropdownMenuItem<Account> toMenuItem(Account account) => DropdownMenuItem(
          value: account,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundImage: ref.watch(account.pro.select((account) => account.hasAvatar))
                      ? Image.memory(account.avatarBytes!).image
                      : Image.asset('assets/icon/icon.png', width: 28).image,
                ),
                const SizedBox(width: 30),
                Text(ref.watch(account.pro.select((up) => up.name))),
              ],
            ),
          ),
        );
    return DropdownButton<Account>(
      isExpanded: true,
      icon: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.arrow_drop_down),
      ),
      value: ref.watch(currAccountPro),
      items: ref.watch(accountsPro).l.map(toMenuItem).toList()
        ..add(
          DropdownMenuItem(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: const [
                  Icon(Icons.person_add),
                  SizedBox(width: 30),
                  Text('添加帐号'),
                ],
              ),
            ),
          ),
        ),
      onChanged: (Account? account) {
        if (account != null) {
          providers.read(currAccountPro.notifier).set(account);
          Config.update(Config.currAccount, account.id.l);
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
        }
      },
    );
  }
}

class ControlPageMore extends StatelessWidget {
  const ControlPageMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_Menu>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<_Menu>>[
        const PopupMenuItem<_Menu>(
          value: _Menu.logOut,
          child: ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('登出'),
          ),
        ),
      ],
      onSelected: (_Menu item) {
        switch (item) {
          case _Menu.logOut:
            providers.read(currAccountPro)!.logOut();
            break;
        }
      },
    );
  }
}

enum _Menu { logOut }
