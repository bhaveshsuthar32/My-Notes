import { createNotesService, deleteNotes, getNotes, getNotesById, getNotesByTopicId, updateNotesLayout } from "../services/notes.service.js";


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
      topicid,
      status,
      subtitle,
      content,
      images,
      contentOrder,
    } = req.body;

    // Required fields
    if (!title || !topicid) {
      return res.status(400).json({
        success: false,
        message: "Title and topicid are required",
      });
    }

    // Parse arrays
    let subtitles = [];
    let contents = [];
    let imageList = [];
    let order = [];

    try {
      subtitles = subtitle
        ? typeof subtitle === "string"
          ? JSON.parse(subtitle)
          : subtitle
        : [];

      contents = content
        ? typeof content === "string"
          ? JSON.parse(content)
          : content
        : [];

      imageList = images
        ? typeof images === "string"
          ? JSON.parse(images)
          : images
        : [];

      order = contentOrder
        ? typeof contentOrder === "string"
          ? JSON.parse(contentOrder)
          : contentOrder
        : [];
    } catch (error) {
      return res.status(400).json({
        success: false,
        message:
          "Invalid JSON format in subtitle, content, images or contentOrder",
      });
    }

    // Validate arrays
    if (!Array.isArray(subtitles)) {
      return res.status(400).json({
        success: false,
        message: "subtitle must be an array",
      });
    }

    if (!Array.isArray(contents)) {
      return res.status(400).json({
        success: false,
        message: "content must be an array",
      });
    }

    if (!Array.isArray(imageList)) {
      return res.status(400).json({
        success: false,
        message: "images must be an array",
      });
    }

    if (!Array.isArray(order)) {
      return res.status(400).json({
        success: false,
        message: "contentOrder must be an array",
      });
    }

    // Upload local images
    let fileIndex = 0;

    for (const image of imageList) {
      if (!image.value && req.files && req.files[fileIndex]) {
        const uploadedUrl = await uploadFile(req.files[fileIndex]);

        image.value = uploadedUrl;

        fileIndex++;
      }
    }

    // Final image data
    const imageData = imageList.map((image) => ({
      id: image.id,
      value: image.value,
    }));

    // Final content order
    const finalOrder = order.map((item) => ({
      id: item.id,
      type: item.type,
    }));

    // Create note
    const note = await createNotesService({
      title,
      subtitle: subtitles,
      content: contents,
      images: imageData,
      contentOrder: finalOrder,
      topicid: Number(topicid),
      status: status?.toLowerCase() || "active",
    });

    return res.status(201).json({
      success: true,
      message: "Note created successfully",
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

// export const createNotes = async (req, res) => {
//   try {
//     console.log("CREATE NOTES API STARTED");

//     console.log("BODY:", req.body);
//     console.log("FILES:", req.files);

//     const {
//       title,
//       subtitle,
//       content,
//       topicid,
//       status,
//     } = req.body;

//     if (!title || !content || !topicid) {
//       return res.status(400).json({
//         success: false,
//         message: "Title, content and topicid are required",
//       });
//     }

//     let imageUrls = [];

//     // Multiple images upload
//     if (req.files && req.files.length > 0) {
//       imageUrls = await Promise.all(
//         req.files.map(async (file) => {
//           return await uploadFile(file);
//         })
//       );
//     }

//     const note = await createNotesService({
//       title,
//       subtitle,
//       content,
//       images: imageUrls,
//       topicid: Number(topicid),
//       status: status?.toLowerCase() || "active",
//     });

//     return res.status(201).json({
//       success: true,
//       data: note,
//     });
//   } catch (error) {
//     console.error("CREATE NOTES ERROR:", error);

//     return res.status(500).json({
//       success: false,
//       message: error.message || "Failed to create note",
//     });
//   }
// };

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


// Update Notes Layout
export const updateNotesLayoutById = async (req, res) => {
  try {
    const { notesId } = req.params;
    const { layout } = req.body;

    console.log("UPDATE NOTES LAYOUT API STARTED");
    console.log("NOTE ID:", notesId);
    console.log("LAYOUT:", layout);

    // Check note ID
    if (!notesId) {
      return res.status(400).json({
        success: false,
        message: "notesId is required",
      });
    }

    // Check layout
    if (!layout) {
      return res.status(400).json({
        success: false,
        message: "layout is required",
      });
    }

    // Layout must be object
    if (typeof layout !== "object" || Array.isArray(layout)) {
      return res.status(400).json({
        success: false,
        message: "layout must be a valid object",
      });
    }

    // Update layout
    const updatedNote = await updateNotesLayout(
      notesId,
      layout
    );

    if (!updatedNote) {
      return res.status(404).json({
        success: false,
        message: "Note not found",
      });
    }

    return res.status(200).json({
      success: true,
      message: "Note layout updated successfully",
      data: updatedNote,
    });

  } catch (error) {
    console.error("UPDATE NOTES LAYOUT ERROR:", error);

    return res.status(500).json({
      success: false,
      message: error.message || "Failed to update note layout",
    });
  }
};