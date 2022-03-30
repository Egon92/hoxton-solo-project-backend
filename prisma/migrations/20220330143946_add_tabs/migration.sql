-- CreateTable
CREATE TABLE "Topic" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "name" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Show" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "topicId" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "mediaProvider" TEXT
);

-- CreateTable
CREATE TABLE "Episode" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "showId" INTEGER NOT NULL,
    "numberOfEpisode" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "author" TEXT NOT NULL,
    "description" TEXT,
    "url" TEXT NOT NULL,
    "dateAdded" TEXT NOT NULL,
    "length" INTEGER,
    "numberOfLikes" INTEGER NOT NULL,
    "numberOfDislikes" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "myShowsList" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "showId" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "myTopicsList" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "topicId" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "myEpisodesPlaylist" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "episodeId" INTEGER NOT NULL,
    "title" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "myLikedShows" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "showId" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "mediaProvider" TEXT
);

-- CreateTable
CREATE TABLE "myLikedEpisodes" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" TEXT NOT NULL,
    "episodeId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "author" TEXT
);
