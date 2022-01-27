// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract Structure {
   struct Book { 
      string title;
      string author;
      uint book_id;
   }
   Book book;

   function setBook() public {
      book = Book('Learn Python', 'TP', 1);
   }
   function getBookId() public view returns (uint, string memory, string memory) {
      return (book.book_id, book.title, book.author) ;
   }
}
