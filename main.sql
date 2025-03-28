-- Create the Artists table
CREATE TABLE Artists (
 ArtistID INT PRIMARY KEY,
 Name VARCHAR(255) NOT NULL,
 Biography TEXT,
 Nationality VARCHAR(100));

-- Create the Categories table
CREATE TABLE Categories (
 CategoryID INT PRIMARY KEY,
 Name VARCHAR(100) NOT NULL);

-- Create the Artworks table
CREATE TABLE Artworks (
 ArtworkID INT PRIMARY KEY,
 Title VARCHAR(255) NOT NULL,
 ArtistID INT,
 CategoryID INT,
 Year INT,
 Description TEXT,
 ImageURL VARCHAR(255),
 FOREIGN KEY (ArtistID) REFERENCES Artists (ArtistID),
 FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID));

-- Create the Exhibitions table
CREATE TABLE Exhibitions (
 ExhibitionID INT PRIMARY KEY,
 Title VARCHAR(255) NOT NULL,
 StartDate DATE,
 EndDate DATE,
 Description TEXT);

-- Create a table to associate artworks with exhibitions
CREATE TABLE ExhibitionArtworks (
 ExhibitionID INT,
 ArtworkID INT,
 PRIMARY KEY (ExhibitionID, ArtworkID),
 FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions (ExhibitionID),
 FOREIGN KEY (ArtworkID) REFERENCES Artworks (ArtworkID));

-- Users table
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    PasswordHash VARCHAR(255)
);

-- Payments table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    UserID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    UserID INT,
    ArtworkID INT,
    OrderDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ArtworkID) REFERENCES Artworks(ArtworkID)
);

-- Reviews table
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY,
    UserID INT,
    ArtworkID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ArtworkID) REFERENCES Artworks(ArtworkID)
);


