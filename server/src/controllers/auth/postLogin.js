import User from "../../models/user.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";

export const postLogin = async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({
      email: email,
    });

    if(!user) return res.status(400).send("User not found. Please register.");

    if (user && (await bcrypt.compare(password, user.password))) {
      const token = jwt.sign(
        {
          userId: user._id,
          email: user.email,
        },
        process.env.TOKEN_KEY,
        {
          expiresIn: "2h",
        }
      );

      return res.status(200).json({
        userDetails: {
          email: user.email,
          username: user.username,
          token,
        },
      });
    }

    return res.status(400).send("Invalid Credentials. Please try again.");
  } catch (err) {
    return res.status(500).send(`Error occured: ${err}`);
  }
};
