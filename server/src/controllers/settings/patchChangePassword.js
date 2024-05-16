import User from "../../models/user.js";
import bcrypt from "bcryptjs";

export const patchChangePassword = async (req, res) => {
    try {
        const { userId } = req.user;
        const { password, newPassword } = req.body;

        const userData = await User.findById(userId, { password: 1 });

        if (await bcrypt.compare(password, userData.password) === false){
            return res.status(400).send("Invalid password");
        }

        const hashedPassword =await bcrypt.hash(newPassword, 10);

        await User.updateOne({ _id: userId }, { password: hashedPassword });

        return res.status(200).send("Password changed successfully");
    }
    catch (err) {
        console.log(`Error oocured: ${err}`);
        return res.status(500).send(`Error oocured: ${err}`);
    }
}