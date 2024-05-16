import User from "../../models/user.js";


export const getChannels = async (req, res) => {    

    try {
        const users = await User.find({}, {channel: 1, username: 1}).populate("channel");

        const channels = users
        .filter(user => user.channel.isActive)
        .map(user => {
            return {
                id: user.channel._id,
                title: user.channel.title,
                avatarUrl: user.channel.avatarUrl,
                username: user.username,
                isOnline: false,
            }
        });
        return res.status(200).json({channels});
    } catch (err) {
        console.log(`Error oocured: ${err}`);
        return res.status(500).send(`Error oocured: ${err}`);
    }

}

