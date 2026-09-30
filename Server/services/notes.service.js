import pool from "../config/db.js";

const client = await pool.connect();

// export const createNotesService = async (data) => {

//   try {

//     const { title, subtitle, content, images, topicId, status } = data;

//     const result = await client.query(
//       `INSERT INTO notes 
//       (title, subtitle, content, images, topicId, status)
//       VALUES ($1,$2,$3,$4,$5,$6)
//       RETURNING *`,
//       [
//         title,
//         subtitle,
//         content,
//         images,
//         topicId,
//         status || "active"
//       ]
//     );

//     return result.rows[0];

//   } catch (error) {
//     throw error;

//   } finally {
//     client.release();
//   }
// };



export const createNotesService = async (data) => {
  try {
    const {
      title,
      subtitle,
      content,
      images,
      contentOrder,
      topicid,
      status,
    } = data;

    const result = await client.query(
      `INSERT INTO notes
      (
        title,
        subtitle,
        content,
        images,
        "contentOrder",
        "topicid",
        status
      )
      VALUES ($1::text, $2::jsonb, $3::jsonb, $4::jsonb, $5::jsonb, $6, $7)
      RETURNING *`,
      [
        title,
        JSON.stringify(subtitle || []),
        JSON.stringify(content || []),
        JSON.stringify(images || []),
        JSON.stringify(contentOrder || []),
        topicid,
        status || "active",
      ]
    );

    return result.rows[0];

  } catch (error) {
    throw error;
  }
};

// export const createNotesService = async (data) => {
//   try {
//     const {
//       title,
//       subtitle,
//       content,
//       images,
//       topicid,
//       status,
//     } = data;

//     const result = await client.query(
//       `INSERT INTO notes
//       (title, subtitle, content, images, "topicid", status)
//       VALUES ($1, $2, $3, $4, $5, $6)
//       RETURNING *`,
//       [
//         title,
//         subtitle,
//         content,
//         images,
//         topicid,
//         status || "active",
//       ]
//     );

//     return result.rows[0];
//   } catch (error) {
//     throw error;
//   }
// };


export const updateNotesLayout = async (notesId, layout) => {
  try {
    const result = await client.query(
      `
      UPDATE notes
      SET layout = $1::jsonb
      WHERE id = $2
      RETURNING *
      `,
      [
        JSON.stringify(layout),
        notesId,
      ]
    );

    return result.rows[0] || null;

  } catch (error) {
    throw error;
  }
};

// get notes 

export const getNotes = async() =>{
  try {
    const result = await client.query("select * from notes")

    return result.rows;
  } catch (error) {
    throw error;
  }
}

export const getNotesData = async () => {
  try {
    const result = await client.query(`
      SELECT
        id,
        title,
        images,
        created_at,
        is_pinned,
        is_favorite,
        is_archived,

        (
          SELECT
            CASE
              WHEN array_length(
                regexp_split_to_array(trim(block->>'text'), '\\s+'),
                1
              ) > 12
              THEN array_to_string(
                (regexp_split_to_array(trim(block->>'text'), '\\s+'))[1:12],
                ' '
              ) || '...'
              ELSE block->>'text'
            END
          FROM jsonb_array_elements(content) AS block
          ORDER BY (block->>'id')::int ASC
          LIMIT 1
        ) AS preview

      FROM notes
      ORDER BY created_at DESC
    `);

    return result.rows;
  } catch (error) {
    throw error;
  }
};


export const getNotesById = async(notesId) =>{
  try {
    const result = await pool.query(
      `select * from notes where id = $1 and status = 'active'`, [notesId]
    );

    return result.rows;
  } catch (error) {
    throw error;
  }
}


export const getNotesByTopicId = async(notesId) =>{
  try {
    const result = await pool.query(
      `select * from notes where topicid = $1 and status = 'active'`, [notesId]
    );

    return result.rows;
  } catch (error) {
    throw error;
  }
}

export const deleteNotes = async(notesId) =>{
  try {
    const result = await pool.query(
      `delete from notes where id = $1 `, [notesId]
    );

    return result.row ;
  } catch (error) {
    throw error;
  }
}