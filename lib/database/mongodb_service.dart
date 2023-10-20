import 'package:mongo_dart/mongo_dart.dart';

class MongoDBService {
  late var _db;

  Future<void> connect() async {
    final String dbUrl = 'mongodb+srv://dmj160803:Dax123@cluster0.rr5lle0.mongodb.net/?retryWrites=true&w=majority'; // Replace with your MongoDB connection URL

    _db = await Db.create(dbUrl);

    await _db.open();
    print('Connected to MongoDB');
  }

  Future<void> close() async {
    await _db.close();
    print('Connection to MongoDB closed');
  }

  Future<void> registerUser(Map<String, dynamic> user) async {
    final usersCollection = _db.collection('users');
    await usersCollection.insert(user);
  }

  Future<Map<String, dynamic>?> findUserByEmail(String email) async {
    final usersCollection = _db.collection('users');
    final user = await usersCollection.findOne(where.eq('email', email));
    return user;
  }
}