const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

// Swap arr[0] and arr[ind] elements, swap by link on array
const swapElement = (arr, ind) => {
  // eslint-disable-next-line
  [arr[0], arr[ind]] = [arr[ind], arr[0]]

  return arr;
};

// Sort function, sort by link on array
const arraySort = (arr) => {
  for (let i = 0; i < arr.length; i += 1) {
    // find max element in subarray between 0 and n - i and place it in arr[0]
    let j = 1;
    for (; j < arr.length - i; j += 1) {
      if (arr[0] < arr[j]) {
        swapElement(arr, j);
      }
    }

    swapElement(arr, j - 1);
  }
};

rl.question('Enter numbers of array in format: 1 2 3\n', (input) => {
  // Filter empty substrings in case of their appearance, explicitly convert strings to numbers
  const arr = input.split(' ').filter((char) => {
    if (char === '' || char === ' ') {
      return false;
    }

    return true;
  }).map(Number);

  arraySort(arr);
  console.log(arr);

  rl.close();
});
