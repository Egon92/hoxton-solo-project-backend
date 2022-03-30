-- CreateTable
CREATE TABLE "User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "fistname" TEXT,
    "lastname" TEXT,
    "username" TEXT NOT NULL,
    "country" TEXT DEFAULT 'Albania',
    "profilePic" TEXT DEFAULT 'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL
);
