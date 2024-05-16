import mongoose from 'mongoose';

const { Schema } = mongoose;

const messageSchema = new Schema({
    author: { type: String, required: true },
    content: { type: String, required: true },
    date: { type: Date},
})

export default mongoose.model('Message', messageSchema);