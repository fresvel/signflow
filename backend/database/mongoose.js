import mongoose from "mongoose";

try {
    await mongoose.connect(process.env.URI_MONGO)
    console.log("✅ Connected to MongoDB")
} catch (error) {
    console.error("Database: Error connecting to MongoDB", error)
}