CREATE TABLE IF NOT EXISTS users (
  id TEXT PRIMARY KEY NOT NULL,
  email TEXT NOT NULL,
  name TEXT NOT NULL,
  role TEXT NOT NULL DEFAULT 'user' CHECK (role IN ('admin','user')),
  created_at TEXT NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX IF NOT EXISTS idx_users_email ON users(email);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS products (
  id TEXT PRIMARY KEY NOT NULL,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  price INTEGER NOT NULL CHECK (price > 0),
  stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
  note TEXT NOT NULL,
  position TEXT NOT NULL DEFAULT '50% 50%',
  active INTEGER NOT NULL DEFAULT 1 CHECK (active IN (0,1)),
  created_at TEXT NOT NULL
);
--> statement-breakpoint
CREATE INDEX IF NOT EXISTS idx_products_active_category ON products(active, category);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS orders (
  id TEXT PRIMARY KEY NOT NULL,
  user_id TEXT NOT NULL REFERENCES users(id),
  email TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'processing' CHECK (status IN ('processing','packed','shipped','delivered')),
  total INTEGER NOT NULL CHECK (total >= 0),
  shipping_json TEXT NOT NULL,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
--> statement-breakpoint
CREATE INDEX IF NOT EXISTS idx_orders_user_created ON orders(user_id, created_at);
--> statement-breakpoint
CREATE INDEX IF NOT EXISTS idx_orders_status_created ON orders(status, created_at);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS order_items (
  id TEXT PRIMARY KEY NOT NULL,
  order_id TEXT NOT NULL REFERENCES orders(id),
  product_id TEXT NOT NULL REFERENCES products(id),
  product_name TEXT NOT NULL,
  unit_price INTEGER NOT NULL,
  quantity INTEGER NOT NULL CHECK (quantity > 0)
);
--> statement-breakpoint
CREATE INDEX IF NOT EXISTS idx_order_items_order ON order_items(order_id);
--> statement-breakpoint
PRAGMA optimize;