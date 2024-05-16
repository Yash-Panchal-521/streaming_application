import mongoose from "mongoose";
import channel from "./channel.js";

const { Schema } = mongoose;

const userSchema = new Schema({
  email: { type: String, unique: true },
  password: { type: String },
  username: { type: String },
  channel: { type: Schema.Types.ObjectId, ref: "Channel" },
  followedChannels: [{ type: Schema.Types.ObjectId, ref: "Channel" }],
});

export default mongoose.model("User", userSchema);
