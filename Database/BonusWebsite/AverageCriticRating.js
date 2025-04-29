document.addEventListener('DOMContentLoaded', function() {
    fetch('http://localhost:5000/average-ratings')
    .then(response => response.json())
    .then(data => {
        const ratingstable = document.getElementById('game-ratings-table');
        data.forEach(game => {
            let row = ratingstable.insertRow(-1);
            let cell1 = row.insertCell(0);
            let cell2 = row.insertCell(1);
            cell1.textContent = game.name;
            cell2.textContent = game.average_rating;
        });
    })
    .catch(error => console.error('Error:', error));
});