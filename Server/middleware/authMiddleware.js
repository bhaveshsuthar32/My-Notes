import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

export const authMiddleware = (req, res, next) => {
    try {
        // Authorization header check
        const authHeader = req.headers.authorization;

        if (!authHeader) {
            return res.status(401).json({
                success: false,
                message: "Authorization token required",
            });
        }

        // Expected:
        // Authorization: Bearer <token>

        const parts = authHeader.split(" ");

        if (parts.length !== 2 || parts[0] !== "Bearer") {
            return res.status(401).json({
                success: false,
                message: "Invalid authorization format",
            });
        }

        const token = parts[1];

        // Verify access token
        const decoded = jwt.verify(
            token,
            process.env.ACCESS_TOKEN
        );

        // Store logged-in user information
        req.user = decoded;

        next();

    } catch (error) {
        console.error("AUTH MIDDLEWARE ERROR:", error.message);

        if (error.name === "TokenExpiredError") {
            return res.status(401).json({
                success: false,
                message: "Access token expired",
            });
        }

        if (error.name === "JsonWebTokenError") {
            return res.status(401).json({
                success: false,
                message: "Invalid access token",
            });
        }

        return res.status(500).json({
            success: false,
            message: "Authentication failed",
        });
    }
};