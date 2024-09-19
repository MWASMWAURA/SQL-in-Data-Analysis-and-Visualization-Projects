-- library management system and stored procedures 
/*================================================  CREATING DATABASE  ===================================*/
CREATE DATABASE db_LibraryManagement ; 
USE  db_LibraryManagement;
/*======================== TABLES ===========================*/

CREATE TABLE tbl_publisher (
						publisher_PublisherName VARCHAR(100) PRIMARY KEY NOT NULL,
                        publisher_PublisherAddress VARCHAR(200) NOT NULL,
                        publisher_PublisherPhone VARCHAR(50) NOT NULL);

CREATE TABLE tbl_book (
					book_BookID INT PRIMARY KEY AUTO_INCREMENT NOT NULL ,
                    book_Title VARCHAR(100) NOT NULL,
                    book_PublisherName VARCHAR(100) NOT NULL ,
                    CONSTRAINT fk_publisher_name1 FOREIGN KEY (book_PublisherName) REFERENCES tbl_publisher(publisher_PublisherName));
CREATE TABLE 	tbl_library_branch (
					library_branch_BranchID INT PRIMARY KEY AUTO_INCREMENT NOT NULL ,
                    library_branch_BranchName VARCHAR(100) NOT NULL,
                    library_branch_BranchAddress VARCHAR(200) NOT NULL);
CREATE TABLE tbl_borrower (borrower_CardNo INT PRIMARY KEY NOT NULL AUTO_INCREMENT ,
					borrower_BorrowerName VARCHAR(100) NOT NULL,
                    borrower_BorrowerAddress VARCHAR(200) NOT NULL,
                    borrower_BorrowerPhone VARCHAR(50) NOT NULL); -- We will alter this table to set auto_increment = 100
ALTER TABLE tbl_borrower AUTO_INCREMENT = 100;
CREATE TABLE tbl_book_loans (
		book_loans_LoansID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
		book_loans_BookID INT NOT NULL,
        CONSTRAINT fk_book_id1 FOREIGN KEY (book_loans_BookID) REFERENCES tbl_book(book_BookID),
		book_loans_BranchID INT NOT NULL ,
        CONSTRAINT fk_branch_id1 FOREIGN KEY (book_loans_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID),
		book_loans_CardNo INT NOT NULL ,
        CONSTRAINT fk_cardno FOREIGN KEY (book_loans_CardNo) REFERENCES tbl_borrower(borrower_CardNo),
		book_loans_DateOut VARCHAR(50) NOT NULL,
		book_loans_DueDate VARCHAR(50) NOT NULL);
CREATE TABLE tbl_book_copies (
					book_copies_CopiesID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
                    book_copies_BookID INT NOT NULL ,
                    CONSTRAINT fk_book_id2 FOREIGN KEY (book_copies_BookID) REFERENCES tbl_book(book_BookID) ,
                    book_copies_No_of_Copies INT NOT NULL,
                    book_copies_BranchID INT NOT NULL ,
                    CONSTRAINT fk_branch_id2 FOREIGN KEY  (book_copies_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID));

CREATE TABLE tbl_book_authors (
					book_authors_AuthorID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
                    book_authors_BookID INT NOT NULL,
                    CONSTRAINT fk_book_id3 FOREIGN KEY (book_authors_BookID) REFERENCES tbl_book(book_BookID),
                    book_authors_AuthorName VARCHAR(50) NOT NULL);
                    
/*================================================ END TABLES =========================================================*/
