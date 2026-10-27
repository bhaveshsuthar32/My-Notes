import bcrypt from "bcrypt";
import dotenv from "dotenv";
import pool from "../config/db.js";
import jwt from "jsonwebtoken";
import { sendRegistrationOTP } from "../services/email_service.js";
dotenv.config();

import crypto from "crypto";
// import { pool } from "../config/db.js";



// export const registerUser = async (req, res) => {
//     const { firstname, lastname, email, password, isadmin } = req.body;
//     try {
//         if (!firstname || !lastname || !email || !password) {
//             return res.status(400).json({
//                 success: false,
//                 message: "All field is required",
//             })
//         }

//         const hashpassword = await bcrypt.hash(password, 10);

//         const result = await pool.query(
//             `INSERT INTO users 
//             (firstname, lastname, email, password, isadmin)
//             VALUES ($1,$2,$3,$4,$5)
//             RETURNING id, firstname, lastname, email, isadmin`,
//             [
//                 firstname,
//                 lastname,
//                 email,
//                 hashpassword,
//                 isadmin || "User",
//             ]
//         );
//         return res.status(200).json({
//             success: true,
//             user: result.rows[0]
//         })

//     // } catch (error) {
//     //     return res.status(500).json({
//     //         success: false,
//     //         message: "User register failed!"
//     //     })
//     // }
//     } catch (error) {
//     console.error("REGISTER ERROR:", error);

//     return res.status(500).json({
//         success: false,
//         message: error.message || "User register failed!"
//     });
// }
// }



// export const registerUser = async (req, res) => {
//   const {
//     firstname,
//     lastname,
//     email,
//     password,
//   } = req.body;

//   try {
//     if (
//       !firstname ||
//       !lastname ||
//       !email ||
//       !password
//     ) {
//       return res.status(400).json({
//         success: false,
//         message: "All fields are required",
//       });
//     }

//     const existingUser = await pool.query(
//       `SELECT id FROM users WHERE email = $1`,
//       [email]
//     );

//     if (existingUser.rows.length > 0) {
//       return res.status(409).json({
//         success: false,
//         message: "Email already registered",
//       });
//     }

//     const hashpassword =
//       await bcrypt.hash(password, 10);

//     const result = await pool.query(
//       `INSERT INTO users
//       (
//         firstname,
//         lastname,
//         email,
//         password,
//         isadmin
//       )
//       VALUES ($1, $2, $3, $4, $5)
//       RETURNING
//         id,
//         firstname,
//         lastname,
//         email,
//         isadmin`,
//       [
//         firstname,
//         lastname,
//         email,
//         hashpassword,
//         "user",
//       ]
//     );

//     return res.status(201).json({
//       success: true,
//       message: "User registered successfully",
//       user: result.rows[0],
//     });
//   } catch (error) {
//     console.error(
//       "REGISTER ERROR:",
//       error
//     );

//     return res.status(500).json({
//       success: false,
//       message:
//         error.message ||
//         "User register failed!",
//     });
//   }
// };




// OTP system register update code:


