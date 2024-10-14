<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.servlet_jsp.controller.BookController" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Books</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-900 text-gray-200">

<header class="mb-8">
    <nav class="bg-gray-900 border-gray-700">
        <div class="max-w-screen-xl flex items-center justify-center mx-auto p-4">
            <div class="w-full flex items-center justify-center" id="navbar-default">
                <ul class="font-medium flex space-x-8 mt-0 border-0 bg-gray-900">
                    <li>
                        <a href="#" class="block py-2 px-3 text-blue-500" aria-current="page">Manage Books</a>
                    </li>
                    <li>
                        <a href="students.jsp" class="block py-2 px-3 text-white rounded hover:text-blue-500">Manage Students</a>
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
        <h2 class="text-2xl font-bold mb-4 text-white">Add Book</h2>

        <form id="addBookForm" class="space-y-4">
            <div>
                <label class="block mb-2 text-sm font-medium text-white" for="title">Title</label>
                <input type="text"
                       class="bg-gray-700 border border-gray-600 text-white text-sm rounded-lg block w-full p-2.5 placeholder-gray-400"
                       id="title" name="title" required
                       placeholder="Book Title">
            </div>
            <div>
                <label class="block mb-2 text-sm font-medium text-white" for="author">Author</label>
                <input type="text"
                       class="bg-gray-700 border border-gray-600 text-white text-sm rounded-lg block w-full p-2.5 placeholder-gray-400"
                       id="author" name="author" required
                       placeholder="Author Name">
            </div>
            <div>
                <label class="block mb-2 text-sm font-medium text-white" for="isbn">ISBN</label>
                <input type="text"
                       class="bg-gray-700 border border-gray-600 text-white text-sm rounded-lg block w-full p-2.5 placeholder-gray-400"
                       id="isbn" name="isbn" required
                       placeholder="ISBN">
            </div>
            <button type="submit"
                    class="w-full mt-4 mb-4 text-white bg-blue-600 hover:bg-blue-700 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center">
                Add Book
            </button>
        </form>
    </div>
</div>

<div class="container mx-auto max-w-3xl mb-8">
    <div class="bg-gray-800 shadow-md rounded-lg p-6">
        <h2 class="text-2xl font-bold mb-4 text-white">Book List</h2>
        <ul id="bookList" class="space-y-2">
            <!-- Books will be dynamically added here -->
        </ul>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const addBookForm = document.getElementById('addBookForm');
        const bookList = document.getElementById('bookList');

        function fetchBooks() {
            fetch('/books')
                .then(response => response.json())
                .then(books => {
                    bookList.innerHTML = '';
                    books.forEach(book => {
                        const li = document.createElement('li');
                        li.className = 'flex justify-between items-center p-2 bg-gray-700 rounded';
                        li.innerHTML = `
                            <span>${book.title} by ${book.author} (ISBN: ${book.isbn})</span>
                            <button class="deleteBook bg-red-500 hover:bg-red-600 text-white py-1 px-2 rounded" data-id="${book.id}">Delete</button>
                        `;
                        bookList.appendChild(li);
                    });
                })
                .catch(error => console.error('Error fetching books:', error));
        }

        addBookForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const title = document.getElementById('title').value;
            const author = document.getElementById('author').value;
            const isbn = document.getElementById('isbn').value;

            fetch('/books', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ title, author, isbn }),
            })
            .then(response => response.json())
            .then(book => {
                alert('Book added successfully!');
                addBookForm.reset();
                fetchBooks();
            })
            .catch(error => console.error('Error adding book:', error));
        });

        bookList.addEventListener('click', function(e) {
            if (e.target.classList.contains('deleteBook')) {
                const bookId = e.target.getAttribute('data-id');
                fetch(`/books/${bookId}`, {
                    method: 'DELETE',
                })
                .then(response => {
                    if (response.ok) {
                        alert('Book deleted successfully!');
                        fetchBooks();
                    } else {
                        alert('Failed to delete book.');
                    }
                })
                .catch(error => console.error('Error deleting book:', error));
            }
        });

        fetchBooks();
    });
</script>

</body>
</html>
