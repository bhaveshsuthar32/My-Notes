import { createNotesService, deleteNotes, getNotes, getNotesById, getNotesByTopicId } from "../services/notes.service.js";


export const createNotes = async (req, res) => {

  try {

    const note = await createNotesService(req.body);

    return res.status(201).json({
      success: true,
      data: note
    });

  } catch (error) {

    console.log(error);

    return res.status(500).json({
      success: false,
      message: "Failed to create note"
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