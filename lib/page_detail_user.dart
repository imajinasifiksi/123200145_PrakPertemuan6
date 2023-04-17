import 'package:flutter/material.dart';
import 'api_data_source.dart';
import 'detailusers_model.dart';

class PageDetailUser extends StatelessWidget {
  final int idUser;
  const PageDetailUser({Key? key, required this.idUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User $idUser'),
      ),
      body: Container(
        child: FutureBuilder(
          future: ApiDataSource.instance.loadDetailUser(idUser),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              // Jika data ada error maka akan ditampilkan hasil error
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
             // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
              DetailUsersModel usersModel = DetailUsersModel.fromJson(snapshot.data);
              return _buildSuccessSection(context, usersModel);
            }
            return _buildLoadingSection();
          },
        ),
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(BuildContext context, DetailUsersModel users) {
    final userData = users.data!;
    return Container(
      child: _buildItemUsers(context, userData),
    );
  }

  Widget _buildItemUsers(BuildContext context, Data userData) {
    return Container(
      child: Center(
        child: Column(children: [
          Container(
            width: 100,
            child: Image.network(userData.avatar!),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(userData.firstName! + " " + userData.lastName!),
              Text(userData.email!)
            ],
          )
        ]),
      ),
    );
  }
}