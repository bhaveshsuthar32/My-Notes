import express from "express"
import { loign, registerUser } from "../controllers/admin.controller.js";
import { createNotes } from "../controllers/notes.controller.js";
import { createTopic } from "../controllers/topics.controller.js";
import upload from "../middleware/upload.js";
const router = express.Router();


router.post("/register", registerUser );
router.post("/login", loign)
router.post("/notes", upload.array("images") ,createNotes);
router.post("/topics", upload.single("coverImage"), createTopic);

export default router;