<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Librarian</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold mb-6 text-center">Librarian Dashboard</h1>
        <div class="mb-8">
            <h2 class="text-2xl font-bold mb-4">Issue Book</h2>
            <form id="issueBookForm" class="space-y-4">
                <input type="number" id="studentId" placeholder="Student ID" required class="w-full px-3 py-2 border rounded-md">
                <input type="number" id="bookId" placeholder="Book ID" required class="w-full px-3 py-2 border rounded-md">
                <button type="submit" class="w-full bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded">Issue Book</button>
            </form>
        </div>
        <div class="mb-8">
            <h2 class="text-2xl font-bold mb-4">Collect Book</h2>
            <form id="collectBookForm" class="space-y-4">
                <input type="number" id="issueId" placeholder="Issue ID" required class="w-full px-3 py-2 border rounded-md">
                <button type="submit" class="w-full bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-4 rounded">Collect Book</button>
            </form>
        </div>
        <div>
            <h2 class="text-2xl font-bold mb-4">Issue Records</h2>
            <ul id="issueRecordList" class="space-y-2">
                <!-- Issue records will be dynamically added here -->
            </ul>
        </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const issueBookForm = document.getElementById('issueBookForm');
            const collectBookForm = document.getElementById('collectBookForm');
            const issueRecordList = document.getElementById('issueRecordList');

            // Function to fetch and display issue records
            function fetchIssueRecords() {
                fetch('/librarian/issue_records')
                    .then(response => response.json())
                    .then(records => {
                        issueRecordList.innerHTML = '';
                        records.forEach(record => {
                            const li = document.createElement('li');
                            li.textContent = `Issue ID: ${record.id}, Student ID: ${record.student_id}, Book ID: ${record.book_id}`;
                            li.className = 'p-2 bg-white rounded shadow';
                            issueRecordList.appendChild(li);
                        });
                    })
                    .catch(error => console.error('Error fetching issue records:', error));
            }

            // Handle issue book form submission
            issueBookForm.addEventListener('submit', function(e) {
                e.preventDefault();
                const studentId = document.getElementById('studentId').value;
                const bookId = document.getElementById('bookId').value;

                fetch('/librarian/issue_book', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ student_id: studentId, book_id: bookId }),
                })
                .then(response => response.json())
                .then(data => {
                    if (data) {
                        alert('Book issued successfully!');
                        issueBookForm.reset();
                        fetchIssueRecords();
                    } else {
                        alert('Failed to issue book. Please check the IDs and try again.');
                    }
                })
                .catch(error => console.error('Error issuing book:', error));
            });

            // Handle collect book form submission
            collectBookForm.addEventListener('submit', function(e) {
                e.preventDefault();
                const issueId = document.getElementById('issueId').value;

                fetch('/librarian/collect_book', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ id: issueId }),
                })
                .then(response => response.json())
                .then(data => {
                    if (data) {
                        alert('Book collected successfully!');
                        collectBookForm.reset();
                        fetchIssueRecords();
                    } else {
                        alert('Failed to collect book. Please check the Issue ID and try again.');
                    }
                })
                .catch(error => console.error('Error collecting book:', error));
            });

            // Fetch issue records on page load
            fetchIssueRecords();
        });
    </script>
</body>
</html>
