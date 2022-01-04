const mongoose = require('mongoose')
const Schema = mongoose.Schema
const ClientSchema = new Schema({
    brand: { type: String },
    processor: { type: String },
    ram: { type: String },
    vga: { type: String },
    hardisk: { type: String },
    harga: { type: String},
    date: { type: Date, default: Date.now }

})
module.exports = mongoose.model('laptop', ClientSchema)