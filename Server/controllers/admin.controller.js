import bcrypt from "bcrypt";
import dotenv from "dotenv";
import pool from "../config/db.js";
import jwt from "jsonwebtoken";
dotenv.config();


export const registerUser = async (req, res) => {
    const { firstname, lastname, email, password, isadmin } = req.body;
    try {
        if (!firstname || !lastname || !email || !password) {
            return res.status(400).json({
                success: false,
                message: "All field is required",
            })
        }

        const hashpassword = await bcrypt.hash(password, 10);

        const result = await pool.query(
            `INSERT INTO users 
            (firstname, lastname, email, password, isadmin)
            VALUES ($1,$2,$3,$4,$5)
            RETURNING id, firstname, lastname, email, isadmin`,
            [
                firstname,
                lastname,
                email,
                hashpassword,
                isadmin || "User",
            ]
        );
        return res.status(200).json({
            success: true,
            user: result.rows[0]
        })

    } catch (error) {
        return res.status(500).json({
            success: false,
            message: "User register failed!"
        })
    }
}

export const loign = async (req, res) => {
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
            id : user.id,
            email : user.email,
            isadmin : user.isadmin
        };

        const accessToken = jwt.sign(payload, process.env.ACCESS_TOKEN, {
            expiresIn: "5M",
        }); 

        const refreshToken = jwt.sign(payload, process.env.REFRESH_TOKEN, {
            expiresIn: "7d",
        }); 

        return res.status(200).json({
            success: true,
            data : {
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
        expiresIn: "15m",
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
};
