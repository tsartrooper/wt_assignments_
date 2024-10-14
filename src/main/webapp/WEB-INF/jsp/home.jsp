<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Library Management System</ti<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Library Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold mb-6 text-center">Welcome to the Library Management System</h1>
        <nav class="mb-8">
            <ul class="flex justify-center space-x-4">
                <li><a href="/books" class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded">Books</a></li>
                <li><a href="/students" class="bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded">Students</a></li>
                <li><a href="/librarian" class="bg-purple-500 hover:bg-purple-600 text-white font-bold py-2 px-4 rounded">Librarian</a></li>
            </ul>
        </nav>
        <p class="text-center text-xl">${message}</p>
    </div>
</body>
</html>
tle>
</head>
<body>
    <h1>Welcome to the Library Management System</h1>
    <nav>
        <ul>
            <li><a href="/books">Books</a></li>
            <li><a href="/students">Students</a></li>
            <li><a href="/librarian">Librarian</a></li>
        </ul>
    </nav>
    <p>${message}</p>
</body>
</html>
