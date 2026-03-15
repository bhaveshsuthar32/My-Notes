import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import { connectDB } from "./config/db.js";
import router from "./route/routes.js";

dotenv.config();
const app = express();
const PORT = process.env.PORT || 4001;

app.use(cors());
app.use(express.json());

// app.use("/", router);
app.get("/test", (req,res)=>{
  res.send("this is good!");
})

app.use("/api", router);

const startServer = async () => {
  await connectDB();
  app.listen(PORT, () => {
    console.log(`🚀 Server running on port ${PORT}`);
  });
};

startServer();