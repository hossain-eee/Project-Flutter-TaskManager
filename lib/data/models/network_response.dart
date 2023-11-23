//we want to store our network data to our model class to use every where, we don't want to expose our network_caller where http operaton occur
class NetworkResponse {
  final int statusCode;//comes from server
  final bool isSuccess; // we will put it to identify weather it sucessful or not
  final Map<String, dynamic>? body; // comes from server
  NetworkResponse(this.isSuccess, this.statusCode, this.body); // if any error occur then body could be null, so make it nullable
}
