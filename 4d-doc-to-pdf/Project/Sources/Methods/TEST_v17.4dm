//%attributes = {}
C_OBJECT:C1216($params)
$params:=New object:C1471

/*
the local file path of downloaded static documents
processing online source is not supported for now
*/

$path:="Macintosh HD:Users:miyako:Documents:4Dv17:"

/*
don't use file system (e.g. "/RESOURCES/")
links may traverse outside the base URL
*/

$params.sourceIndexFolder:=Folder:C1567($path; fk platform path:K87:2)
$params.lang:="de"

/*
export detected errors (missing link, etc)
*/

$params.CREATE_LOG:=True:C214
$params.LOG_FOLDER:=Folder:C1567(fk logs folder:K87:17)
$params.LOG_START:=Formula:C1597(log_start)
$params.LOG_PUSH:=Formula:C1597(log_push)
$params.LOG_END:=Formula:C1597(log_end)

$params.LOG_START()

$books:=get_books($params)

$book:=$books.query("id === :1"; "book_3970368")[0]  //design
//$book:=$books.query("id === :1"; "book_3970354")[0]  //install
//$book:=$books.query("id === :1"; "book_3876998")[0]  //upgrade
//$book:=$books.query("id === :1"; "book_3786159")[0]  //odbc driver
//$book:=$books.query("id === :1"; "book_3787781")[0]  //build
//$book:=$books.query("id === :1"; "book_3787600")[0]  //backup
//$book:=$books.query("id === :1"; "book_3786195")[0]  //odbc pro
//$book:=$books.query("id === :1"; "book_3970497")[0]  //progress
//$book:=$books.query("id === :1"; "book_3970523")[0]  //widgets
//$book:=$books.query("id === :1"; "book_3932273")[0]  //svg
//$book:=$books.query("id === :1"; "book_3970473")[0]  //mobile
//$book:=$books.query("id === :1"; "book_3970380")[0]  //deprecated
//$book:=$books.query("id === :1"; "book_3970517")[0]  //view
//$book:=$books.query("id === :1"; "book_3785362")[0]  //ic
//$book:=$books.query("id === :1"; "book_3970374")[0]  //server

//$book:=$books.query("id === :1"; "book_3786643")[0]  //sql
//$book:=$books.query("id === :1"; "book_3970335")[0]  //convert
//$book:=$books.query("id === :1"; "book_3784766")[0]  //oci
//$book:=$books.query("id === :1"; "book_3970362")[0]  //lang
//$book:=$books.query("id === :1"; "book_3970529")[0]  //write

/*
for now, no major differences between languages
the idea is to switch fonts, in particular, for japanese (メイリオ)  
*/

$template:=get_template($params)

$html:=create_book($book; $template; $params)

$params.LOG_END()

/*
now convert html to pdf!
*/

$targetFolder:=Folder:C1567(System folder:C487(Desktop:K41:16)+"document-export"+Folder separator:K24:12+"export_pdf"; fk platform path:K87:2)

$target:=set_target($targetFolder; $html; $book.name)
$pdfPath:=create_pdf($target)
OPEN URL:C673($pdfPath)