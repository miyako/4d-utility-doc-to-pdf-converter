//%attributes = {}
C_OBJECT:C1216($params)
$params:=New object:C1471

/*
the local file path of downloaded static documents
processing online source is not supported for now
*/

$path:="Macintosh HD:Users:Shared:4Dv18:"

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

$chapterFile:=File:C1566("/Users/Shared/4Dv18/4D/18/Obsolete-commands.906-4504285.ja.html")

$options:=New object:C1471("xmlOut";True:C214)
$status:=Tidy ($chapterFile.getContent();$options)

$base:=Folder:C1567("/Users/Shared/4Dv18/")

$page:=Replace string:C233($status.html;"&nbsp;";"&#160;";*)
$pageDom:=DOM Parse XML variable:C720($page)

cajole_nodes ($pageDom;$chapterFile;$params)
parse_href ($pageDom;$chapterFile;$base;$params)

$books:=get_books ($params)
$book:=$books.query("id === :1";"book_4504285")[0]

$html:=New collection:C1472

get_title_list ($pageDom;$book;$html;$params)
