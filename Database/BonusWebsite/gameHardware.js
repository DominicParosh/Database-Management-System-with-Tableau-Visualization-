document.addEventListener('DOMContentLoaded', function() {
    fetch('http://localhost:5000/game-hardware')
    .then(response => response.json())
    .then(data => {
        const hardwareContainer = document.getElementById('hardware-container');
        data.forEach(game => {
            let div = document.createElement('div');
            div.innerHTML = `<h3>${game.name}</h3>
                             <p>Price: ${game.price}</p>
                             <p>Platform: ${game.platform}</p>
                             <p>OS: ${game.operational_system}</p>
                             <p>Processor: ${game.processor}</p>
                             <p>Memory: ${game.memory}</p>
                             <p>Graphics: ${game.graphics}</p>`;
            hardwareContainer.appendChild(div);
        });
    })
    .catch(error => console.error('Error:', error));
});
