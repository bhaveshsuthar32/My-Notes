// import pool from "../config/db.js";

// const client = await pool.connect();

// // export const createNotesService = async (data) => {

// //   try {

// //     const { title, subtitle, content, images, topicId, status } = data;

// //     const result = await client.query(
// //       `INSERT INTO notes 
// //       (title, subtitle, content, images, topicId, status)
// //       VALUES ($1,$2,$3,$4,$5,$6)
// //       RETURNING *`,
// //       [
// //         title,
// //         subtitle,
// //         content,
// //         images,
// //         topicId,
// //         status || "active"
// //       ]
// //     );

// //     return result.rows[0];

// //   } catch (error) {
// //     throw error;

// //   } finally {
// //     client.release();
// //   }
// // };



// export const createNotesService = async (data) => {
//   try {
//     const {
//       title,
//       subtitle,
//       content,
//       images,
//       contentOrder,
//       topicid,
//       status,
//     } = data;

//     const result = await client.query(
//       `INSERT INTO notes
//       (
//         title,
//         subtitle,
//         content,
//         images,
//         "contentOrder",
//         "topicid",
//         status
//       )
//       VALUES ($1::text, $2::jsonb, $3::jsonb, $4::jsonb, $5::jsonb, $6, $7)
//       RETURNING *`,
//       [
//         title,
//         JSON.stringify(subtitle || []),
//         JSON.stringify(content || []),
//         JSON.stringify(images || []),
//         JSON.stringify(contentOrder || []),
//         topicid,
//         status || "active",
//       ]
//     );

//     return result.rows[0];

//   } catch (error) {
//     throw error;
//   }
// };

// // export const createNotesService = async (data) => {
// //   try {
// //     const {
// //       title,
// //       subtitle,
// //       content,
// //       images,
// //       topicid,
// //       status,
// //     } = data;

// //     const result = await client.query(
// //       `INSERT INTO notes
// //       (title, subtitle, content, images, "topicid", status)
// //       VALUES ($1, $2, $3, $4, $5, $6)
// //       RETURNING *`,
// //       [
// //         title,
// //         subtitle,
// //         content,
// //         images,
// //         topicid,
// //         status || "active",
// //       ]
// //     );

// //     return result.rows[0];
// //   } catch (error) {
// //     throw error;
// //   }
// // };


// export const updateNotesLayout = async (notesId, layout) => {
//   try {
//     const result = await client.query(
//       `
//       UPDATE notes
//       SET layout = $1::jsonb
//       WHERE id = $2
//       RETURNING *
//       `,
//       [
//         JSON.stringify(layout),
//         notesId,
//       ]
//     );

//     return result.rows[0] || null;

//   } catch (error) {
//     throw error;
//   }
// };

// // get notes 

// export const getNotes = async() =>{
//   try {
//     const result = await client.query("select * from notes")

//     return result.rows;
//   } catch (error) {
//     throw error;
//   }
// }

// export const getNotesData = async () => {
//   try {
//     const result = await client.query(`
//       SELECT
//         id,
//         title,
//         subtitle,
//         content,
//         images,
//         "contentOrder",
//         topicid,
//         created_at,
//         is_pinned,
//         is_favorite,
//         is_archived,

//         CASE
//           -- Agar content JSON array hai
//           WHEN trim(content::text) LIKE '[%' THEN
//             (
//               SELECT
//                 CASE
//                   WHEN array_length(
//                     regexp_split_to_array(
//                       trim(block->>'value'),
//                       '\\s+'
//                     ),
//                     1
//                   ) > 12
//                   THEN array_to_string(
//                     (
//                       regexp_split_to_array(
//                         trim(block->>'value'),
//                         '\\s+'
//                       )
//                     )[1:12],
//                     ' '
//                   ) || '...'
//                   ELSE block->>'value'
//                 END
//               FROM jsonb_array_elements(
//                 content::jsonb
//               ) AS block
//               LIMIT 1
//             )

//           -- Agar normal text hai
//           ELSE
//             CASE
//               WHEN array_length(
//                 regexp_split_to_array(
//                   trim(content::text),
//                   '\\s+'
//                 ),
//                 1
//               ) > 12
//               THEN array_to_string(
//                 (
//                   regexp_split_to_array(
//                     trim(content::text),
//                     '\\s+'
//                   )
//                 )[1:12],
//                 ' '
//               ) || '...'
//               ELSE content::text
//             END
//         END AS preview

//       FROM notes
//       ORDER BY created_at DESC
//     `);

//     return result.rows;

//   } catch (error) {
//     console.error("GET NOTES LIST ERROR:", error);
//     throw error;
//   }
// };


// export const getNotesById = async(notesId) =>{
//   try {
//     const result = await pool.query(
//       `select * from notes where id = $1 and status = 'active'`, [notesId]
//     );

//     return result.rows;
//   } catch (error) {
//     throw error;
//   }
// }


// export const getNotesByTopicId = async(notesId) =>{
//   try {
//     const result = await pool.query(
//       `select * from notes where topicid = $1 and status = 'active'`, [notesId]
//     );

//     return result.rows;
//   } catch (error) {
//     throw error;
//   }
// }

// export const deleteNotes = async(notesId) =>{
//   try {
//     const result = await pool.query(
//       `delete from notes where id = $1 `, [notesId]
//     );

