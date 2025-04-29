fetch('http://localhost:5000/most-followed-twitter')
.then(response => response.json())
.then(accounts => {
    const table = document.getElementById('twitter-accounts-table');
    accounts.forEach(account => {
        let row = table.insertRow(-1);
        let cell1 = row.insertCell(0);
        let cell2 = row.insertCell(1); 

        cell1.textContent = account.username; 
        cell2.textContent = account.followers.toLocaleString(); 
    });
})
.catch(error => console.error('Error:', error));