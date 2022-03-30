/*
  Warnings:

  - You are about to drop the `myEpisodesPlaylist` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `myShowsList` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `myTopicsList` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `mediaProvider` on the `myLikedShows` table. All the data in the column will be lost.
  - You are about to drop the column `title` on the `myLikedShows` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Topic` table. All the data in the column will be lost.
  - You are about to drop the column `author` on the `myLikedEpisodes` table. All the data in the column will be lost.
  - You are about to drop the column `title` on the `myLikedEpisodes` table. All the data in the column will be lost.
  - You are about to alter the column `episodeId` on the `myLikedEpisodes` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - You are about to alter the column `userId` on the `myLikedEpisodes` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - You are about to drop the column `userId` on the `Show` table. All the data in the column will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "myEpisodesPlaylist";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "myShowsList";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "myTopicsList";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "ShowPlaylist" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    CONSTRAINT "ShowPlaylist_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "EpisodePlaylist" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    CONSTRAINT "EpisodePlaylist_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_TopicToUser" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    FOREIGN KEY ("A") REFERENCES "Topic" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("B") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_ShowToUser" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    FOREIGN KEY ("A") REFERENCES "Show" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("B") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_ShowToShowPlaylist" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    FOREIGN KEY ("A") REFERENCES "Show" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("B") REFERENCES "ShowPlaylist" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_EpisodeToEpisodePlaylist" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    FOREIGN KEY ("A") REFERENCES "Episode" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("B") REFERENCES "EpisodePlaylist" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_myLikedShows" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "showId" INTEGER NOT NULL,
    CONSTRAINT "myLikedShows_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "myLikedShows_showId_fkey" FOREIGN KEY ("showId") REFERENCES "Show" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_myLikedShows" ("id", "showId", "userId") SELECT "id", "showId", "userId" FROM "myLikedShows";
DROP TABLE "myLikedShows";
ALTER TABLE "new_myLikedShows" RENAME TO "myLikedShows";
CREATE TABLE "new_Episode" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "showId" INTEGER NOT NULL,
    "numberOfEpisode" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "author" TEXT NOT NULL,
    "description" TEXT,
    "url" TEXT NOT NULL,
    "dateAdded" TEXT NOT NULL,
    "length" INTEGER,
    "numberOfLikes" INTEGER NOT NULL,
    "numberOfDislikes" INTEGER NOT NULL,
    "userId" INTEGER,
    CONSTRAINT "Episode_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Episode_showId_fkey" FOREIGN KEY ("showId") REFERENCES "Show" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Episode" ("author", "dateAdded", "description", "id", "length", "numberOfDislikes", "numberOfEpisode", "numberOfLikes", "showId", "title", "url", "userId") SELECT "author", "dateAdded", "description", "id", "length", "numberOfDislikes", "numberOfEpisode", "numberOfLikes", "showId", "title", "url", "userId" FROM "Episode";
DROP TABLE "Episode";
ALTER TABLE "new_Episode" RENAME TO "Episode";
CREATE TABLE "new_Topic" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);
INSERT INTO "new_Topic" ("id", "name") SELECT "id", "name" FROM "Topic";
DROP TABLE "Topic";
ALTER TABLE "new_Topic" RENAME TO "Topic";
CREATE TABLE "new_myLikedEpisodes" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "episodeId" INTEGER NOT NULL,
    CONSTRAINT "myLikedEpisodes_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "myLikedEpisodes_episodeId_fkey" FOREIGN KEY ("episodeId") REFERENCES "Episode" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_myLikedEpisodes" ("episodeId", "id", "userId") SELECT "episodeId", "id", "userId" FROM "myLikedEpisodes";
DROP TABLE "myLikedEpisodes";
ALTER TABLE "new_myLikedEpisodes" RENAME TO "myLikedEpisodes";
CREATE TABLE "new_Show" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "topicId" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "mediaProvider" TEXT,
    CONSTRAINT "Show_topicId_fkey" FOREIGN KEY ("topicId") REFERENCES "Topic" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Show" ("id", "mediaProvider", "title", "topicId") SELECT "id", "mediaProvider", "title", "topicId" FROM "Show";
DROP TABLE "Show";
ALTER TABLE "new_Show" RENAME TO "Show";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "_TopicToUser_AB_unique" ON "_TopicToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_TopicToUser_B_index" ON "_TopicToUser"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ShowToUser_AB_unique" ON "_ShowToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_ShowToUser_B_index" ON "_ShowToUser"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ShowToShowPlaylist_AB_unique" ON "_ShowToShowPlaylist"("A", "B");

-- CreateIndex
CREATE INDEX "_ShowToShowPlaylist_B_index" ON "_ShowToShowPlaylist"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_EpisodeToEpisodePlaylist_AB_unique" ON "_EpisodeToEpisodePlaylist"("A", "B");

-- CreateIndex
CREATE INDEX "_EpisodeToEpisodePlaylist_B_index" ON "_EpisodeToEpisodePlaylist"("B");
