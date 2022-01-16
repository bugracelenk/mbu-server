const express = require("express");
const app = express();
const cors = require("cors");
const R = require("r-script");

const router = express.Router();
router.get("/calculatewq", async (req, res, next) => {
  const { maxMachineCount, lambda, mue } = req.query;
  console.log({ maxMachineCount, lambda, mue });
  R("./r/ex-async.R")
    .data({
      maxMachineCount: parseInt(maxMachineCount),
      Lambda: parseInt(lambda),
      Mue: parseInt(mue),
    })
    .call((err, d) => {
      console.log(d);
      if (err) return res.status(500).json(err);
      return res.status(200).json(d);
    });
});

app.use(cors());
app.use("/", router);

app.use(function (err, req, res, next) {
  console.error(err.stack);
  return res.status(500).json({ err });
});

module.exports = app;
