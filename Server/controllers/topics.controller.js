// import { createTopicService, deleteTopic, getTopic, getTopicBYId } from "../services/topics.services.js";


// // export const createTopic = async (req, res) => {

// //   try {

// //     const topic = await createTopicService(req.body);

// //     return res.status(201).json({
// //       success: true,
// //       data: topic
// //     });

// //   } catch (error) {

// //     console.log(error);

// //     return res.status(500).json({
// //       success: false,
// //       message: "Topic creation failed"
// //     });
// //   }
// // };

// import { uploadFile } from "../utils/cloudinary.js";
// // import { createTopicService } from "../services/topics.service.js";

// // export const createTopic = async (req, res) => {
// //   try {
// //  const {
// //   name,
// //   description,
// //   coverImageUrl,
// //   status,
// // } = req.body;

// // const normalizedStatus = status?.toLowerCase() || "active";

// // let coverImage = coverImageUrl || null;

// // if (req.file) {
// //   coverImage = await uploadFile(req.file);
// // }
// //     const topic = await createTopicService({
// //       name,
// //       description,
// //       coverImage,
// //       status,
// //     });

// //     res.json({
// //       success: true,
// //       data: topic,
// //     });
// //   } catch (error) {
// //     console.log(error);

// //     res.status(500).json({
// //       success: false,
// //       message: error.message,
// //     });
// //   }
// // };

// export const createTopic = async (req, res) => {
//   try {
//     const {
//       name,
//       description,
//       coverImage,
//       coverImageUrl,
//       status,
//     } = req.body;

//     const normalizedStatus =
//       status?.toLowerCase() || "active";

//     // coverImageUrl ya coverImage, dono me se jo milega use karega
//     let finalCoverImage =
//       coverImageUrl || coverImage || null;

//     // Agar gallery se file aayi hai, to Cloudinary upload hoga
//     if (req.file) {
//       finalCoverImage = await uploadFile(req.file);
//     }

//     const topic = await createTopicService({
//       name,
//       description,
//       coverImage: finalCoverImage,
//       status: normalizedStatus,
//     });

//     return res.status(201).json({
//       success: true,
//       data: topic,
//     });
//   } catch (error) {
//     console.error("CREATE TOPIC ERROR:", error);

//     return res.status(500).json({
//       success: false,
//       message: error.message || "Failed to create topic",
//     });
//   }
// };

// export const getTopicList = async (req, res) => {

//   try {
//     const topicList = await getTopic();
//     return res.status(200).json({
//       success: true,
//       data: topicList
//     });
//   } catch (error) {
//     return res.status(500).json({
//       success: false,
//       message: error.message
//     });
//   }
// }


// export const getTopicListById = async (req, res) => {
//   try {
//     const topicId = req.params.topicId;

//     const result1 = await getTopicBYId(topicId);
//     return res.status(200).json({
//       success: true,
//       data: result1

//     })
//   } catch (error) {
//     throw error;
//   }
// }


// export const deleteTopicById = async (req, res) => {
//   try {
//     const topicId = req.params.topicId;
//     const removeTopic = await deleteTopic(topicId)

//     return res.status(200).json({
//       success: true,
//       data: removeTopic
//     });

//   } catch (error) {
//     return res.status(500).json({
//       success: false,
//       message: error.message
//     });
//   }
// }



import {
  createTopicService,
  deleteTopic,
  getTopic,
  getTopicBYId,
} from "../services/topics.services.js";

import { uploadFile } from "../utils/cloudinary.js";


// ======================================================
// CREATE TOPIC
// ======================================================

