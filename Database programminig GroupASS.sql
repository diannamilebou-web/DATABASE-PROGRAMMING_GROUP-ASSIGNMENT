---TABLES CREATION--
CREATE TABLE Books(
Book_ID INT PRIMARY KEY,
Title varchar(50),
Author VARCHAR2(50),
Category VARCHAR2(30),
Copies NUMBER);

CREATE TABLE Members(
Member_ID NUMBER PRIMARY KEY,
First_Name VARCHAR2(30),
Last_Name VARCHAR2(30),
Phone VARCHAR2(15)
);

CREATE TABLE Borrow(
Borrow_ID NUMBER PRIMARY KEY,
Book_ID NUMBER,
Member_ID NUMBER,
Borrow_Date DATE,
Return_Date DATE,

FOREIGN KEY(Book_ID)
REFERENCES Books(Book_ID),

FOREIGN KEY(Member_ID)
REFERENCES Members(Member_ID)
);

CREATE TABLE Fines(
Fine_ID NUMBER PRIMARY KEY,
Borrow_ID NUMBER,
Amount NUMBER,

FOREIGN KEY(Borrow_ID)
REFERENCES Borrow(Borrow_ID)
);
---INSERTION OF DATA--
INSERT INTO Books VALUES(1,'Database Systems','Thomas Connolly','Database',5);
INSERT INTO Books VALUES(2,'Java Programming','Herbert Schildt','Programming',4);
INSERT INTO Books VALUES(3,'Computer Networks','Andrew Tanenbaum','Networking',3);
INSERT INTO Books VALUES(4,'Python Basics','Mark Lutz','Programming',6);
INSERT INTO Books VALUES(5,'Operating Systems','Silberschatz','OS',2);

COMMIT;

INSERT INTO Members VALUES(101,'Alice','Mugisha','078111111');
INSERT INTO Members VALUES(102,'David','Ndayisaba','078222222');
INSERT INTO Members VALUES(103,'Grace','Uwase','078333333');
INSERT INTO Members VALUES(104,'Kevin','Habimana','078444444');
INSERT INTO Members VALUES(105,'Brian','Iradukunda','078555555');

COMMIT;

INSERT INTO Borrow VALUES(1,1,101,DATE '2026-06-01',DATE '2026-06-08');
INSERT INTO Borrow VALUES(2,2,102,DATE '2026-06-02',DATE '2026-06-09');
INSERT INTO Borrow VALUES(3,1,103,DATE '2026-06-04',DATE '2026-06-11');
INSERT INTO Borrow VALUES(4,4,104,DATE '2026-06-06',DATE '2026-06-13');
INSERT INTO Borrow VALUES(5,2,105,DATE '2026-06-08',DATE '2026-06-15');

COMMIT;

INSERT INTO Fines VALUES(1,1,1000);
INSERT INTO Fines VALUES(2,2,500);
INSERT INTO Fines VALUES(3,3,0);
INSERT INTO Fines VALUES(4,4,1500);
INSERT INTO Fines VALUES(5,5,0);

COMMIT;

---Stored Procedure,FUNCTION--
--Register a New Book--
CREATE OR REPLACE PROCEDURE Add_Book(

p_id NUMBER,
p_title VARCHAR2,
p_author VARCHAR2,
p_category VARCHAR2,
p_copies NUMBER

)

IS

BEGIN

INSERT INTO Books
VALUES
(p_id,p_title,p_author,p_category,p_copies);

DBMS_OUTPUT.PUT_LINE('Book Added Successfully.');

END;
/

--Execute--
BEGIN

Add_Book
(6,'Artificial Intelligence','Stuart Russell','AI',5);

END;
/

--Function,Calculate Fine--

CREATE OR REPLACE FUNCTION Calculate_Fine(

days_late NUMBER

)

RETURN NUMBER

IS

fine NUMBER;

BEGIN

fine:=days_late*500;

RETURN fine;

END;
/

---Execute--
SELECT Calculate_Fine(4)
FROM dual;

--Anonymous Block--
DECLARE

v_title VARCHAR2(100);

BEGIN

SELECT Title

INTO v_title

FROM Books

WHERE Book_ID=1;

DBMS_OUTPUT.PUT_LINE
('Book Title: '||v_title);

END;
/
--Window Function,Rank the Most Borrowed Books--
SELECT

b.Title,

COUNT(br.Book_ID) Total_Borrowed,

RANK() OVER(

ORDER BY COUNT(br.Book_ID) DESC

) Book_Rank

FROM Books b

JOIN Borrow br

ON b.Book_ID=br.Book_ID

GROUP BY b.Title;

--View all books--
SELECT * FROM Books;

--Available books--
SELECT Title,Copies
FROM Books;

---Total fines collected--

SELECT SUM(Amount)
FROM Fines;

--Average fine--
SELECT AVG(Amount)
FROM Fines;

---Borrowing Report--

SELECT

m.First_Name,

b.Title,

br.Borrow_Date,

br.Return_Date

FROM Members m

JOIN Borrow br

ON m.Member_ID=br.Member_ID

JOIN Books b

ON br.Book_ID=b.Book_ID;

--Useful Queries--

SELECT * FROM Books;

SELECT Title,Copies
FROM Books;

SELECT SUM(Amount)
FROM Fines;

SELECT AVG(Amount)
FROM Fines;