//     return result.row ;
//   } catch (error) {
//     throw error;
//   }
// }







import pool from "../config/db.js";


// ======================================================
// CREATE NOTE
// ======================================================

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
      userId,
    } = data;

    const result = await pool.query(
      `
      INSERT INTO notes
      (
        title,
        subtitle,
        content,
        images,
        "contentOrder",
        "topicid",
        status,
        user_id
      )
      VALUES
      (
        $1::text,
        $2::jsonb,
        $3::jsonb,
        $4::jsonb,
        $5::jsonb,
        $6,
        $7,
        $8
      )
      RETURNING *
      `,
      [
        title,
        JSON.stringify(subtitle || []),
        JSON.stringify(content || []),
        JSON.stringify(images || []),
        JSON.stringify(contentOrder || []),
        topicid,
        status || "active",
        userId,
      ]
    );

    return result.rows[0];

  } catch (error) {

    console.error(
      "CREATE NOTES SERVICE ERROR:",
      error
    );

    throw error;
  }
};


// ======================================================
// UPDATE NOTE LAYOUT
// ======================================================

export const updateNotesLayout = async (
  notesId,
  layout,
  userId
) => {
  try {

    const result = await pool.query(
      `
      UPDATE notes
      SET layout = $1::jsonb
      WHERE id = $2
      AND user_id = $3
      RETURNING *
      `,
      [
        JSON.stringify(layout),
        notesId,
        userId,
      ]
    );

    return result.rows[0] || null;

  } catch (error) {

    console.error(
      "UPDATE NOTES LAYOUT SERVICE ERROR:",
      error
    );

    throw error;
  }
};


// ======================================================
// GET NOTES
// ======================================================

export const getNotes = async (userId) => {
  try {

    const result = await pool.query(
      `
      SELECT *
      FROM notes
      WHERE user_id = $1
      ORDER BY created_at DESC
      `,
      [userId]
    );

    return result.rows;

  } catch (error) {

    console.error(
      "GET NOTES SERVICE ERROR:",
      error
    );

    throw error;
  }
};


// ======================================================
// GET NOTES DATA
// ======================================================

export const getNotesData = async (userId) => {
  try {

    const result = await pool.query(
      `
      SELECT
        id,
        title,
        subtitle,
        content,
        images,
        "contentOrder",
        topicid,
        created_at,
        is_pinned,
        is_favorite,
        is_archived,

        CASE

          -- ============================================
          -- Content JSON array
          -- ============================================

          WHEN trim(content::text) LIKE '[%' THEN

            (
              SELECT
                CASE

                  WHEN array_length(
                    regexp_split_to_array(
                      trim(block->>'value'),
                      '\\s+'
                    ),
                    1
                  ) > 12

                  THEN
                    array_to_string(
                      (
                        regexp_split_to_array(
                          trim(block->>'value'),
                          '\\s+'
                        )
                      )[1:12],
                      ' '
                    ) || '...'

                  ELSE
                    block->>'value'

                END

              FROM jsonb_array_elements(
                content::jsonb
              ) AS block

              LIMIT 1
            )

          -- ============================================
          -- Normal text
          -- ============================================

          ELSE

            CASE

              WHEN array_length(
                regexp_split_to_array(
                  trim(content::text),
                  '\\s+'
                ),
                1
              ) > 12

              THEN
                array_to_string(
                  (
                    regexp_split_to_array(
                      trim(content::text),
                      '\\s+'
                    )
                  )[1:12],
                  ' '
                ) || '...'

              ELSE
                content::text

            END

        END AS preview

      FROM notes

      WHERE user_id = $1

      ORDER BY created_at DESC
      `,
      [userId]
    );

    return result.rows;

  } catch (error) {

    console.error(
      "GET NOTES LIST ERROR:",
      error
    );

    throw error;
  }
};


// ======================================================
// GET NOTE BY ID
// ======================================================

export const getNotesById = async (
  notesId,
  userId
) => {
  try {

    const result = await pool.query(
      `
      SELECT *
      FROM notes
      WHERE id = $1
      AND user_id = $2
      AND status = 'active'
      `,
      [
        notesId,
        userId,
      ]
    );

    return result.rows;

  } catch (error) {

    console.error(
      "GET NOTE BY ID SERVICE ERROR:",
      error
    );

    throw error;
  }
};


// ======================================================
// GET NOTES BY TOPIC
// ======================================================

export const getNotesByTopicId = async (
  topicId,
  userId
) => {
  try {

    const result = await pool.query(
      `
      SELECT *
      FROM notes
      WHERE topicid = $1
      AND user_id = $2
      AND status = 'active'
      ORDER BY created_at DESC
      `,
      [
        topicId,
        userId,
      ]
    );

    return result.rows;

  } catch (error) {

    console.error(
      "GET NOTES BY TOPIC SERVICE ERROR:",
      error
    );

    throw error;
  }
};


// ======================================================
// DELETE NOTE
// ======================================================

export const deleteNotes = async (
  notesId,
  userId
) => {
  try {

    const result = await pool.query(
      `
      DELETE FROM notes
      WHERE id = $1
      AND user_id = $2
      RETURNING *
      `,
      [
        notesId,
        userId,
      ]
    );

    return result.rows[0] || null;

  } catch (error) {

    console.error(
      "DELETE NOTES SERVICE ERROR:",
      error
    );

    throw error;
  }
};