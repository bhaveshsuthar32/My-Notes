// const multer = require('multer');

// const upload = multer({
//     storage : multer.memoryStorage({}),
//     limits: { fileSize : 500000}
// })

// module.exports = upload ;



import multer from "multer";

const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 500000 }
});

export default upload;