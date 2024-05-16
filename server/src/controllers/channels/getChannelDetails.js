import User from "../../models/user.js";
import Channel from "../../models/channel.js";


export const getChannelDetails = async (req, res) => {
    
    try {
        const { channelId } = req.params;
        const channel = await Channel.findById(channelId);

        if (!channel || !channelId.isOnline) {
            return res.status(404).send("Channel not found");
        }

        const user = await User.findOne({ channel: channelId }, {username: 1});

        const streamUrl = 'http';

        const isOnline = false;

        return res.status(200).json({
            id: channel._id,
            title: channel.title,
            description: channel.description,
            username: user.username,
            isOnline,
            streamUrl,
        });

    } catch (err) {
        console.log(`Error oocured: ${err}`);
        return res.status(500).send(`Error oocured: ${err}`);
    }
    return res.status(200).json({
        id: "1",
        title: "Channel 1",
        description: "This is channel 1",
        username: "user1",
        isOnline: true,
        streamUrl: "http://localhost:3000/stream/1",
    });
}