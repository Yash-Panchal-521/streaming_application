import Channel from "../../models/channel.js";
import User from "../../models/user.js";

export const putChannelSettings = async (req, res) => {
    try{
        const { userId } = req.user;
        const { title, description, username, avatarUrl} = req.body;

        const userData = await User.findById(userId, {"username": 1, "channel": 1});

        if (userData.username !== username) {
            await User.updateOne({_id: userId}, {username});
        }

        const channelData = await Channel.findByIdAndUpdate(userData.channel._id, {
            title,
            description,
            avatarUrl,
            isActive: true
        }, {new: true});

        return res.status(200).json({
            channelId: channelData._id,
            username: userData.username,
            title: channelData.title,
            description: channelData.description,
            avatarUrl: channelData.avatarUrl,
        });
    }
    catch (err) {
        console.log(`Error oocured: ${err}`);
        return res.status(500).send(`Error oocured: ${err}`);
    }
}