export const registerUser = async (req, res) => {
    const firstname = req.body.firstname?.trim();
    const lastname = req.body.lastname?.trim();
    const email = req.body.email?.trim().toLowerCase();
    const password = req.body.password;

    try {
        if (!firstname || !lastname || !email || !password) {
            return res.status(400).json({
                success: false,
                message: "All fields are required",
            });
        }

        if (password.length < 8) {
            return res.status(400).json({
                success: false,
                message: "Password must be at least 8 characters",
            });
        }

        const existingUser = await pool.query(
            "SELECT id FROM users WHERE LOWER(email) = $1",
            [email]
        );

        if (existingUser.rows.length > 0) {
            return res.status(409).json({
                success: false,
                message: "Email already registered",
            });
        }

        const otp = crypto.randomInt(100000, 1000000).toString();
        const otpHash = crypto
            .createHash("sha256")
            .update(otp)
            .digest("hex");

        const hashedPassword = await bcrypt.hash(password, 10);

        await pool.query(
            `INSERT INTO pending_registrations
        (firstname, lastname, email, password, otp_hash, expires_at, attempts)
       VALUES ($1, $2, $3, $4, $5, NOW() + INTERVAL '10 minutes', 0)
       ON CONFLICT (email) DO UPDATE SET
         firstname = EXCLUDED.firstname,
         lastname = EXCLUDED.lastname,
         password = EXCLUDED.password,
         otp_hash = EXCLUDED.otp_hash,
         expires_at = EXCLUDED.expires_at,
         attempts = 0,
         created_at = NOW()`,
            [firstname, lastname, email, hashedPassword, otpHash]
        );

        try {
            await sendRegistrationOTP(email, otp);
        } catch (emailError) {
            console.error("OTP EMAIL ERROR:", emailError);

            await pool.query(
                "DELETE FROM pending_registrations WHERE email = $1",
                [email]
            );

            return res.status(500).json({
                success: false,
                message: "Unable to send verification email. Please try again.",
            });
        }

        return res.status(200).json({
            success: true,
            message: "OTP sent to your email. Please verify to complete registration.",
        });
    } catch (error) {
        console.error("REGISTER ERROR:", error);

        return res.status(500).json({
            success: false,
            message: "Registration failed",
        });
    }
};



// // OTP Verification

// export const verifyRegistrationOTP = async (req, res) => {
//     const email = req.body.email?.trim().toLowerCase();
//     const otp = req.body.otp?.trim();

//     try {
//         if (!email || !/^\d{6}$/.test(otp ?? "")) {
//             return res.status(400).json({
//                 success: false,
//                 message: "Valid email and 6-digit OTP are required",
//             });
//         }

//         // const result = await pool.query(
//         //   `SELECT *
//         //    FROM pending_registrations
//         //    WHERE email = $1`,
//         //   [email]
//         // );


//         const result = await pool.query(
//             `SELECT *,
//           (expires_at > NOW()) AS otp_is_valid
//    FROM pending_registrations
//    WHERE email = $1`,
//             [email]
//         );


//         if (result.rows.length === 0) {
//             return res.status(404).json({
//                 success: false,
//                 message: "Registration not found. Please register again.",
//             });
//         }

//         const pending = result.rows[0];

//         if (new Date(pending.expires_at).getTime() <= Date.now()) {
//             await pool.query(
//                 "DELETE FROM pending_registrations WHERE email = $1",
//                 [email]
//             );

//             return res.status(400).json({
//                 success: false,
//                 message: "OTP expired. Please register again.",
//             });
//         }

//         if (pending.attempts >= 5) {
//             return res.status(429).json({
//                 success: false,
//                 message: "Too many attempts. Please register again.",
//             });
//         }

//         const submittedHash = crypto
//             .createHash("sha256")
//             .update(otp)
//             .digest("hex");

//         if (submittedHash !== pending.otp_hash) {
//             await pool.query(
//                 `UPDATE pending_registrations
//          SET attempts = attempts + 1
//          WHERE email = $1`,
//                 [email]
//             );

//             return res.status(400).json({
//                 success: false,
//                 message: "Incorrect OTP",
//             });
//         }

//         const client = await pool.connect();

//         try {
//             await client.query("BEGIN");

//             const userResult = await client.query(
//                 `INSERT INTO users
//           (firstname, lastname, email, password, isadmin)
//          VALUES ($1, $2, $3, $4, $5)
//          RETURNING id, firstname, lastname, email, isadmin`,
//                 [
//                     pending.firstname,
//                     pending.lastname,
//                     pending.email,
//                     pending.password,
//                     "user",
//                 ]
//             );

//             //   await client.query(
//             //     "DELETE FROM pending_registrations WHERE email = $1",
//             //     [email]
//             //   );

//             if (!pending.otp_is_valid) {
//                 await pool.query(
//                     "DELETE FROM pending_registrations WHERE email = $1",
//                     [email]
//                 );

