import pool from "../config/db.js";

const client = await pool.connect();
export const createTopicService = async (data) => {

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

export const getTopic = async () =>{
  try {
    const result = await client.query("select * from topics");

    return result.rows;
  } catch (error) {
     throw error;
  }
}


// get topic by id

export const getTopicBYId = async(topicId) =>{
  try {
    const result = await pool.query(
      `select * from topics where id = $1 and status = 'active' `, [topicId]
    );
    
    return result.rows[0]
  } catch (error) {
    throw error;
  }
}


export const deleteTopic = async(topicId) =>{
  try {
    const result = await pool.query(
      `delete from topics where id = $1 `, [topicId]
    );

    return result.row ;
  } catch (error) {
    throw error;
  }
}