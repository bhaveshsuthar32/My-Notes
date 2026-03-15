import pool from "../config/db.js";

export const createTopicService = async (data) => {
  const client = await pool.connect();

  try {
    const { name, description, coverImage, status } = data;

    const result = await client.query(
      `INSERT INTO topics 
      (name, description, coverImage, status)
      VALUES ($1,$2,$3,$4)
      RETURNING *`,
      [
        name,
        description,
        coverImage,
        status || "active"
      ]
    );

    return result.rows[0];

  } catch (error) {
    throw error;

  } finally {
    client.release();
  }
};