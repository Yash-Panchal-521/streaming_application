import express from "express";

const router = express.Router();

router.post("/register", (req, res) => {
    return res.send("This is register route");
});

router.post("/login", (req, res) => {
    return res.send("This is login route");
});


export default router;
