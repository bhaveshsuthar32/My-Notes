import { createNotesService } from "../services/notes.service.js";


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

