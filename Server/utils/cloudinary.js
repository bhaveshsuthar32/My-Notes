// require('dotenv').config();
// const cloudinary = require("cloudinary").v2;

// cloudinary.config({
//   cloud_name: process.env.CLOUD_NAME,
//   api_key: process.env.API_KEY,
//   api_secret: process.env.API_SECRET,
// });

// const uplaodFile = async(file) =>{
//     try {
//         return new Promise((resolve , reject)=>{
//             const uploadStream = cloudinary.uploader.upload_stream(
//                 {resource_type : 'auto'},
//                 (error, result)=>{
//                     if(error){
//                         reject(error);
//                     }else{
//                         resolve(result.secure_url);
//                     }
//                 }
//             )

//             uploadStream.end(file.buffer);
//         })
        
//     } catch (error) {
//     console.error("Error uploading to Cloudinary:", error);
//     throw error;
//   }
// };

// module.exports = uplaodFile ;



import dotenv from "dotenv";
import { v2 as cloudinary } from "cloudinary";

dotenv.config();

cloudinary.config({
  cloud_name: process.env.CLOUD_NAME,
  api_key: process.env.API_KEY,
  api_secret: process.env.API_SECRET,
});

export const uploadFile = async (file) => {
  try {
    return new Promise((resolve, reject) => {
      const uploadStream = cloudinary.uploader.upload_stream(
        { resource_type: "auto" },
        (error, result) => {
          if (error) {
            reject(error);
          } else {
            resolve(result.secure_url);
          }
        }
      );

      uploadStream.end(file.buffer);
    });

  } catch (error) {
    console.error("Error uploading to Cloudinary:", error);
    throw error;
  }
};
