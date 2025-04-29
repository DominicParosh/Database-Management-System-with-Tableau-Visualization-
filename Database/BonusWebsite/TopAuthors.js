document.addEventListener('DOMContentLoaded', function() {
    fetch('http://localhost:5000/top-authors')
    .then(response => response.json())
    .then(authors => {
        const authorsTable = document.getElementById('authors-table');
        authors.forEach(author => {
            let row = authorsTable.insertRow(-1);
            let cell1 = row.insertCell(0);
            let cell2 = row.insertCell(1);
            cell1.textContent = author.author;
            cell2.textContent = author.comment_count;
        });
    })
    .catch(error => console.error('Error:', error));
});
