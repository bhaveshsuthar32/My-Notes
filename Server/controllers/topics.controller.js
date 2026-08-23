import { createTopicService, deleteTopic, getTopic, getTopicBYId} from "../services/topics.services.js";


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


export const getTopicList = async(req, res) =>{

  try {
    const topicList = await getTopic();
     return res.status(200).json({
      success: true,
      data: topicList
    });
  } catch (error) {
        return res.status(500).json({
      success: false,
      message: error.message
    });
  }
}


export const getTopicListById = async (req, res)=>{
  try {
const topicId = req.params.topicId;

    const result1 = await getTopicBYId(topicId);
    return res.status(200).json({
      success: true,
      data : result1

    })
  } catch (error) {
    throw error;
  }
}


export const deleteTopicById = async(req, res) =>{
  try {
    const topicId = req.params.topicId;
    const removeTopic = await deleteTopic(topicId)
    
    return res.status(200).json({
      success:true,
      data: removeTopic
    });

  } catch (error) {
    return res.status(500).json({
      success: false,
      message: error.message
    });
  }
}