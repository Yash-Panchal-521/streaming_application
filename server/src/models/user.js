import mongoose from "mongoose";
import channel from "./channel";

const { Schema } = mongoose;

const userSchema = new Schema({
  email: { type: String, unique: true },
  password: { type: String },
  username: { type: String },
  channels: [{ type: Schema.Types.ObjectId, ref: "Channel" }],
  followedChannels: [{ type: Schema.Types.ObjectId, ref: "Channel" }],
});

export default mongoose.model("User", userSchema);
