import User from '../../models/user.js';

export const postFollowChannel = async (req, res) => {
    try {
        const { userId } = req.user;
        const { channelId } = req.body;

        const userData = await User.findById(userId, { followedChannels: 1 });

        if (userData.followedChannels.includes(channelId)) {
            return res.status(400).send("Channel already followed");
        }
        else{
            userData.followedChannels.push(channelId);
            await userData.save();
            return res.status(200).send("Channel followed successfully");
        }
    }
    catch (err) {
        console.log(`Error oocured: ${err}`);
        return res.status(500).send(`Error oocured: ${err}`);
    }
}