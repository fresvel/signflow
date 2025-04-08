import cors from "cors"
import express from 'express';
import "dotenv/config"

import "./database/mongoose.js"
import "./database/mariadb.js"

const app = express();
const port = process.env.PORT || 3000;

const whitelist =[process.env.ORIGIN1,process.env.ORIGIN2]

app.use(cors({
    origin: (origin, callback)=>{
        console.log("Starting cors")
        console.log("New connection, origin: " + origin)
        if (!origin|| whitelist.includes(origin)){
            return callback(null, origin)
        }
        return callback("Cors error: Origin not allowed:" + origin)
    },
    credentials: true
}));

app.get('/', (req, res) => {
  res.send('Hello from Flusvel Backend!');
});

//app.use("/reports",)

app.use(express.static("public"));


app.use((req, res)=>{
    res.status(404).send("Page not found")  // 404 Not Found Handler
})
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});