//                 return res.status(400).json({
//                     success: false,
//                     message: "OTP expired. Please register again.",
//                 });
//             }



//             await client.query("COMMIT");

//             return res.status(201).json({
//                 success: true,
//                 message: "Email verified and account created successfully",
//                 user: userResult.rows[0],
//             });
//         } catch (error) {
//             await client.query("ROLLBACK");
//             throw error;
//         } finally {
//             client.release();
//         }
//     } catch (error) {
//         console.error("VERIFY OTP ERROR:", error);

//         if (error.code === "23505") {
//             return res.status(409).json({
//                 success: false,
//                 message: "Email already registered",
//             });
//         }

//         return res.status(500).json({
//             success: false,
//             message: "OTP verification failed",
//         });
//     }
// };





export const verifyRegistrationOTP = async (req, res) => {
  const email = req.body.email?.trim().toLowerCase();
  const otp = req.body.otp?.trim();

  try {
    // 1. Validate request
    if (!email || !/^\d{6}$/.test(otp ?? "")) {
      return res.status(400).json({
        success: false,
        message: "Valid email and 6-digit OTP are required",
      });
    }

    // 2. Get pending registration and check expiry using PostgreSQL
    const result = await pool.query(
      `SELECT *,
              (expires_at > NOW()) AS otp_is_valid
       FROM pending_registrations
       WHERE LOWER(email) = $1`,
      [email]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: "Registration not found. Please register again.",
      });
    }

    const pending = result.rows[0];

    // 3. Check OTP expiry BEFORE inserting user
    if (!pending.otp_is_valid) {
      return res.status(400).json({
        success: false,
        message: "OTP expired. Please register again.",
      });
    }

    // 4. Check attempts
    if (pending.attempts >= 5) {
      return res.status(429).json({
        success: false,
        message: "Too many incorrect attempts. Please register again.",
      });
    }

    // 5. Compare OTP hash
    const submittedHash = crypto
      .createHash("sha256")
      .update(otp)
      .digest("hex");

    if (submittedHash !== pending.otp_hash) {
      await pool.query(
        `UPDATE pending_registrations
         SET attempts = attempts + 1
         WHERE id = $1`,
        [pending.id]
      );

      return res.status(400).json({
        success: false,
        message: "Incorrect OTP",
      });
    }

    // 6. Create user and remove pending registration atomically
    const client = await pool.connect();

    try {
      await client.query("BEGIN");

      // Recheck pending registration inside transaction
      const lockedResult = await client.query(
        `SELECT *,
                (expires_at > NOW()) AS otp_is_valid
         FROM pending_registrations
         WHERE id = $1
         FOR UPDATE`,
        [pending.id]
      );

      if (lockedResult.rows.length === 0) {
        await client.query("ROLLBACK");

        return res.status(404).json({
          success: false,
          message: "Registration not found. Please register again.",
        });
      }

      const lockedPending = lockedResult.rows[0];

      if (!lockedPending.otp_is_valid) {
        await client.query("ROLLBACK");

        return res.status(400).json({
          success: false,
          message: "OTP expired. Please register again.",
        });
      }

      // Insert only after successful OTP verification
      const userResult = await client.query(
        `INSERT INTO users
          (firstname, lastname, email, password, isadmin)
         VALUES ($1, $2, $3, $4, $5)
         RETURNING id, firstname, lastname, email, isadmin`,
        [
          lockedPending.firstname,
          lockedPending.lastname,
          lockedPending.email,
          lockedPending.password,
          "user",
        ]
      );

      // Delete pending record only after successful insert
      await client.query(
        `DELETE FROM pending_registrations
         WHERE id = $1`,
        [lockedPending.id]
      );

      await client.query("COMMIT");

      return res.status(201).json({
        success: true,
        message: "Email verified and account created successfully",
        user: userResult.rows[0],
      });
    } catch (error) {
      await client.query("ROLLBACK");
      throw error;
    } finally {
      client.release();
    }
  } catch (error) {
    console.error("VERIFY OTP ERROR:", error);

    if (error.code === "23505") {
      return res.status(409).json({
        success: false,
        message: "Email already registered",
      });
    }

    return res.status(500).json({
      success: false,
      message: "OTP verification failed",
    });
  }
};




