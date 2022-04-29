import { PrismaClient } from "@prisma/client";
import bcrypt from "bcrypt";
import { topicsData } from "./topicsData";

const prisma = new PrismaClient();

const run = async () => {
	await Promise.all(
		topicsData.map(async (topic) => {
			return prisma.topic.upsert({
				where: {name: topic.name},
				update: {},
				create: {
					name: topic.name,
					ideas: {
						create: topic.ideas.map(idea => ({
							name: idea.name,
						}))
					}
				}
			})
		})
	})
};

run()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
