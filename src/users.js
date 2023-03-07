import { dateToString } from "./converter";

const users = [
  {
    id: 1,
    name: "Martin",
    picture: 2,
    email: "KreMa914@school.lu",
    visibleInterests: [1,2],
    visibleAchievements: [1, 2, 3, 4, 5],
    joined: dateToString(new Date()),
    progress: [
      {
        fiInterest: 1,
        progress: 40,
        today: 8,
      },
      {
        fiInterest: 2,
        progress: 3000,
        today: 1500,
      },
    ],
  },
];

export default users;
