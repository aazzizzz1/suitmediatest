import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<User> _users = [];
  int _page = 1;
  int _perPage = 10;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
    });

    String apiUrl =
        'https://reqres.in/api/users?per_page=$_perPage&page=$_page';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final userList = responseData['data'] as List<dynamic>;
        final List<User> loadedUsers = userList
            .map((userData) => User(
                email: userData['email'],
                firstName: userData['first_name'],
                lastName: userData['last_name'],
                avatar: userData['avatar']))
            .toList();

        setState(() {
          _users.addAll(loadedUsers);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load users');
      }
    } catch (error) {
      throw Exception('Failed to connect to the API');
    }
  }

  Future<void> _refreshUsers() async {
    _page = 1;
    _users.clear();
    await _loadUsers();
  }

  Future<void> _loadMoreUsers() async {
    _page++;
    await _loadUsers();
  }

  void _onUserSelected(String userName) {
    Navigator.pop(context, userName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshUsers,
        child: ListView.builder(
          itemCount: _users.length + 1,
          itemBuilder: (context, index) {
            if (index < _users.length) {
              final user = _users[index];
              return ListTile(
                title: Text('${user.firstName} ${user.lastName}'),
                subtitle: Text(user.email),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.avatar),
                ),
                onTap: () => _onUserSelected(user.firstName),
              );
            } else if (_isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class User {
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });
}
