import 'package:path/path.dart';
import 'package:pie/lib/global.dart';
import 'package:sqflite/sqflite.dart';

const mainDatabaseVersion = 1;
const accountDatabaseVersion = 1;

Future loadMainDatabase() async {
  mainDB = await openDatabase(
    join(dataDir.path, 'main.db'),
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE config (
          key TEXT PRIMARY KEY,
          text TEXT,
          blob BLOB,
          int INTEGER
        )
      ''');
      await db.execute('''
        CREATE TABLE account (
          id BLOB PRIMARY KEY,
          name TEXT NOT NULL,
          email TEXT NOT NULL,
          bio TEXT NOT NULL,
          has_avatar INTEGER NOT NULL,
          cert_pem TEXT NOT NULL,
          key_pem TEXT NOT NULL,
          port INTEGER NOT NULL,
          contact_adding_only_token INTEGER DEFAULT 1
        )
      ''');
      await db.execute('''
        CREATE TABLE tracker (
          id BLOB PRIMARY KEY,
          addr TEXT NOT NULL
        )
      ''');
    },
    version: mainDatabaseVersion,
  );
}

Future<Database> loadAccountDatabase(path) async {
  return await openDatabase(
    join(path, 'main.db'),
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE config (
          key TEXT PRIMARY KEY,
          value TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE user (
          u_id BLOB PRIMARY KEY,
          u_state INTEGER NOT NULL,
          u_name TEXT NOT NULL,
          u_email TEXT NOT NULL,
          u_bio TEXT NOT NULL,
          u_has_avatar INTEGER NOT NULL,
          u_contact_name TEXT NOT NULL,
          u_addr TEXT NOT NULL,
          u_cert_der BLOB NOT NULL
        )
      ''');
      await db.execute('''
        CREATE TABLE chat (
          c_id BLOB PRIMARY KEY,
          c_type INTEGER NOT NULL,
          c_time INTEGER NOT NULL,
          c_first_unread_msg_id BLOB,
          c_num_unread INTEGER NOT NULL
        )
      ''');
      await db.execute('''
        CREATE TABLE [group] (
          g_id BLOB PRIMARY KEY,
          g_name TEXT NOT NULL
        )
      ''');
      await db.execute('''
        CREATE TABLE group_user (
          gu_group_id BLOB NOT NULL,
          gu_user_id BLOB NOT NULL,
          gu_permission INTEGER NOT NULL,
          PRIMARY KEY (gu_group_id, gu_user_id),
          FOREIGN KEY (gu_group_id) REFERENCES [group] (g_id) ON DELETE CASCADE,
          FOREIGN KEY (gu_user_id) REFERENCES user (u_id) ON DELETE CASCADE
        )
      ''');
      await db.execute('''
        CREATE TABLE message (
          m_id BLOB PRIMARY KEY,
          m_chat_id BLOB NOT NULL,
          m_is_sys_msg INTEGER NOT NULL,
          m_time INTEGER NOT NULL,
          m_content TEXT NOT NULL,
          m_content_meta TEXT,
          m_sender_id BLOB,
          m_sticker_id BLOB,
          m_forwarded_from_chat_id BLOB,
          m_forwarded_from_msg_id BLOB,
          m_reply_to_id BLOB,
          m_is_read INTEGER,
          FOREIGN KEY (m_chat_id) REFERENCES chat (c_id) ON DELETE CASCADE
        )
      ''');
      await db.execute('''CREATE INDEX m_chat_id_idx on message (m_chat_id)''');
      await db.execute('''CREATE INDEX m_time_idx on message (m_time)''');
      await db.execute('''
        CREATE TABLE file (
          f_ai_id INTEGER PRIMARY KEY AUTOINCREMENT,
          f_id BLOB,
          f_name TEXT DEFAULT '',
          UNIQUE (f_id)
        )
      ''');
      await db.execute('''
        CREATE TABLE message_file (
          mf_message_id BLOB NOT NULL,
          mf_index INTEGER NOT NULL,
          mf_file_id BLOB NOT NULL,
          PRIMARY KEY (mf_message_id, mf_file_id),
          FOREIGN KEY (mf_message_id) REFERENCES message (m_id) ON DELETE CASCADE,
          FOREIGN KEY (mf_file_id) REFERENCES file (f_id) ON DELETE CASCADE
        )
      ''');
      await db.execute('''
        CREATE TABLE contact_adding_token (
          token TEXT PRIMARY KEY
        )
      ''');
    },
    version: accountDatabaseVersion,
  );
}
