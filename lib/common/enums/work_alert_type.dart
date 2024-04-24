enum WorkAlertType {
  workAlert,
  workApprovalRequest,
  general;

  String toJson() {
    switch (this) {
      case WorkAlertType.workAlert:
        return 'work-alert';
      case WorkAlertType.workApprovalRequest:
        return 'work-approval-request';
      case WorkAlertType.general:
        return 'general';
      default:
        return "general";
    }
  }

  factory WorkAlertType.fromJson(String json) {
    switch (json) {
      case "work-alert":
        return WorkAlertType.workAlert;
      case "work-approval-request":
        return WorkAlertType.workApprovalRequest;
      case "general":
        return WorkAlertType.general;
      default:
        return WorkAlertType.general;
    }
  }

  String get notificationListTileDisplayString {
    switch (this) {
      case WorkAlertType.workAlert:
        return 'Work Alert';
      case WorkAlertType.workApprovalRequest:
        return 'Work Approval Request';
      case WorkAlertType.general:
        return 'General';
      default:
        return 'General';
    }
  }

  //   String get notificationDetailDisplayString {
  //   switch (this) {
  //     case WorkAlertType.workAlert:
  //       return 'Work Alert';
  //     case WorkAlertType.workApprovalRequest:
  //       return 'Work Approval Request';
  //     case WorkAlertType.general:
  //       return 'General';
  //     default:
  //       return 'General';
  //   }
  // }
}
