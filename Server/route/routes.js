import express from "express"
import { getUser, login, registerUser } from "../controllers/admin.controller.js";
import { createNotes, deleteNotesById, getNoteDetailsById, getNotesByTopic, getNotesList } from "../controllers/notes.controller.js";
import { createTopic, deleteTopicById, getTopicList, getTopicListById } from "../controllers/topics.controller.js";
import upload from "../middleware/upload.js";
const router = express.Router();


router.post("/register", registerUser );
router.post("/login", login);
router.get("/user", getUser);
router.post("/notes", upload.array("images") ,createNotes);
router.post("/topics", upload.single("coverImage"), createTopic);
router.get("/getTopic", getTopicList);
router.get("/getNotes" , getNotesList);
router.get("/topic/:topicId", getTopicListById);
router.get("/note-details/:notesId",getNoteDetailsById);
router.get("/notesbytopic/:topicId", getNotesByTopic);
router.delete("/delete-notes/:notesId", deleteNotesById);
router.delete("/delete-topic/:topicId", deleteTopicById);

export default router;