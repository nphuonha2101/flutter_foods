class OrderStatus {
  static const int PREPARING = 0;
  static const int DELIVERING = 1;
  static const int DELIVERED = 2;
  static const int CANCELLED = 3;

  static String getStatus(int status) {
    switch (status) {
      case PREPARING:
        return 'Đang chuẩn bị';
      case DELIVERING:
        return 'Đang vận chuyển';
      case DELIVERED:
        return 'Đã giao';
      case CANCELLED:
        return 'Đã hủy';
      default:
        return 'Không xác định';
    }
  }
}
