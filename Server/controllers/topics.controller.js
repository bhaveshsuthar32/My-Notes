import { createTopicService } from "../services/topics.services.js";


// export const createTopic = async (req, res) => {

//   try {

//     const topic = await createTopicService(req.body);

//     return res.status(201).json({
//       success: true,
//       data: topic
//     });

//   } catch (error) {

//     console.log(error);

//     return res.status(500).json({
//       success: false,
//       message: "Topic creation failed"
//     });
//   }
// };


import { uploadFile } from "../utils/cloudinary.js";

export const createTopic = async (req, res) => {

  try {

    const { name, description, status } = req.body;

    let coverImage = null;

    if (req.file) {
      coverImage = await uploadFile(req.file);
    }

    const topic = await createTopicService({
      name,
      description,
      coverImage,
      status
    });

    res.json({
      success: true,
      data: topic
    });

  } catch (error) {

    console.log(error);

    res.status(500).json({
      success: false
    });

  }
};