export const createTopic = async (req, res) => {
  try {
    console.log("CREATE TOPIC API STARTED");

    console.log("USER:", req.user);
    console.log("BODY:", req.body);
    console.log("FILE:", req.file);

    // --------------------------------------------------
    // Check logged-in user
    // --------------------------------------------------

    if (!req.user || !req.user.id) {
      return res.status(401).json({
        success: false,
        message: "Unauthorized user",
      });
    }

    // JWT se user id
    const userId = req.user.id;

    // --------------------------------------------------
    // Get body data
    // --------------------------------------------------

    const {
      name,
      description,
      coverImage,
      coverImageUrl,
      status,
    } = req.body;

    // --------------------------------------------------
    // Required field
    // --------------------------------------------------

    if (!name) {
      return res.status(400).json({
        success: false,
        message: "Topic name is required",
      });
    }

    // --------------------------------------------------
    // Normalize status
    // --------------------------------------------------

    const normalizedStatus =
      status?.toLowerCase() || "active";

    // --------------------------------------------------
    // Cover image
    // --------------------------------------------------

    let finalCoverImage =
      coverImageUrl || coverImage || null;

    // --------------------------------------------------
    // Upload file to Cloudinary
    // --------------------------------------------------

    if (req.file) {
      finalCoverImage = await uploadFile(req.file);
    }

    // --------------------------------------------------
    // Create topic
    // --------------------------------------------------

    const topic = await createTopicService({
      name,
      description,
      coverImage: finalCoverImage,
      status: normalizedStatus,

      // IMPORTANT
      // User ID JWT se aa raha hai
      userId,
    });

    return res.status(201).json({
      success: true,
      message: "Topic created successfully",
      data: topic,
    });

  } catch (error) {

    console.error(
      "CREATE TOPIC ERROR:",
      error
    );

    return res.status(500).json({
      success: false,
      message:
        error.message ||
        "Failed to create topic",
    });
  }
};


// ======================================================
// GET ALL TOPICS OF LOGGED-IN USER
// ======================================================

export const getTopicList = async (req, res) => {
  try {

    // --------------------------------------------------
    // Check user
    // --------------------------------------------------

    if (!req.user || !req.user.id) {
      return res.status(401).json({
        success: false,
        message: "Unauthorized user",
      });
    }

    const userId = req.user.id;

    // --------------------------------------------------
    // Get topics
    // --------------------------------------------------

    const topicList = await getTopic(userId);

    return res.status(200).json({
      success: true,
      data: topicList,
    });

  } catch (error) {

    console.error(
      "GET TOPIC ERROR:",
      error
    );

    return res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};


// ======================================================
// GET TOPIC BY ID
// ======================================================

export const getTopicListById = async (req, res) => {
  try {

    // --------------------------------------------------
    // Check user
    // --------------------------------------------------

    if (!req.user || !req.user.id) {
      return res.status(401).json({
        success: false,
        message: "Unauthorized user",
      });
    }

    const { topicId } = req.params;

    // --------------------------------------------------
    // Check topic ID
    // --------------------------------------------------

    if (!topicId) {
      return res.status(400).json({
        success: false,
        message: "topicId is required",
      });
    }

    const userId = req.user.id;

    // --------------------------------------------------
    // Get topic
    // --------------------------------------------------

    const result = await getTopicBYId(
      topicId,
      userId
    );

    if (!result) {
      return res.status(404).json({
        success: false,
        message: "Topic not found",
      });
    }

    return res.status(200).json({
      success: true,
      data: result,
    });

  } catch (error) {

    console.error(
      "GET TOPIC BY ID ERROR:",
      error
    );

    return res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};


// ======================================================
// DELETE TOPIC
// ======================================================

export const deleteTopicById = async (req, res) => {
  try {

    // --------------------------------------------------
    // Check user
    // --------------------------------------------------

    if (!req.user || !req.user.id) {
      return res.status(401).json({
        success: false,
        message: "Unauthorized user",
      });
    }

    const { topicId } = req.params;

    // --------------------------------------------------
    // Check topic ID
    // --------------------------------------------------

    if (!topicId) {
      return res.status(400).json({
        success: false,
        message: "topicId is required",
      });
    }

    const userId = req.user.id;

    // --------------------------------------------------
    // Delete topic
    // --------------------------------------------------

    const removeTopic = await deleteTopic(
      topicId,
      userId
    );

    if (!removeTopic) {
      return res.status(404).json({
        success: false,
        message: "Topic not found or unauthorized",
      });
    }

    return res.status(200).json({
      success: true,
      message: "Topic deleted successfully",
      data: removeTopic,
    });

  } catch (error) {

    console.error(
      "DELETE TOPIC ERROR:",
      error
    );

    return res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};