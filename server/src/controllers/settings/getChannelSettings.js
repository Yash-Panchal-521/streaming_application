import channel from "../../models/channel.js";
import User from "../../models/user.js";
import { get } from "mongoose";

export const getChannelSettings = async (req, res) => {

    try {
        const { userId } = req.user;

        const userData = await User.findById(userId, {
            channel: 1,
            username: 1
        }).populate("channel");

        return res.status(200).json({
            id: userData.channel._id,
            username: userData.username,
            title: userData.channel.title,
            description: userData.channel.description,
            avatarUrl: userData.channel.avatarUrl,
            streamKey: userData.channel.streamKey
        });
    }
    catch (err) {
        console.log(`Error oocured: ${err}`);
        return res.status(500).send(`Error oocured: ${err}`);
    }
}