import User from "../../models/user.js";
import Channel from "../../models/channel.js";
import bcrpyt from "bcryptjs";
import jwt from "jsonwebtoken";

export const postRegister = async (req, res) => {
  try {
    const { username, email, password } = req.body;

    const userExists = await User.exists({ email });

    if (userExists) {
      return res.status(409).send("User already exists");
    }

    const encryptedPassword = await bcrpyt.hash(password, 10);
    const newChannel = await Channel.create({ });

    const user = await User.create({
      username,
      email: email.toLowerCase(),
      password: encryptedPassword,
      channel: newChannel._id,
      followedChannels: [],
    });

    const token = jwt.sign(
      {
        userId: user._id,
        email,
      },
      process.env.TOKEN_KEY,
      {
        expiresIn: "2h",
      }
    );

    return res.status(200).json({
      userDetails: {
        email,
        username,
        token,
      },
    });
  } catch (err) {
    console.log(`Error oocured: ${err}`);
    return res.status(500).send(`Error oocured: ${err}`);
  }

};
