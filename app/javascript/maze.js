document.addEventListener("turbo:load", function () {
  if (document.body.getAttribute('data-controller') !== 'maze-show') {
    return;
  }
  console.log('DOM loaded');
  const grid = JSON.parse(document.getElementById('maze-container').dataset.grid);
  const solution = JSON.parse(document.getElementById('maze-container').dataset.solution);
  const container = document.getElementById('maze-container');
  const toggleButton = document.getElementById('toggle-solution-button');

  function renderMaze(container, grid) {
    console.log("RENDER MAZE")
    container.innerHTML = ''; // Clear previous content
    grid.forEach((row, i) => {
      row.forEach((cell, j) => {
        const div = document.createElement('div');
        div.classList.add('maze-cell');

        if (i === 1 && j === 1) {
          div.classList.add('start');
        } else if (i === grid.length - 2 && j === row.length - 2) {
          div.classList.add('end');
        } else if (cell === 1) {
          div.classList.add('wall');
        } else if (cell === 0) {
          div.classList.add('path');
        } else {
          div.classList.add('solution');
        }

        container.appendChild(div);
      });
    });
  }

  renderMaze(container, grid);

  toggleButton.addEventListener('click', function() {
    if (!container.classList.contains('solved')) {
      console.log("try to show solution")
      console.log("my solution", solution)
      renderMaze(container, solution);
      container.classList.add('solved');
      toggleButton.textContent = 'Hide Solution';
    } else {
      renderMaze(container, grid);
      container.classList.remove('solved');
      toggleButton.textContent = 'Show Solution';
    }
  });
});
