import express, { application } from "express";
import cors from "cors";
import { PrismaClient } from "@prisma/client";

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.static("public"));
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
app.get("/episodes", async (req, res) => {
  const episodes = await prisma.episode.findMany();
  res.send(episodes);
});
app.post("/episodes", async (req, res) => {
  const newEpisode = await prisma.episode.create({
    data: {
      showId: req.body.showId,
      numberOfEpisode: req.body.numberOfEpisode,
      title: req.body.title,
      author: req.body.author,
      description: req.body.description,
      url: req.body.url,
      dateAdded: req.body.dateAdded,
      length: req.body.length,
      numberOfLikes: req.body.numberOfLikes,
      numberOfDislikes: req.body.numberOfDislikes,
    },
  });
  res.send(newEpisode);
});
app.patch("/episodes/:id", async (req, res) => {
  const id = Number(req.params.id);
  const episode = await prisma.episode.update({
    where: { id },
    data: { url: req.body.url },
  });
  res.send(episode);
});
app.listen(PORT, () => {
  console.log(`Server is listening at http://localhost:${PORT}`);
});
