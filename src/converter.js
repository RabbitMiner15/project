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

export const getProgress = (interest, progress, startDate, endDate) => {
  let result = 0;

  switch (interest) {
    case 1:
    case 2:
    case 4:
    case 12:
    case 13:
      if (progress[interest]) {
        if (!startDate) {
          result = sum(interest, progress);
        } else {
          const startTimeStamp = new Date(startDate).getTime();
          const endTimeStamp = new Date(endDate).getTime();
          if (progress.hasOwnProperty(interest)) {
            progress[interest].values.forEach((entry) => {
              const timeStamp = new Date(entry.timestamp).getTime();
              if (timeStamp >= startTimeStamp && timeStamp <= endTimeStamp) {
                result += entry.value;
                console.log(result);
              }
            });
          }
        }
      }
      break;
    case 3:
    case 6:
      if (progress[interest]) {
        if (!startDate) {
          result = sum(interest, progress) / progress[interest].values.length;
        } else {
          length = 0;
          const startTimeStamp = new Date(startDate).getTime();
          const endTimeStamp = new Date(endDate).getTime();
          if (progress.hasOwnProperty(interest)) {
            progress[interest].values.forEach((entry) => {
              const timeStamp = new Date(entry.timestamp).getTime();

              if (timeStamp >= startTimeStamp && timeStamp <= endTimeStamp) {
                result += entry.value;
                length++;
              }
            });
          }
          if (length > 0) {
            result = result / length;
          }
        }
      }
      break;
    case 5:
    case 7:
    case 8:
    case 9:
    case 10:
    case 11:
      if (progress[result]) {
        if (!startDate) {
          result = progress[interest].values.slice(-1);
        } else {
        }
      }
      break;
    default:
      result = "error";
      break;
  }
  return result;
};
