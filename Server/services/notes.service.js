import pool from "../config/db.js";

export const createNotesService = async (data) => {
  const client = await pool.connect();

  try {

    const { title, subtitle, content, images, topicId, status } = data;

    const result = await client.query(
      `INSERT INTO notes 
      (title, subtitle, content, images, topicId, status)
      VALUES ($1,$2,$3,$4,$5,$6)
      RETURNING *`,
      [
        title,
        subtitle,
        content,
        images,
        topicId,
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
