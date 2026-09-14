// const multer = require('multer');

// const upload = multer({
//     storage : multer.memoryStorage({}),
//     limits: { fileSize : 500000}
// })

// module.exports = upload ;



import multer from "multer";

const upload = multer({
  storage: multer.memoryStorage(),
  // limits: { fileSize: 500000 }
  
  limits: {
    fileSize: 5 * 1024 * 1024, // 5 MB
  },
});

export default upload;