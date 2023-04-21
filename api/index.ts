import express from "express";
import { createPool, getConnection, Pool } from "oracledb";
import cors from "cors";

const app = express();
const port = 3000;

app.use(cors());

let pool: Pool;

async function initDb() {
  try {
    pool = await createPool({
      user: "system",
      password: "lolxd5",
      connectionString: "ORACLE-SERVER/mcaorcl",
    });

    let conn = await pool.getConnection();
  } catch (err) {
    console.error(err.message);
  }
}

app.route("/api/tables").get(async (req, res) => {
  let conn = await pool.getConnection();
  conn.execute(`SELECT * FROM vehicle`);
});

app.get("/", (req, res) => {
  res.send("Test endpoint");
});

initDb();
app.listen(port, () => {
  console.log(`App listening on http://localhost:${port}`);
});