-- Insert sample data into the Artists table
INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES
 (1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'),
 (2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
 (3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');

-- Insert sample data into the Categories table
INSERT INTO Categories (CategoryID, Name) VALUES
 (1, 'Painting'),
 (2, 'Sculpture'),
 (3, 'Photography');

-- Insert sample artworks
INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL)
VALUES 
(1, 'Guernica', 1, 3, 1937, 'Anti-war painting by Picasso', 'https://example.com/guernica.jpg'),
(2, 'Starry Night', 2, 2, 1889, 'Famous painting by van Gogh', 'https://example.com/starrynight.jpg'),
(3, 'Mona Lisa', 3, 1, 1503, 'Portrait of Lisa Gherardini', 'https://example.com/monalisa.jpg'),
(4, 'The Weeping Woman', 1, 3, 1937, 'Portrait of a woman crying, by Picasso', 'https://example.com/weepingwoman.jpg'),
(5, 'Sunflowers', 2, 2, 1888, 'A series of paintings of sunflowers', 'https://example.com/sunflowers.jpg'),
(6, 'Café Terrace at Night', 2, 2, 1888, 'A street scene in Arles at night', 'https://example.com/cafeterrace.jpg'),
(7, 'Irises', 2, 2, 1889, 'A painting of blue irises with a yellow background', 'https://example.com/irises.jpg'),
(8, 'The Last Supper', 3, 1, 1498, 'A mural painting of Jesus and his disciples', 'https://example.com/lastsupper.jpg'),
(9, 'Vitruvian Man', 3, 1, 1490, 'A sketch representing ideal human proportions', 'https://example.com/vitruvianman.jpg'),
(10, 'Les Demoiselles', 1, 3, 1907, 'A sketch depicting humans', 'https://example.com/demoiselles.jpg');
  
INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES
 (1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'),
 (2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');
  
-- Insert artworks into exhibitions
INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES
 (1, 1),
 (1, 2),
 (1, 3),
 (1, 6),
 (1, 7),
 (2, 2),
 (2, 4),
 (2, 10);
  
-- Insert sample users
INSERT INTO Users (UserID, Name, Email, PasswordHash)
VALUES 
(1, 'Alice Johnson', 'alice@example.com', 'hashedpassword1'),
(2, 'Bob Smith', 'bob@example.com', 'hashedpassword2'),
(3, 'Charlie Brown', 'charlie@example.com', 'hashedpassword3'),
(4, 'Diana Prince', 'diana@example.com', 'hashedpassword4');

-- Insert sample payments
INSERT INTO Payments (PaymentID, UserID, Amount, PaymentDate)
VALUES 
(1, 1, 20000.00, '2024-03-01'),
(2, 2, 300000.00, '2024-03-05'),
(3, 3, 150000.00, '2024-03-15'),
(4, 4, 75000.00, '2024-03-20');

-- Insert sample orders
INSERT INTO Orders (OrderID, UserID, ArtworkID, OrderDate)
VALUES 
(1, 1, 1, '2024-03-10'),
(2, 2, 2, '2024-03-12'),
(3, 3, 7, '2024-03-22'),
(4, 4, 10, '2024-03-25');

-- Insert sample reviews
INSERT INTO Reviews (ReviewID, UserID, ArtworkID, Rating, Comment)
VALUES 
(1, 1, 1, 5, 'Amazing piece!'),
(2, 2, 2, 4, 'Loved the painting!'),
(3, 3, 7, 5, 'A mind-bending masterpiece!'),
(4, 4, 10, 4, 'Love the use of colors.');

--Task 1 Retrieve the names of all artists along with the number of artworks they have in the gallery, and list them in descending order of the number of artworks.

SELECT A.Name, COUNT(Ar.ArtworkID) AS ArtworkCount
FROM Artists A
LEFT JOIN Artworks Ar ON A.ArtistID = Ar.ArtistID
GROUP BY A.Name
ORDER BY ArtworkCount DESC;

--Task 2 List the titles of artworks created by artists from 'Spanish' and 'Dutch' nationalities, and order them by the year in ascending order

SELECT Ar.Title, Ar.Year
FROM Artworks Ar
JOIN Artists A ON Ar.ArtistID = A.ArtistID
WHERE A.Nationality IN ('Spanish', 'Dutch')
ORDER BY Ar.Year ASC;

--Task 3 Find the names of all artists who have artworks in the 'Painting' category, and the number of artworks they have in this category
SELECT A.Name, COUNT(Ar.ArtworkID) AS ArtworkCount
FROM Artists A
JOIN Artworks Ar ON A.ArtistID = Ar.ArtistID
JOIN Categories C ON Ar.CategoryID = C.CategoryID
WHERE C.Name = 'Painting'
GROUP BY A.Name
ORDER BY ArtworkCount DESC;

--Task 4 List the names of artworks from the 'Modern Art Masterpieces' exhibition, along with their artists and categories.
SELECT Ar.Title AS Artwork, A.Name AS Artist, C.Name AS Category
FROM Exhibitions E
JOIN ExhibitionArtworks EA ON E.ExhibitionID = EA.ExhibitionID
JOIN Artworks Ar ON EA.ArtworkID = Ar.ArtworkID
JOIN Artists A ON Ar.ArtistID = A.ArtistID
JOIN Categories C ON Ar.CategoryID = C.CategoryID
WHERE E.Title = 'Modern Art Masterpieces'
ORDER BY Ar.Title ASC;

--Task 5 Find the artists who have more than two artworks in the gallery
SELECT A.Name AS Artist, COUNT(Ar.ArtworkID) AS Artwork_Count
FROM Artists A
JOIN Artworks Ar ON A.ArtistID = Ar.ArtistID
GROUP BY A.ArtistID, A.Name
HAVING COUNT(Ar.ArtworkID) > 2
ORDER BY Artwork_Count DESC;

--Task 6 Find the titles of artworks that were exhibited in both 'Modern Art Masterpieces' and 'Renaissance Art' exhibitions
SELECT A.Title
FROM Artworks A
JOIN ExhibitionArtworks EA1 ON A.ArtworkID = EA1.ArtworkID
JOIN ExhibitionArtworks EA2 ON A.ArtworkID = EA2.ArtworkID
JOIN Exhibitions E1 ON EA1.ExhibitionID = E1.ExhibitionID
JOIN Exhibitions E2 ON EA2.ExhibitionID = E2.ExhibitionID
WHERE E1.Title = 'Modern Art Masterpieces' 
AND E2.Title = 'Renaissance Art';

--Task 7 Find the total number of artworks in each category
SELECT C.Name AS Category, COUNT(A.ArtworkID) AS TotalArtworks
FROM Categories C
LEFT JOIN Artworks A ON C.CategoryID = A.CategoryID
GROUP BY C.Name;

--Task 8 List artists who have more than 3 artworks in the gallery
SELECT Ar.Name, COUNT(A.ArtworkID) AS TotalArtworks
FROM Artists Ar
JOIN Artworks A ON Ar.ArtistID = A.ArtistID
GROUP BY Ar.ArtistID, Ar.Name
HAVING COUNT(A.ArtworkID) > 3;

--Task 9 Find the artworks created by artists from a specific nationality (e.g., Spanish)
SELECT A.Title, Ar.Name AS Artist, Ar.Nationality
FROM Artworks A
JOIN Artists Ar ON A.ArtistID = Ar.ArtistID
WHERE Ar.Nationality = 'Spanish';

-- Task 10 List exhibitions that feature artwork by both Vincent van Gogh and Leonardo da Vinci

SELECT E.Title AS Exhibition
FROM Exhibitions E
JOIN ExhibitionArtworks EA ON E.ExhibitionID = EA.ExhibitionID
JOIN Artworks A ON EA.ArtworkID = A.ArtworkID
JOIN Artists Ar ON A.ArtistID = Ar.ArtistID
WHERE Ar.Name = 'Vincent van Gogh'
INTERSECT
SELECT E.Title
FROM Exhibitions E
JOIN ExhibitionArtworks EA ON E.ExhibitionID = EA.ExhibitionID
JOIN Artworks A ON EA.ArtworkID = A.ArtworkID
JOIN Artists Ar ON A.ArtistID = Ar.ArtistID
WHERE Ar.Name = 'Leonardo da Vinci';

--Task 11 Find all the artworks that have not been included in any exhibition
SELECT A.Title
FROM Artworks A
LEFT JOIN ExhibitionArtworks EA ON A.ArtworkID = EA.ArtworkID
WHERE EA.ExhibitionID IS NULL;

--Task 12 List artists who have created artworks in all available categories
SELECT Ar.Name
FROM Artists Ar
JOIN Artworks A ON Ar.ArtistID = A.ArtistID
JOIN Categories C ON A.CategoryID = C.CategoryID
GROUP BY Ar.ArtistID, Ar.Name
HAVING COUNT(DISTINCT A.CategoryID) = (SELECT COUNT(*) FROM Categories);

--Task 13 List the total number of artworks in each category
SELECT C.Name AS Category, COUNT(A.ArtworkID) AS TotalArtworks
FROM Categories C
LEFT JOIN Artworks A ON C.CategoryID = A.CategoryID
GROUP BY C.CategoryID, C.Name;

--Task 14 Find the artists who have more than 2 artworks in the gallery.
SELECT Ar.Name
FROM Artists Ar
JOIN Artworks A ON Ar.ArtistID = A.ArtistID
GROUP BY Ar.ArtistID, Ar.Name
HAVING COUNT(A.ArtworkID) > 2;

--Task 15 List the categories with the average year of artworks they contain, only for categories with more than 1 artwork
SELECT C.Name AS Category, AVG(A.Year) AS AvgYear
FROM Categories C
JOIN Artworks A ON C.CategoryID = A.CategoryID
GROUP BY C.CategoryID, C.Name
HAVING COUNT(A.ArtworkID) > 1;

--Task 16 Find the artworks that were exhibited in the 'Modern Art Masterpieces' exhibition.
SELECT A.Title
FROM Artworks A
JOIN ExhibitionArtworks EA ON A.ArtworkID = EA.ArtworkID
JOIN Exhibitions E ON EA.ExhibitionID = E.ExhibitionID
WHERE E.Title = 'Modern Art Masterpieces';

--Task 17 Find the categories where the average year of artworks is greater than the average year of all artworks
SELECT C.Name AS Category
FROM Categories C
JOIN Artworks A ON C.CategoryID = A.CategoryID
GROUP BY C.CategoryID, C.Name
HAVING AVG(A.Year) > (SELECT AVG(Year) FROM Artworks);

--Task 18 List the artworks that were not exhibited in any exhibition
SELECT A.Title
FROM Artworks A
LEFT JOIN ExhibitionArtworks EA ON A.ArtworkID = EA.ArtworkID
WHERE EA.ExhibitionID IS NULL;

--Task 19 Show artists who have artworks in the same category as "Mona Lisa"
SELECT DISTINCT Ar.Name
FROM Artists Ar
JOIN Artworks A ON Ar.ArtistID = A.ArtistID
WHERE A.CategoryID = (SELECT CategoryID FROM Artworks WHERE Title = 'Mona Lisa');

--Task 20 List the names of artists and the number of artworks they have in the gallery
SELECT Ar.Name, COUNT(A.ArtworkID) AS ArtworkCount
FROM Artists Ar
LEFT JOIN Artworks A ON Ar.ArtistID = A.ArtistID
GROUP BY Ar.ArtistID, Ar.Name;
