class OTPVerify {
  late Success success;

  OTPVerify({required this.success});

  OTPVerify.fromJson(Map<String, dynamic> json) {
    success =
    (json['success'] != null ? new Success.fromJson(json['success']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success.toJson();
    }
    return data;
  }
}

class Success {
  late String message;
  late Data data;

  Success({required this.message, required this.data});

  Success.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  late String token;

  Data({required this.token});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}