import nodemailer from "nodemailer";
import dotenv from "dotenv";
dotenv.config();

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

export const sendRegistrationOTP = async (email, otp) => {
  await transporter.sendMail({
    from: `"My Notebook" <${process.env.EMAIL_USER}>`,
    to: email,
    subject: "Verify your My Notebook account",
    text: `Your verification code is ${otp}. It expires in 10 minutes.`,
    html: `
      <div style="font-family: Arial, sans-serif; padding: 20px;">
        <h2>My Notebook - Email Verification</h2>
        <p>Use the following OTP to verify your email:</p>
        <h1 style="letter-spacing: 8px;">${otp}</h1>
        <p>This OTP expires in 10 minutes.</p>
        <p>If you did not request this, ignore this email.</p>
      </div>
    `,
  });
};