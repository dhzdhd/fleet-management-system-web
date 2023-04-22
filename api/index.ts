import express from "express";
import odb from "oracledb";
import type { Pool } from "oracledb";
import cors from "cors";
import { promises as fs } from "fs";
import bodyParser from "body-parser";

const app = express();
const port = 3000;

app.use(express.json());
app.use(cors());

let pool: Pool;

async function initDb() {
  try {
    pool = await odb.createPool({
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
        await conn.execute(`${commands[i]}`);
      } catch (e) {
        console.log("Table already created");
      }
    }

    await conn.close();
  } catch (err) {
    console.error(err);
  }
}

app
  .route("/api/tables/:id")
  .get(async (req, res) => {
    let conn = await pool.getConnection();

    let data = await conn.execute(`SELECT * FROM ${req.params.id}`);
    res.send(data);

    await conn.close();
  })
  .post(async (req, res) => {
    let conn = await pool.getConnection();
    let values: string[] = req.body.data;

    console.log(`INSERT INTO ${req.params.id} VALUES(${values.join(",")})`);

    let data = await conn.execute(
      `INSERT INTO ${req.params.id} VALUES(${values
        .map((_, i) => `:${i}`)
        .join(",")})`,
      values
    );
    res.send(data);

    await conn.commit();
    await conn.close();
  })
  .patch(async (req, res) => {});

app.get("/", (req, res) => {
  res.send("Test endpoint");
});

await initDb();
app.listen(port, () => {
  console.log(`App listening on http://localhost:${port}`);
});
