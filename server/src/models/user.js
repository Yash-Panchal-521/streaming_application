import mongoose from "mongoose";

const { Schema } = mongoose;

const userSchema = new Schema({
  email: { type: String, unique: true },
  password: { type: String },
  username: { type: String },
});

export default mongoose.model("User", userSchema);
