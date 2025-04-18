//%attributes = {}
C_OBJECT:C1216($params)
$params:=New object:C1471

/*
the local file path of downloaded static documents
processing online source is not supported for now
*/

$path:="Macintosh HD:Users:miyako:Documents:4Dv16:"

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

$book:=$books.query("id === :1"; "book_3670638")[0]  //design
$book:=$books.query("id === :1"; "book_3650984")[0]  //install
$book:=$books.query("id === :1"; "book_3423307")[0]  //upgrade
$book:=$books.query("id === :1"; "book_3200467")[0]  //odbc driver
$book:=$books.query("id === :1"; "book_3130124")[0]  //build
$book:=$books.query("id === :1"; "book_3207198")[0]  //backup
$book:=$books.query("id === :1"; "book_3200498")[0]  //odbc pro
$book:=$books.query("id === :1"; "book_3010622")[0]  //pack
$book:=$books.query("id === :1"; "book_3423373")[0]  //progress
$book:=$books.query("id === :1"; "book_3423397")[0]  //widgets
$book:=$books.query("id === :1"; "book_3202293")[0]  //svg
$book:=$books.query("id === :1"; "book_3423353")[0]  //mobile
$book:=$books.query("id === :1"; "book_3423335")[0]  //deprecated
$book:=$books.query("id === :1"; "book_3423391")[0]  //view
$book:=$books.query("id === :1"; "book_3069756")[0]  //ic
$book:=$books.query("id === :1"; "book_3423329")[0]  //server
$book:=$books.query("id === :1"; "book_3201173")[0]  //sql
$book:=$books.query("id === :1"; "book_3673248")[0]  //convert
$book:=$books.query("id === :1"; "book_3199478")[0]  //oci
$book:=$books.query("id === :1"; "book_3651020")[0]  //lang
//$book:=$books.query("id === :1"; "book_3423403")[0]  //write
//$book:=$books.query("id === :1"; "book_3423409")[0]  //write lang

If (False:C215)  //v14
	//$book:=$books.query("id === :1"; "book_1418787")[0]  //install
	//$book:=$books.query("id === :1"; "book_1391348")[0]  //self training
	//$book:=$books.query("id === :1"; "book_1339646")[0]  //convert
	//$book:=$books.query("id === :1"; "book_1206675")[0]  //upgrade
	//$book:=$books.query("id === :1"; "book_1365362")[0]  //odbc driver
	//$book:=$books.query("id === :1"; "book_1419001")[0]  //build
	//$book:=$books.query("id === :1"; "book_1638051")[0]  //backup
	//$book:=$books.query("id === :1"; "book_1574043")[0]  //odbc pro
	//$book:=$books.query("id === :1"; "book_1418994")[0]  //pack
	//$book:=$books.query("id === :1"; "book_1418862")[0]  //progress
	//$book:=$books.query("id === :1"; "book_1418855")[0]  //widgets
	//$book:=$books.query("id === :1"; "book_1418849")[0]  //svg
	//$book:=$books.query("id === :1"; "book_1707019")[0]  //mobile
	//$book:=$books.query("id === :1"; "book_1728513")[0]  //deprecated
	//$book:=$books.query("id === :1"; "book_1418836")[0]  //view
	//$book:=$books.query("id === :1"; "book_1418830")[0]  //write
	//$book:=$books.query("id === :1"; "book_1418824")[0]  //ic
	//$book:=$books.query("id === :1"; "book_1418818")[0]  //server
	//$book:=$books.query("id === :1"; "book_1418809")[0]  //sql
	//$book:=$books.query("id === :1"; "book_1705332")[0]  //design
	//$book:=$books.query("id === :1"; "book_1696430")[0]  //lang
End if 

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