export const login = async (req, res) => {
    try {
        const { email, password } = req.body;

        if (!email || !password) {
            return res.status(400).json({
                success: false,
                message: "Email and password are required",
            });
        }

        const result = await pool.query(
            `SELECT * FROM users WHERE email=$1`,
            [email]
        );

        const user = result.rows[0];
        if (!user) {
            return res.status(400).json({
                success: false,
                message: "User not found",
            });
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(401).json({
                success: false,
                message: "Invalid password",
            });
        }

        const payload = {
            id: user.id,
            email: user.email,
            isadmin: user.isadmin
        };

        const accessToken = jwt.sign(payload, process.env.ACCESS_TOKEN, {
            expiresIn: "2M",
        });

        const refreshToken = jwt.sign(payload, process.env.REFRESH_TOKEN, {
            expiresIn: "7d",
        });

        return res.status(200).json({
            success: true,
            data: {
                accessToken,
                refreshToken,
            }
        })

    } catch (error) {
        return res.status(500).json({
            success: false,
            message: "User login failed!"
        })
    }
}



// ================= REFRESH TOKEN =================
export const refreshAccessToken = async (req, res) => {
    try {
        const { refreshToken } = req.body;

        if (!refreshToken) {
            return res.status(401).json({
                success: false,
                message: "Refresh token required",
            });
        }

        jwt.verify(refreshToken, process.env.REFRESH_TOKEN, (err, decoded) => {
            if (err) {
                return res.status(403).json({
                    success: false,
                    message: "Invalid refresh token",
                });
            }

            const payload = {
                id: decoded.id,
                email: decoded.email,
                isadmin: decoded.isadmin,
            };

            const newAccessToken = jwt.sign(payload, process.env.ACCESS_TOKEN, {
                expiresIn: "2m",
            });

            return res.status(200).json({
                success: true,
                data: {
                    accessToken: newAccessToken,
                    refreshToken,
                },
            });
        });

    } catch (error) {
        return res.status(500).json({
            success: false,
            message: "Internal server error",
        });
    }

}


// export const getUser = async (req, res) => {
//     try {
//         const userData = await pool.query(
//             'SELECT * FROM users'
//         );

//         return res.status(200).json({
//             success: true,
//             data: userData.rows
//         });

//     } catch (error) {
//         console.log(error);

//         return res.status(500).json({
//             success: false,
//             message: "Internal server error",
//         });
//     }
// }

// get user with useing pagination

export const getUser = async (req, res) => {
    try {
        const page = Number(req.query.page) || 1;
        const limit = Number(req.query.limit) || 20;
        const offset = (page - 1) * limit;

        const result = await pool.query(
            `SELECT id, firstname, lastname, email, isadmin
             FROM users
             ORDER BY id DESC
             LIMIT $1 OFFSET $2`,
            [limit, offset]
        );

        return res.status(200).json({
            success: true,
            data: result.rows
        });

    } catch (error) {
        console.log(error);

        return res.status(500).json({
            success: false,
            message: "Internal server error"
        });
    }
};

export const getProfile = async (req, res) => {
    try {
        const userId = req.user.id;

        const result = await pool.query(
            `SELECT id, firstname, lastname, email, isadmin
             FROM users
             WHERE id = $1`,
            [userId]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({
                success: false,
                message: "User not found"
            });
        }

        return res.status(200).json({
            success: true,
            data: result.rows[0]
        });

    } catch (error) {
        console.log(error);

        return res.status(500).json({
            success: false,
            message: "Internal server error"
        });
    }
};

export const logout = async (req, res) => {
    try {
        return res.status(200).json({
            success: true,
            message: "Logout successful",
        });
    } catch (error) {
        return res.status(500).json({
            success: false,
            message: "Logout failed",
        });
    }
};