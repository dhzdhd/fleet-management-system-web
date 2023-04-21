import express from "express";
import { createPool, getConnection, Pool } from "oracledb";
import cors from "cors";
import fs from "fs/promises";

const app = express();
const port = 3000;

app.use(cors());

let pool: Pool;

async function initDb() {
  try {
    pool = await createPool({
      user: "system",
      password: "lolxd5",
      connectionString: "localhost/deep",
    });

    let conn = await pool.getConnection();

    const data = await fs.readFile("sql/create_table.sql", {
      encoding: "utf8",
    });
    const commands = data.split(";");

    for (let i = 0; i < commands.length - 1; i++) {
      try {
        conn.execute(commands[i]);
      } catch (e) {
        console.log("Table already created");
      }
    }

    await conn.close();
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
