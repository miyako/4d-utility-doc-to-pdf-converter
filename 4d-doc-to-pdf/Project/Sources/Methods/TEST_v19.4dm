//%attributes = {}
C_OBJECT:C1216($params)
$params:=New object:C1471

/*
the local file path of downloaded static documents
processing online source is not supported for now
*/

$path:="Macintosh HD:Users:Shared:4Dv19:"

/*
don't use file system (e.g. "/RESOURCES/")
links may traverse outside the base URL
*/

$params.sourceIndexFolder:=Folder:C1567($path;fk platform path:K87:2)
$params.lang:="ja"

/*
export detected errors (missing link, etc)
*/

$params.CREATE_LOG:=True:C214
$params.LOG_FOLDER:=Folder:C1567(fk logs folder:K87:17)
$params.LOG_START:=Formula:C1597(log_start )
$params.LOG_PUSH:=Formula:C1597(log_push )
$params.LOG_END:=Formula:C1597(log_end )

$params.LOG_START()

$books:=get_books ($params)


/*
error deutsch
*/

$book:=$books.query("id === :1";"book_5391516")[0]  //ランゲージリファレンス

If (False:C215)
	$book:=$books.query("id === :1";"book_5461755")[0]  //インストールガイド
	$book:=$books.query("id === :1";"book_5461783")[0]  //新ドキュメンテーションWebサイト
	$book:=$books.query("id === :1";"book_5418933")[0]  //4D v19.x リリースノート
/* need to fix français */
	$book:=$books.query("id === :1";"book_5416591")[0]  //デザインリファレンス
	
	
	
	$book:=$books.query("id === :1";"book_5422445")[0]  //4D Server
	$book:=$books.query("id === :1";"book_5461787")[0]  //4D for iOS
	$book:=$books.query("id === :1";"book_5433266")[0]  //4D for OCI
	$book:=$books.query("id === :1";"book_5454656")[0]  //4D Internet Commands
	$book:=$books.query("id === :1";"book_5433862")[0]  //4D ODBC Driver
	$book:=$books.query("id === :1";"book_5461799")[0]  //4D Progress（進捗バー）
	$book:=$books.query("id === :1";"book_5434405")[0]  //SQLリファレンス
	$book:=$books.query("id === :1";"book_5461938")[0]  //SVGコンポーネント
	$book:=$books.query("id === :1";"book_5442901")[0]  //4D View Pro リファレンス
	$book:=$books.query("id === :1";"book_5462909")[0]  //4D Widgets（ウィジェット）
	$book:=$books.query("id === :1";"book_5390146")[0]  //4D Write Proリファレンス
	$book:=$books.query("id === :1";"book_5463072")[0]  //バックアップ設定ファイル
	$book:=$books.query("id === :1";"book_5447429")[0]  //アプリケーションビルド設定ファイル
End if 



/*
for now, no major differences between languages
the idea is to switch fonts, in particular, for japanese (メイリオ)  
*/

$template:=get_template ($params)

$html:=create_book ($book;$template;$params)

$params.LOG_END()

/*
now convert html to pdf!
*/

$targetFolder:=Folder:C1567(System folder:C487(Desktop:K41:16)+"document-export"+Folder separator:K24:12+"export_pdf";fk platform path:K87:2)

$target:=set_target ($targetFolder;$html;$book.name)
$pdfPath:=create_pdf ($target)
OPEN URL:C673($pdfPath)