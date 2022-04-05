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

app.post("/signup", async (req, res) => {
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
app.get("/topics", async (req, res) => {
  const topics = await prisma.topic.findMany({
    include: {
      shows: true,
      users: { include: { episodes: true } },
    },
  });
  res.send(topics);
});
app.post("/topics", async (req, res) => {
  const newTopic = await prisma.topic.create({
    data: {
      name: req.body.name,
    },
  });
  res.send(newTopic);
});
app.delete("/topics", async (req, res) => {
  const deletedTopic = await prisma.topic.delete({
    where: { id: 5 },
  });
  res.send(deletedTopic);
});
app.post("/shows", async (req, res) => {
  const newShow = await prisma.show.create({
    data: {
      topicId: req.body.topicId,
      title: req.body.title,
      mediaProvider: req.body.mediaProvider,
    },
  });
  res.send(newShow);
});
app.get("/shows", async (req, res) => {
  const shows = await prisma.show.findMany();
  res.send(shows);
});
app.post("/login", async (req, res) => {
  //Check if the username exists
  const user = await prisma.user.findFirst({
    where: { username: req.body.username },
  });
  if (user) {
    //Check if the password matches the user's password
    if (user.password === req.body.password) {
      res.send(user);
    } else {
      res.status(400).send({ error: "password not correct!" });
    }
  } else {
    res.status(400).send({ error: "user not found" });
  }
});
app.listen(PORT, () => {
  console.log(`Server is listening at http://localhost:${PORT}`);
});
