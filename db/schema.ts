export const schema = {
  users: ["id", "email", "name", "role", "created_at"],
  products: ["id", "name", "category", "price", "stock", "note", "position", "active", "created_at"],
  orders: ["id", "user_id", "email", "status", "total", "shipping_json", "created_at", "updated_at"],
  orderItems: ["id", "order_id", "product_id", "product_name", "unit_price", "quantity"],
} as const;