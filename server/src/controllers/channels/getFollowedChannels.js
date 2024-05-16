import User from "../../models/user.js";
export const getFollowedChannels = async (req, res) => {
    try {
        const { userId } = req.user;
        const userData = await User.findById(userId, { followedChannels: 1 });
        return res.status(200).json(userData);
    }
    catch (err) {
        console.log(`Error oocured: ${err}`);
        return res.status(500).send(`Error oocured: ${err}`);
    }
}
