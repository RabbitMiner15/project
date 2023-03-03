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
