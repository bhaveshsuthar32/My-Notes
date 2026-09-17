import { createNotesService, deleteNotes, getNotes, getNotesById, getNotesByTopicId } from "../services/notes.service.js";


// export const createNotes = async (req, res) => {

//   try {

//     const note = await createNotesService(req.body);

//     return res.status(201).json({
//       success: true,
//       data: note
//     });

//   } catch (error) {

//     console.log(error);

//     return res.status(500).json({
//       success: false,
//       message: "Failed to create note"
//     });
//   }
// };




export const createNotes = async (req, res) => {
  try {
    console.log("CREATE NOTES API STARTED");

    console.log("BODY:", req.body);
    console.log("FILES:", req.files);

    const {
      title,
      subtitle,
      content,
      topicid,
      status,
    } = req.body;

    if (!title || !content || !topicId) {
      return res.status(400).json({
        success: false,
        message: "Title, content and topicid are required",
      });
    }

    let imageUrls = [];

    // Multiple images upload
    if (req.files && req.files.length > 0) {
      imageUrls = await Promise.all(
        req.files.map(async (file) => {
          return await uploadFile(file);
        })
      );
    }

    const note = await createNotesService({
      title,
      subtitle,
      content,
      images: imageUrls,
      topicid: Number(topicid),
      status: status?.toLowerCase() || "active",
    });

    return res.status(201).json({
      success: true,
      data: note,
    });
  } catch (error) {
    console.error("CREATE NOTES ERROR:", error);

    return res.status(500).json({
      success: false,
      message: error.message || "Failed to create note",
    });
  }
};

// get notes

export const getNotesList = async(req, res) =>{
  try {
    const notesList = await getNotes();

    return res.status(200).json({
      success:true,
      data: notesList
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: error.message
    });
  }
}

export const getNoteDetailsById = async (req,res)=>{
  try {
    const {notesId} = req.params;

    const notesDetails = await getNotesById(notesId);

    return res.status(200).json({
      success:true,
      data: notesDetails
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: error.message
    });
  }
}

export const getNotesByTopic = async(req, res) =>{
  try {

    const {topicId} = req.params;

    const notesListByTopic = await getNotesByTopicId(topicId);

    return res.status(200).json({
      success:true,
      data: notesListByTopic
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: error.message
    });
  }
}

export const deleteNotesById = async(req, res) =>{
  try {
    const notesId = req.params.notesId;
    const removeNotes = await deleteNotes(notesId)
    
    return res.status(200).json({
      success:true,
      data: removeNotes
    });

  } catch (error) {
    return res.status(500).json({
      success: false,
      message: error.message
    });
  }
}