/*
  Warnings:

  - Added the required column `topicId` to the `Idea` table without a default value. This is not possible if the table is not empty.
  - Made the column `userId` on table `IdeaList` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "IdeaList" DROP CONSTRAINT "IdeaList_userId_fkey";

-- AlterTable
ALTER TABLE "Idea" ADD COLUMN     "topicId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "IdeaList" ALTER COLUMN "userId" SET NOT NULL;

-- CreateTable
CREATE TABLE "Topic" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Topic_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Topic_name_key" ON "Topic"("name");

-- AddForeignKey
ALTER TABLE "Idea" ADD CONSTRAINT "Idea_topicId_fkey" FOREIGN KEY ("topicId") REFERENCES "Topic"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IdeaList" ADD CONSTRAINT "IdeaList_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
