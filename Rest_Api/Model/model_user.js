const mongoose = require('mongoose')
const Schema = mongoose.Schema
const UserSchema = new Schema({
    username: { type: String, required: true},
    namaLengkap: { type: String },
    email: { type: String, required: true,unique: true,lowercase: true, },
    password: { type: String, required: true },
    date: { type: Date, default: Date.now }

})
module.exports = mongoose.model('user', UserSchema)