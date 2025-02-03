import 'package:job_search/data/models/job.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class Jobs {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;

    var path = p.join(await getDatabasesPath(), 'job_search.db');

    _db = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE jobs (id TEXT PRIMARY KEY), title TEXT, company TEXT, posting TEXT, dateApplied INTEGER, status TEXT');
    });

    return _db!;
  }

  static Future<void> close() async {
    final db = await Jobs.db;
    return db.close();
  }

  static Future<List<Job>> get all async {
    final db = await Jobs.db;
    final query = await db.query('jobs');

    return query.map((row) => Job.fromJson(row)).toList();
  }

  static Future<void> add(Job job) async {
    final db = await Jobs.db;

    await db.insert(
      'jobs',
      job.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(Job job) async {
    final db = await Jobs.db;

    final count = await db.update(
      'jobs',
      job.toJson(),
      where: 'id = ?',
      whereArgs: [job.id],
    );

    if (count == 0) {
      await add(job);
    }
  }

  static Future<void> delete(Job job) async {
    final db = await Jobs.db;
    await db.delete('jobs', where: 'id = ?', whereArgs: [job.id]);
  }
}
