class ApiResponse<T> {
  Status status;
  T? data;
  String? message;

  ApiResponse.initial(this.message) : status = Status.INITIAL;

  ApiResponse.loading(this.message) : status = Status.LOADING;

  ApiResponse.completed(this.message) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    // TODO: implement toString
    // return "Status : $status \n Message : $message \n Data : $data";
    return "Status : $status \n Message : $message";
  }
}

enum Status { INITIAL, LOADING, COMPLETED, ERROR }
