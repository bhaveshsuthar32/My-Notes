// import pool from "../config/db.js";

// const client = await pool.connect();

// export const createTopicService = async (data) => {
//   try {
//     const { name, description, coverImage, status } = data;

//     const result = await client.query(
//       `INSERT INTO topics 
//        (name, description, "coverImage", status)
//        VALUES ($1, $2, $3, $4)
//        RETURNING *`,
//       [
//         name,
//         description,
//         coverImage,
//         status || "active",
//       ]
//     );

//     return result.rows[0];
//   } catch (error) {
//     throw error;
//   }
// };



// export const getTopic = async () => {
//   try {
//     const result = await client.query("select * from topics");

//     return result.rows;
//   } catch (error) {
//     throw error;
//   }
// }


// // get topic by id

// export const getTopicBYId = async (topicId) => {
//   try {
//     const result = await pool.query(
//       `select * from topics where id = $1 and status = 'active' `, [topicId]
//     );

//     return result.rows[0]
//   } catch (error) {
//     throw error;
//   }
// }


// export const deleteTopic = async (topicId) => {
//   try {
//     const result = await pool.query(
//       `delete from topics where id = $1 `, [topicId]
//     );

//     return result.row;
//   } catch (error) {
//     throw error;
//   }
// }



import pool from "../config/db.js";


// ======================================================
// CREATE TOPIC
// ======================================================

export const createTopicService = async (data) => {
  try {

    const {
      name,
      description,
      coverImage,
      status,
      userId,
    } = data;

    const result = await pool.query(
      `
      INSERT INTO topics
      (
        name,
        description,
        "coverImage",
        status,
        user_id
      )
      VALUES
      (
        $1,
        $2,
        $3,
        $4,
        $5
      )
      RETURNING *
      `,
      [
        name,
        description,
        coverImage,
        status || "active",
        userId,
      ]
    );

    return result.rows[0];

  } catch (error) {

    console.error(
      "CREATE TOPIC SERVICE ERROR:",
      error
    );

    throw error;
  }
};


// ======================================================
// GET TOPICS OF LOGGED-IN USER
// ======================================================

export const getTopic = async (userId) => {
  try {

    const result = await pool.query(
      `
      SELECT *
      FROM topics
      WHERE user_id = $1
      ORDER BY id DESC
      `,
      [userId]
    );

    return result.rows;

  } catch (error) {

    console.error(
      "GET TOPIC SERVICE ERROR:",
      error
    );

    throw error;
  }
};


// ======================================================
// GET TOPIC BY ID
// ======================================================

export const getTopicBYId = async (
  topicId,
  userId
) => {
  try {

    const result = await pool.query(
      `
      SELECT *
      FROM topics
      WHERE id = $1
      AND user_id = $2
      AND status = 'active'
      `,
      [
        topicId,
        userId,
      ]
    );

    return result.rows[0] || null;

  } catch (error) {

    console.error(
      "GET TOPIC BY ID SERVICE ERROR:",
      error
    );

    throw error;
  }
};


// ======================================================
// DELETE TOPIC
// ======================================================

export const deleteTopic = async (
  topicId,
  userId
) => {
  try {

    const result = await pool.query(
      `
      DELETE FROM topics
      WHERE id = $1
      AND user_id = $2
      RETURNING *
      `,
      [
        topicId,
        userId,
      ]
    );

    return result.rows[0] || null;

  } catch (error) {

    console.error(
      "DELETE TOPIC SERVICE ERROR:",
      error
    );

    throw error;
  }
};