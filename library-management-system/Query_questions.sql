use db_Librarymanagement;
/*==================== GREAT QUERY QUESTIONS ==========================*/
/* #1- How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"? */
SHOW TABLES;

SELECT tbl_book_copies.book_copies_No_of_Copies AS "no of copies" FROM tbl_book_copies
LEFT JOIN tbl_book ON tbl_book.book_BookID = tbl_book_copies.book_copies_BookID
JOIN  tbl_library_branch ON tbl_library_branch.library_branch_BranchID = tbl_book_copies.book_copies_BranchID
WHERE tbl_book.book_Title = "The Lost Tribe" AND tbl_library_branch.library_branch_BranchName = "Sharpstown";

/* #2- How many copies of the book titled "The Lost Tribe" are owned by each library branch? */
SELECT tbl_book_copies.book_copies_No_of_Copies as "no of copies",tbl_library_branch.library_branch_BranchName as Branch FROM tbl_book_copies
LEFT JOIN tbl_book ON tbl_book.book_BookID = tbl_book_copies.book_copies_BookID
JOIN  tbl_library_branch ON tbl_library_branch.library_branch_BranchID = tbl_book_copies.book_copies_BranchID
WHERE tbl_book.book_Title = "The Lost Tribe";

/* #3- Retrieve the names of all borrowers who do not have any books checked out. */

SELECT borrower_BorrowerName FROM tbl_borrower
WHERE NOT EXISTS(SELECT 1 FROM tbl_book_loans l WHERE  borrower_CardNo = l.book_loans_CardNo);

/* #4- For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today{i literally took 2/3/18 to get some result} , retrieve the book title, the borrower's name, and the borrower's address.  */

CREATE OR REPLACE VIEW first_table_view AS SELECT tbl_book_loans.book_loans_BookID,tbl_book_loans.book_loans_BranchID,tbl_borrower.borrower_BorrowerName,tbl_borrower.borrower_BorrowerAddress,tbl_book_loans.book_loans_DueDate,tbl_book_loans.book_loans_DateOut
FROM tbl_borrower LEFT JOIN tbl_book_loans ON tbl_book_loans.book_loans_CardNo = tbl_borrower.borrower_CardNo;

select * FROM FIRST_TABLE_VIEW;

CREATE OR REPLACE VIEW second_table_view AS SELECT tbl_book.book_Title,book_loans_BranchID,borrower_BorrowerName,borrower_BorrowerAddress,book_loans_DueDate
FROM first_table_view JOIN tbl_book ON first_table_view.book_loans_BookID = tbl_book.book_BookID;

SELECT * FROM second_table_view;

CREATE OR REPLACE VIEW third_table_view AS SELECT book_Title , borrower_BorrowerName , borrower_BorrowerAddress , book_loans_DueDate , tbl_library_branch.library_branch_BranchName 
FROM  second_table_view JOIN tbl_library_branch ON tbl_library_branch.library_branch_BranchID = second_table_view.book_loans_BranchID;

SELECT * FROM third_table_view;

SELECT * FROM third_table_view WHERE library_branch_BranchName = "Sharpstown" AND book_loans_DueDate = "2/3/18";

/* #5- For each library branch, retrieve the branch name and the total number of books loaned out from that branch.  */

SELECT  library_branch_BranchName,COUNT(tbl_book_loans.book_loans_loansID) AS "total loaned books" FROM tbl_library_branch 
JOIN  tbl_book_copies ON  tbl_book_copies.book_copies_BranchID = tbl_library_branch.library_branch_BranchID 
INNER JOIN tbl_book_loans ON tbl_book_loans.book_loans_BranchID = tbl_library_branch.library_branch_BranchID 
GROUP BY tbl_library_branch.library_branch_BranchName;

/* #6- Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out. */

SELECT checked_outmassive.borrower_BorrowerName,tbl_borrower.borrower_BorrowerAddress, checked_outmassive.bookscount FROM (
SELECT borrower_BorrowerName,COUNT(book_loans_BookID) as bookscount FROM (
SELECT  * FROM first_table_view WHERE book_loans_DateOut IS NOT NULL ) AS checkedout_books
GROUP BY borrower_BorrowerName) AS checked_outmassive
JOIN tbl_borrower ON checked_outmassive.borrower_BorrowerName = tbl_borrower.borrower_BorrowerName
WHERE checked_outmassive.bookscount > 5;


/* #7- For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".*/
CREATE OR REPLACE VIEW fourth_table_view AS 
SELECT * FROM tbl_book_copies WHERE tbl_book_copies.book_copies_BranchID =
(SELECT library_branch_BranchID FROM tbl_library_branch WHERE library_branch_BranchName = "Central");


SELECT tbl_book.book_Title,fourth_table_view.book_copies_No_of_Copies,tbl_book_authors.book_authors_AuthorName FROM fourth_table_view 
JOIN tbl_book ON tbl_book.book_BookID = fourth_table_view.book_copies_BookID 
JOIN tbl_book_authors  ON  tbl_book_authors.book_authors_BookID = tbl_book.book_BookID
WHERE book_authors_AuthorName = "Stephen King";

/*========================== END OF QUERY QUESTIONS ================================================*/