//%attributes = {}
C_OBJECT:C1216($params)
$params:=New object:C1471

/*
the local file path of downloaded static documents
processing online source is not supported for now
*/

$path:="Macintosh HD:Users:miyako:Documents:4Dv20:"

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

If (False:C215)
	//success
	$book:=$books.query("id === :1"; "book_6343777")[0]  //4D v20 リリースノート
End if 
$book:=$books.query("id === :1"; "book_6340540")[0]  //4D for OCI


If (False:C215)
	$book:=$books.query("id === :1"; "book_6259787")[0]  //廃止予定または削除された機能
	$book:=$books.query("id === :1"; "book_6341136")[0]  //4D Internet Commands
	$book:=$books.query("id === :1"; "book_6341902")[0]  //4D ODBC Driver
	$book:=$books.query("id === :1"; "book_6341911")[0]  //4D Progress（進捗バー）
	$book:=$books.query("id === :1"; "book_6330521")[0]  //4D Server
	$book:=$books.query("id === :1"; "book_6342795")[0]  //SVGコンポーネント
	$book:=$books.query("id === :1"; "book_6343444")[0]  //4D View Pro リファレンス
	$book:=$books.query("id === :1"; "book_6343453")[0]  //4D Widgets（ウィジェット）
	$book:=$books.query("id === :1"; "book_6229455")[0]  //4D Write Proリファレンス
	$book:=$books.query("id === :1"; "book_6335734")[0]  //アプリケーションビルド設定ファイル
	$book:=$books.query("id === :1"; "book_6343616")[0]  //バックアップ設定ファイル
	$book:=$books.query("id === :1"; "book_6342002")[0]  //SQLリファレンス
	$book:=$books.query("id === :1"; "book_6479538")[0]  //ランゲージリファレンス
	$book:=$books.query("id === :1"; "book_6602032")[0]  //デザインリファレンス
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