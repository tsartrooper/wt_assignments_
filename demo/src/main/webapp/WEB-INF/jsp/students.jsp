<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Students</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-900 text-gray-200">

<header class="mb-8">
    <nav class="bg-gray-900 border-gray-700">
        <div class="max-w-screen-xl flex items-center justify-center mx-auto p-4">
            <div class="w-full flex items-center justify-center" id="navbar-default">
                <ul class="font-medium flex space-x-8 mt-0 border-0 bg-gray-900">
                    <li>
                        <a href="books.jsp" class="block py-2 px-3 text-white rounded hover:text-blue-500">Manage Books</a>
                    </li>
                    <li>
                        <a href="#" class="block py-2 px-3 text-blue-500" aria-current="page">Manage Students</a>
                    </li>
                    <li>
                        <a href="librarian.jsp" class="block py-2 px-3 text-white rounded hover:text-blue-500">Librarian Dashboard</a>
                    </li>
                    <li>
                        <a href="index.jsp" class="block py-2 px-3 text-white rounded hover:text-blue-500">Home</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>

<div class="container mx-auto max-w-md mb-8">
    <div class="bg-gray-800 shadow-md rounded-lg p-6">
        <h2 class="text-2xl font-bold mb-4 text-white">Add New Student</h2>
        <form id="addStudentForm" class="space-y-4">
            <div>
                <label class="block mb-2 text-sm font-medium text-white" for="studentName">Student Name</label>
                <input type="text" id="studentName" name="studentName" required
                       class="bg-gray-700 border border-gray-600 text-white text-sm rounded-lg block w-full p-2.5 placeholder-gray-400"
                       placeholder="Enter student name">
            </div>
            <div>
                <label class="block mb-2 text-sm font-medium text-white" for="studentEmail">Student Email</label>
                <input type="email" id="studentEmail" name="studentEmail" required
                       class="bg-gray-700 border border-gray-600 text-white text-sm rounded-lg block w-full p-2.5 placeholder-gray-400"
                       placeholder="Enter student email">
            </div>
            <button type="submit"
                    class="w-full mt-4 mb-4 text-white bg-blue-600 hover:bg-blue-700 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center">
                Add Student
            </button>
        </form>
    </div>
</div>

<div class="container mx-auto max-w-3xl mb-8">
    <div class="bg-gray-800 shadow-md rounded-lg p-6">
        <h2 class="text-2xl font-bold mb-4 text-white">Student List</h2>
        <ul id="studentList" class="space-y-2">
            <!-- Students will be dynamically added here -->
        </ul>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const addStudentForm = document.getElementById('addStudentForm');
        const studentList = document.getElementById('studentList');

        function fetchStudents() {
            fetch('/students')
                .then(response => response.json())
                .then(students => {
                    studentList.innerHTML = '';
                    students.forEach(student => {
                        const li = document.createElement('li');
                        li.className = 'flex justify-between items-center p-2 bg-gray-700 rounded';
                        li.innerHTML = `
                            <span>${student.name} (${student.email})</span>
                            <div>
                                <button class="editStudent bg-yellow-500 hover:bg-yellow-600 text-white py-1 px-2 rounded mr-2" data-id="${student.id}">Edit</button>
                                <button class="deleteStudent bg-red-500 hover:bg-red-600 text-white py-1 px-2 rounded" data-id="${student.id}">Delete</button>
                            </div>
                        `;
                        studentList.appendChild(li);
                    });
                })
                .catch(error => console.error('Error fetching students:', error));
        }

        addStudentForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const name = document.getElementById('studentName').value;
            const email = document.getElementById('studentEmail').value;

            fetch('/students', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ name, email }),
            })
            .then(response => response.json())
            .then(student => {
                alert('Student added successfully!');
                addStudentForm.reset();
                fetchStudents();
            })
            .catch(error => console.error('Error adding student:', error));
        });

        studentList.addEventListener('click', function(e) {
            if (e.target.classList.contains('deleteStudent')) {
                const studentId = e.target.getAttribute('data-id');
                if (confirm('Are you sure you want to delete this student?')) {
                    fetch(`/students/${studentId}`, {
                        method: 'DELETE',
                    })
                    .then(response => {
                        if (response.ok) {
                            alert('Student deleted successfully!');
                            fetchStudents();
                        } else {
                            alert('Failed to delete student.');
                        }
                    })
                    .catch(error => console.error('Error deleting student:', error));
                }
            } else if (e.target.classList.contains('editStudent')) {
                const studentId = e.target.getAttribute('data-id');
                const studentName = prompt('Enter new name for the student:');
                const studentEmail = prompt('Enter new email for the student:');
                if (studentName && studentEmail) {
                    fetch(`/students/${studentId}`, {
                        method: 'PUT',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({ name: studentName, email: studentEmail }),
                    })
                    .then(response => response.json())
                    .then(updatedStudent => {
                        alert('Student updated successfully!');
                        fetchStudents();
                    })
                    .catch(error => console.error('Error updating student:', error));
                }
            }
        });

        fetchStudents();
    });
</script>

</body>
</html>
