

function populateTable(users) {
    const tbody = document.querySelector("table tbody");
    tbody.innerHTML = ""; // Clear existing rows

    users.forEach(user => {
        const row = document.createElement("tr");

        row.innerHTML = `
            <td>${user.UserID}</td>
            <td>${user.Name}</td>
            <td>${user.Email}</td>
            <td>${user.ContactNumber}</td>
            <td>${user.Role}</td>
            <td>${user.City}</td>
            <td>${user.Createdate}</td>
            <td>
                <button onclick="updateUser(${user.UserID})" class="Update">Update</button>
                <button onclick="deleteUser(${user.UserID}, this)" class="Delete">Delete</button>
            </td>
        `;

        tbody.appendChild(row);
    });
}

async function fetchUsers() {
    try {
        const response = await fetch('http://localhost:3000/user/all-users');
        const data = await response.json();

        if (response.status === 200 && data.users) {
            populateTable(data.users);
        } else {
            console.log('No users found');
        }
    } catch (error) {
        console.error('Error fetching users:', error);
    }
}

async function deleteUser(userId, button) {
    try {
        const response = await fetch(`http://localhost:3000/user/delete-user/${userId}`, {
            method: 'DELETE',
        });

        const data = await response.json();

        if (response.status === 200) {
            // alert(data.message);
            button.closest('tr').remove(); // Remove row from the table
            console.log("ok")
        } else {
            alert(data.message);
        }
    } catch (error) {
        console.error('Error deleting user:', error);
    }
}

function updateUser(userId) {
    // Find the row in the table
    const row = [...document.querySelectorAll("table tbody tr")].find(r =>
        r.children[0].textContent == userId
    );

    // Fill the update form
    document.getElementById("updateUserId").value = userId;
    document.getElementById("updateName").value = row.children[1].textContent;
    document.getElementById("updateEmail").value = row.children[2].textContent;
    document.getElementById("updatePassword").value = "pass123"; // you can't prefill password
    document.getElementById("updateContact").value = row.children[3].textContent;
    document.getElementById("updateRole").value = row.children[4].textContent;
    document.getElementById("updateCity").value = row.children[5].textContent;

    document.getElementById("updateForm").style.display = "block";
}



document.addEventListener("DOMContentLoaded",  () => {
    // Function to fetch users from the server
    fetchUsers();
});

document.getElementById("updateForm").addEventListener("submit", async function (e) {
    e.preventDefault();

    const userId = document.getElementById("updateUserId").value;
    const updatedData = {
        name: document.getElementById("updateName").value,
        email: document.getElementById("updateEmail").value,
        password: document.getElementById("updatePassword").value,
        contactNumber: document.getElementById("updateContact").value,
        role: document.getElementById("updateRole").value,
        City: document.getElementById("updateCity").value
    };

    try {
        const response = await fetch(`http://localhost:3000/user/update-user/${userId}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(updatedData)
        });

        const data = await response.json();

        if (response.status === 200) {
            alert(data.message);
            document.getElementById("updateForm").reset();
            document.getElementById("updateForm").style.display = "none";
            fetchUsers(); // Refresh table
        } else {
            alert(data.message);
        }
    } catch (error) {
        console.error("Error updating user:", error);
    }
});

document.getElementById("createUserForm").addEventListener("submit", async (e) => {
    e.preventDefault();

    const name = document.getElementById("name").value.trim();
    const email = document.getElementById("email").value.trim();
    const password = document.getElementById("password").value;
    const contactNumber = document.getElementById("contact").value.trim();
    const role = document.getElementById("role").value;
    const city = document.getElementById("city").value.trim();

    const user = { name, email, password, contactNumber, role, city };

    try {
        const response = await fetch("http://localhost:3000/user/create-new", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(user),
        });

        const data = await response.json();
        alert(data.message);

        if (data.message === "Login successful") {
            fetchUsers(); // refresh the table
           
        }
    } catch (error) {
        console.error("Error creating user:", error);
    }
});



