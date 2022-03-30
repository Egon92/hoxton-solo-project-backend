/*
  Warnings:

  - You are about to drop the column `fistname` on the `User` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "firstname" TEXT,
    "lastname" TEXT,
    "username" TEXT NOT NULL,
    "country" TEXT DEFAULT 'Albania',
    "profilePic" TEXT DEFAULT 'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL
);
INSERT INTO "new_User" ("country", "email", "id", "lastname", "password", "profilePic", "username") SELECT "country", "email", "id", "lastname", "password", "profilePic", "username" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
