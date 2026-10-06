// import express from "express"
// import { getUser, login, logout, registerUser } from "../controllers/admin.controller.js";
// import { createNotes, deleteNotesById, getNoteDetailsById, getNotesByTopic, getNotesList, getNotesListData, updateNotesLayoutById } from "../controllers/notes.controller.js";
// import { createTopic, deleteTopicById, getTopicList, getTopicListById } from "../controllers/topics.controller.js";
// import upload from "../middleware/upload.js";
// const router = express.Router();


// router.post("/register", registerUser );
// router.post("/login", login);
// router.post("/logout", logout);
// router.get("/user", getUser);
// router.post("/notes", upload.array("images") ,createNotes);
// router.post("/topics", upload.single("coverImage"), createTopic);
// router.get("/getTopic", getTopicList);
// router.get("/getNotes" , getNotesList);
// router.get("/getNotes-list" , getNotesListData);
// router.get("/topic/:topicId", getTopicListById);
// router.get("/note-details/:notesId",getNoteDetailsById);
// router.get("/notesbytopic/:topicId", getNotesByTopic);
// router.delete("/delete-notes/:notesId", deleteNotesById);
// router.delete("/delete-topic/:topicId", deleteTopicById);

// router.put("/notes/:notesId/layout", updateNotesLayoutById);

// export default router;



import express from "express";
import { getProfile, getUser, login, logout, registerUser } from "../controllers/admin.controller.js";
import { createNotes, deleteNotesById, getNoteDetailsById, getNotesByTopic, getNotesList, getNotesListData, updateNotesLayoutById } from "../controllers/notes.controller.js";
import { createTopic, deleteTopicById, getTopicList, getTopicListById } from "../controllers/topics.controller.js";
import upload from "../middleware/upload.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = express.Router();

router.post("/register", registerUser);
router.post("/login", login);

router.post("/topics", authMiddleware, upload.single("coverImage"), createTopic);
router.get("/getTopic", authMiddleware, getTopicList);
router.get("/topic/:topicId", authMiddleware, getTopicListById);
router.delete("/delete-topic/:topicId", authMiddleware, deleteTopicById);

router.post("/notes", authMiddleware, upload.array("images"), createNotes);
router.get("/getNotes", authMiddleware, getNotesList);
router.get("/getNotes-list", authMiddleware, getNotesListData);
router.get("/notesbytopic/:topicId", authMiddleware, getNotesByTopic);
router.get("/note-details/:notesId", authMiddleware, getNoteDetailsById);
router.delete("/delete-notes/:notesId", authMiddleware, deleteNotesById);
router.put("/notes/:notesId/layout", authMiddleware, updateNotesLayoutById);

router.post("/logout", authMiddleware, logout);

router.get("/user", authMiddleware, getUser);

router.get("/profile", authMiddleware, getProfile);

export default router;