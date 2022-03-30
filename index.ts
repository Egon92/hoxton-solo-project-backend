import express, { application } from "express";
import cors from "cors";
import { PrismaClient } from "@prisma/client";

const app = express();
app.use(cors());
app.use(express.json());
const PORT = 4000;
const prisma = new PrismaClient();

app.get("/users", async (req, res) => {
  const users = await prisma.user.findMany({
    include: {
      showPlaylists: true,
      episodePlaylists: { include: { episodes: true } },
    },
  });
  res.send(users);
});

app.post("/users", async (req, res) => {
  const newUser = await prisma.user.create({
    data: {
      firstname: req.body.firstname,
      lastname: req.body.lastname,
      username: req.body.username,
      country: req.body.country,
      email: req.body.email,
      password: req.body.password,
    },
  });
  res.send(newUser);
});

app.listen(PORT, () => {
  console.log(`Server is listening at http://localhost:${PORT}`);
});
