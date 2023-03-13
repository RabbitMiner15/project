export const daysUntil = (date) => {
  const today = new Date();
  const deadline = new Date(date);
  const diff = Math.ceil(
    (deadline.getTime() - today.getTime()) / (1000 * 60 * 60 * 24)
  );
  return diff;
};

export const dateToString = (date) => {
  const deadline = new Date(date);
  const month = deadline.toLocaleString("en-us", { month: "long" });
  const day = deadline.getDate();
  const year = deadline.getFullYear();
  return `${month} ${day}, ${year}`;
};

const sum = (interest, progress) => {
  return progress[interest].values.reduce((partialSum, a) => partialSum + a, 0);
};

export const getProgress = (interest, progress) => {
  let result = 0;
  switch (interest) {
    case 1:
    case 2:
    case 4:
    case 12:
    case 13:
      if (progress[interest]) {
        result = sum(interest, progress);
      }
      break;
    case 3:
    case 6:
      if (progress[interest]) {
        result = sum(interest, progress) / progress[interest].values.length;
      }
      break;
    case 5:
    case 7:
    case 8:
    case 9:
    case 10:
    case 11:
      if (progress[result]) {
        result = progress[interest].values.slice(-1);
      }
      break;
    default:
      result = "error";
      break;
  }
  return result;
};
