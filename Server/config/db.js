import pkg from "pg";
import dotenv from "dotenv";

dotenv.config();

const { Pool } = pkg;

const pool = new Pool({
  connectionString: process.env.DB_URL,
  ssl: {
    require: true,
    rejectUnauthorized: false,
  },
  connectionTimeoutMillis: 10000, // 🔥 ADD THIS
});

const connectDB = async () => {
  try {
    await pool.query("SELECT 1");
    console.log("✅ PostgreSQL connected successfully");
  } catch (error) {
    console.error("❌ PostgreSQL connection failed:", error.message);
    process.exit(1);
  }
};

export { connectDB };
export default pool;
