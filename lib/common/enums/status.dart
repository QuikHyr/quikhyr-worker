enum Status {
  pending,
  completed,
  notCompleted;

  String toJson() {
    switch(this) {
      case Status.pending:
        return 'Pending';
      case Status.completed:
        return 'Completed';
      case Status.notCompleted:
        return 'Not Completed';
      default:
        return "Wrong Status";
    }
  }

    factory Status.fromJson(String json) {
    switch (json) {
      case "Pending":
        return Status.pending;
      case "Completed":
        return Status.completed;
      case "Not Completed":
        return Status.notCompleted;
      default:
        return Status.pending;
    }
  }
}