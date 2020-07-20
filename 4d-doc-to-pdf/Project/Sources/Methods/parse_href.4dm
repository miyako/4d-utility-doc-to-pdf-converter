//%attributes = {"invisible":true,"preemptive":"capable"}
/*
convert file url to href of anchor names
the name formula is applied in anchor_name_for_file
the original href is preserved in a namespaced attribute
*/

C_TEXT:C284($1;$dom)
C_OBJECT:C1216($2;$file;$targetFile;$3;$rootFolder;$4;$params)

$dom:=$1
$file:=$2
$rootFolder:=$3
$params:=$4

C_TEXT:C284($lang)
$lang:=$params.lang

ARRAY TEXT:C222($doms;0)
ARRAY LONGINT:C221($types;0)

DOM GET XML CHILD NODES:C1081($dom;$types;$doms)

C_TEXT:C284($name;$value)

For ($i;1;Size of array:C274($types))
	$type:=$types{$i}
	If ($type=XML ELEMENT:K45:20)
		$dom:=$doms{$i}
		For ($ii;1;DOM Count XML attributes:C727($dom))
			DOM GET XML ATTRIBUTE BY INDEX:C729($dom;$ii;$name;$value)
			If ($name="href")
				DOM GET XML ELEMENT NAME:C730($dom;$name)
				If ($name="a")
					If ($value#"")
						
						ARRAY LONGINT:C221($pos;0)
						ARRAY LONGINT:C221($len;0)
						
						If (Match regex:C1019("([^#]+)(#.+)";$value;1;$pos;$len))
							$value:=Substring:C12($value;$pos{1};$len{1})
						End if 
						
						Case of 
							: (Match regex:C1019("[^?]+\\?&sort=.*";$value))
								  //table header
							: (Match regex:C1019("([^?]+)(\\?.*)";$value;1;$pos;$len))
								$value:=Substring:C12($value;$pos{1};$len{1})
						End case 
						
						$suffix:=$lang
						  //extract lang suffix
						If (Match regex:C1019(".+\\.([a-z]{2})\\.html";$value;1;$pos;$len))
							$suffix:=Substring:C12($value;$pos{1};$len{1})
						End if 
						
						C_COLLECTION:C1488($pathComponents)
						
						  //fix version mismatch in hardlinks
						Case of 
							: ($value="@4D-Installation-Guide@")
								  //redirect to current version
								$value:=Replace string:C233($value;"4844794";"4688909";*)
								
							: ($value="@Deprecated-or-removed-features@")
								  //redirect to current version
								$value:=Replace string:C233($value;"4822814";"5049565";*)
								$value:=Replace string:C233($value;"4969974";"5049565";*)
								$value:=Replace string:C233($value;"-in-v18-product-range";"";*)
								$value:=Replace string:C233($value;"4605463";"5049565";*)
								
							: ($value="@18/Changes-and-updates@")
								$value:=Replace string:C233($value;"18/Changes-and-updates.200-4822816";"18.2/Changes-and-updates.200-5049566";*)
								
							: ($value="@Changes-and-updates@")
								  //redirect to current version
								$value:=Replace string:C233($value;"4822816";"5049566";*)
								$value:=Replace string:C233($value;"4969975";"5049566";*)
								
							: ($value="@Previous-Documents@")
								  //redirect to current version
								$value:=Replace string:C233($value;"4822815";"5049567";*)
								$value:=Replace string:C233($value;"4969976";"5049567";*)
								
							: ($value="@WP-EXPORT-DOCUMENT@")
								$value:=Replace string:C233($value;"1863636";"4523015";*)
								
							: ($value="@WP-EXPORT-VARIABLE@")
								$value:=Replace string:C233($value;"1863643";"4523019";*)
								
							: ($value="@WP-Import-document@")
								$value:=Replace string:C233($value;"1863649";"4523016";*)
								
							: ($value="@WP-New@")
								$value:=Replace string:C233($value;"1863656";"4523032";*)
								
							: ($value="@WP-Create-subsection@")
								$value:=Replace string:C233($value;"WP-Create-subsection";"WP-New-subsection";*)
								
							: ($value="@WP-CREATE-BOOKMARK@")
								$value:=Replace string:C233($value;"WP-CREATE-BOOKMARK";"WP-NEW-BOOKMARK";*)
								
							: ($value="@WP-GET-ATTRIBUTES@")
								$value:=Replace string:C233($value;"2706357";"4523013";*)
								
							: ($value="@WP-SET-ATTRIBUTES@")
								$value:=Replace string:C233($value;"2706358";"4523014";*)
								
							: ($value="@FONT-STYLE-LIST@")
								$value:=Replace string:C233($value;"2787404";"4505606";*)
								
							: ($value="@On-Server-Open-Connection-Database-Method@")
								$value:=Replace string:C233($value;"67450";"4672408";*)  //lc:4505000
								
							: ($value="@On-Server-Close-Connection-Database-Method@")
								$value:=Replace string:C233($value;"67449";"4672409";*)  //lc:4505009
								
							: ($value="@On-Web-Authentication-Database-Method@")
								$value:=Replace string:C233($value;"300-977165";"301-4505012";*)  //lowercase:4505012
								
							: ($value="@On-Server-Startup-Database-Method@")
								$value:=Replace string:C233($value;"67452";"4672407";*)  //lowercase:4505006
								
							: ($value="@Creating-a-Server-Database@")
								$value:=Replace string:C233($value;"845398";"4672444";*)
								
							: ($value="@Checking-Your-Installation@")
								$value:=Replace string:C233($value;"845399";"4672440";*)
								
							: ($value="@Connecting-to-the-Server-Database-with-a-Remote@")
								$value:=Replace string:C233($value;"845397";"4672445";*)
								
							: ($value="@Connecting-to-a-4D-Server-Database@")
								$value:=Replace string:C233($value;"845385";"4672439";*)
								
							: ($value="@Defining-the-Database-Structure@")
								$value:=Replace string:C233($value;"845403";"4672441";*)
								
							: ($value="@Data-Manipulation-with-4D-Server@")
								$value:=Replace string:C233($value;"845402";"4672442";*)
								
							: ($value="@Adding-a-Custom-Menu-Bar@")
								$value:=Replace string:C233($value;"845401";"4672446";*)
								
							: ($value="@Exiting-4D-Server@")
								$value:=Replace string:C233($value;"845393";"4672423";*)
								
							: ($value="@Creating-a-New-4D-Server-Database@")
								$value:=Replace string:C233($value;"845394";"4672422";*)
								
							: ($value="@Registering-a-Database-as-a-Service@")
								$value:=Replace string:C233($value;"845388";"4672427";*)
								
							: ($value="@Stored-procedures-on-client-machines@")
								$value:=Replace string:C233($value;"845413";"4672415";*)
								
							: ($value="@Configuration-preferences@")
								$value:=Replace string:C233($value;"Configuration-preferences.300-845386";"Network-and-Client-Server-options.300-4672425";*)
								
							: ($value="@Monitor-Page@")
								$value:=Replace string:C233($value;"845382";"4672430";*)
								
							: ($value="@Users-Page@")
								$value:=Replace string:C233($value;"845381";"4672436";*)
								
							: ($value="@GET-ACTIVITY-SNAPSHOT@")
								$value:=Replace string:C233($value;"300-1526735";"301-4504929";*)
								
							: ($value="@Stored-Procedures@")
								$value:=Replace string:C233($value;"216966";"4672416";*)
								$value:=Replace string:C233($value;"300-67459";"300-4672416";*)
								
							: ($value="@Encrypting-ClientServer-Connections@")
								$value:=Replace string:C233($value;"67435";"4672419";*)
								
							: ($value="@Execute-on-Server-attribute@")
								$value:=Replace string:C233($value;"845410";"4672411";*)
								
							: ($value="@4D-Server-Sets-and-Named-Selections@")
								$value:=Replace string:C233($value;"845408";"4672417";*)
								
							: ($value="@SP-Based-Import-Example@")
								$value:=Replace string:C233($value;"845412";"4672413";*)
								
							: ($value="@Label-editor-redesign@")
								$value:=Replace string:C233($value;"Label-editor-redesign.300-2899033";"Label-editor.200-4575451";*)
								
							: ($value="@Etiketteneditor@")
								$value:=Replace string:C233($value;"300-2899033";"200-4575451";*)
								$value:=Replace string:C233($value;"200-1477096";"200-4575451";*)
								
							: ($value="@Quick-Report-editor-redesign@")
								$value:=Replace string:C233($value;"Quick-Report-editor-redesign.300-2899027";"Quick-reports.200-4575452";*)
								
							: ($value="@Quick-reports@")
								$value:=Replace string:C233($value;"3962803";"4575452";*)
								
							: ($value="@Schnellberichte@")
								$value:=Replace string:C233($value;"3962803";"4575452";*)
								
							: ($value="@VP-EXPORT-DOCUMENT@")
								$value:=Replace string:C233($value;"3426196";"4522260";*)
								
							: ($value="@VP-IMPORT-DOCUMENT@")
								$value:=Replace string:C233($value;"3426190";"4522259";*)
								
							: ($value="@Principles-for-integrating-4D-and-the-4D-SQL-engine@")
								$value:=Replace string:C233($value;"Principles-for-integrating-4D-and-the-4D-SQL-engine.300-72604";"4D-SQL-engine-implementation.300-4650700";*)
								
							: ($value="@SMTP-transportersend@")
								$value:=Replace string:C233($value;"SMTP-transportersend.305-4505974";"SMTP-transportersend.300-4505974";*)
								
							: ($value="@SMTP-transportercheckConnection.305-4505971@")
								$value:=Replace string:C233($value;"SMTP-transportercheckConnection.305-4505971";"SMTP-transportercheckConnection.300-4505971";*)
								
							: ($value="@transportercheckConnection.305-4505971@")
								$value:=Replace string:C233($value;"transportercheckConnection.305-4505971";"SMTP-transportercheckConnection.300-4505971";*)
								
							: ($value="@Field-properties@")
								$value:=Replace string:C233($value;"1477337";"4575567";*)
								
							: ($value="@Feldeigenschaften@")
								$value:=Replace string:C233($value;"1477337";"4575567";*)
								
							: ($value="@IP-Configuration@")
								$value:=Replace string:C233($value;"IP-Configuration.300-845391";"IP-Settings.300-4672424";*)
								
							: ($value="@Web-server-configuration-and-connection-management@")
								$value:=Replace string:C233($value;"977167";"4504720";*)
								$value:=Replace string:C233($value;"300-205403";"300-4504720";*)
								
							: ($value="@Web-Server-konfigurieren-und-Verbindung-verwalten@")
								$value:=Replace string:C233($value;"977167";"4504720";*)
								$value:=Replace string:C233($value;"300-205403";"300-4504720";*)
								
							: ($value="@Command-Line-Interface-extended@")
								
								If ($file.name="@300-4575466@")
									  //bad link in source
								Else 
									$value:=Replace string:C233($value;"Command-Line-Interface-extended.300-1570420";"Command-Line-Interface.300-4575704";*)
								End if 
								
							: ($value="@Erweiterte-Command-Line-Interface-CLI@")
								
								If ($file.name="@300-4575466@")
									  //bad link in source
								Else 
									$value:=Replace string:C233($value;"Erweiterte-Command-Line-Interface-CLI.300-1570420";"Command-Line-Interface.300-4575704";*)
								End if 
								
							: ($value="@dataStoreprovideDataKey@")
								$value:=Replace string:C233($value;"dataStoreprovideDataKey.305-4505925";"dataStoreprovideDataKey.300-4505925";*)
								
							: ($value="@Connection-Security@")
								$value:=Replace string:C233($value;"205401";"4504721";*)
								$value:=Replace string:C233($value;"977166";"4504721";*)
								
							: ($value="@4D-field-types@")
								$value:=Replace string:C233($value;"1477338";"4575568";*)
								
							: ($value="@4D-Datenfeldtypen@")
								$value:=Replace string:C233($value;"1477338";"4575568";*)
								
							: ($value="@Label-editor@")
								$value:=Replace string:C233($value;"1477096";"4575451";*)
								
							: ($value="@entity@")
								$value:=Replace string:C233($value;"305-";"300-";*)
								
							: ($value="@dataStore@")
								$value:=Replace string:C233($value;"305-";"300-";*)
								
							: ($value="@dataClass@")
								$value:=Replace string:C233($value;"305-";"300-";*)
								
							: ($value="@Label-editor@")
								$value:=Replace string:C233($value;"1477096";"4575451";*)
								
							: ($value="@List-subforms@")
								$value:=Replace string:C233($value;"1016001";"4575635";*)
								
							: ($value="@Unterformulare-als-Liste@")
								$value:=Replace string:C233($value;"1016001";"4575635";*)
								
							: ($value="@SQL-Server-Page@")
								$value:=Replace string:C233($value;"845377";"4672435";*)
								
							: ($value="@Seite-SQL@")
								$value:=Replace string:C233($value;"Seite-SQL-page.300-4575466";"Seite-SQL.300-4575466";*)
								
							: ($value="@ForEnd-for@")
								$value:=Replace string:C233($value;"978013";"4505539";*)
								
							: ($value="@Appendix-E-Description-of-log-files@")
								$value:=Replace string:C233($value;"Appendix-E-Description-of-log-files.300-3188166";"Description-of-log-files.300-4575486";*)
								
							: ($value="@Anhang-E-Beschreibung-der-Protokolldateien@")
								$value:=Replace string:C233($value;"Anhang-E-Beschreibung-der-Protokolldateien.300-3188166";"Beschreibung-der-Logbucher.300-4575486";*)
								
							: ($value="@E.300-3188166@")
								$value:=Replace string:C233($value;"E.300-3188166";"Description-of-log-files.300-4575486";*)
								
							: ($value="@-.300-4575475@")
								$value:=Replace string:C233($value;"-.300-4575475";"DatabaseMemory-page.300-4575475";*)
								
							: ($value="@-.300-4575486@")
								$value:=Replace string:C233($value;"-.300-4575486";"Description-of-log-files.300-4575486";*)
								
							: ($value="@-.300-4575701@")
								$value:=Replace string:C233($value;"-.300-4575701";"Creating-a-new-database.300-4575701";*)
								
							: ($value="@Web.300-4504709@")
								$value:=Replace string:C233($value;"Web.300-4504709";"Web-Server-Settings.300-4504709";*)
								
							: ($value="@Datenbankmethode-On-Server-Startup@")
								$value:=Replace string:C233($value;"Datenbankmethode-On-Server-Startup-Database-Method.301-4672407";"Datenbankmethode-On-Server-Startup.301-4672407";*)
								
							: ($value="@Datenbankmethode-On-Server-Close-Connection@")
								$value:=Replace string:C233($value;"Datenbankmethode-On-Server-Close-Connection.301-67449";"Datenbankmethode-On-Server-Close-Connection.301-4672409";*)
								
							: ($value="@Datenbankmethode-On-Server-Open-Connection@")
								$value:=Replace string:C233($value;"Datenbankmethode-On-Server-Open-Connection.301-67450";"Datenbankmethode-On-Server-Open-Connection.301-4505000";*)
								
							: ($value="@Datenbankmethode-On-Web-Authentication.300-977165@")
								$value:=Replace string:C233($value;"Datenbankmethode-On-Web-Authentication.300-977165";"Datenbankmethode-On-Web-Authentication.301-4505012";*)
								
							: ($value="@Datenbankmethode-On-Web-Authentication.300-205400@")
								$value:=Replace string:C233($value;"Datenbankmethode-On-Web-Authentication.300-205400";"Datenbankmethode-On-Web-Authentication.300-4504707";*)
								
							: ($value="@New-Formula.301-4505749@")
								$value:=Replace string:C233($value;"New-Formula.301-4505749";"Formula.301-4505749";*)
								
							: ($value="@4D/11.6/Einfuhrung-in-Trigger@")
								$value:=Replace string:C233($value;"300-205498";"300-4504565";*)
								
							: ($value="@On-Server-Startup.301-4672407@")
								$value:=Replace string:C233($value;"On-Server-Startup.301-4672407";"On-Server-Startup-Database-Method.301-4672407";*)
								
							: ($value="@-.300-4575608@")
								$value:=Replace string:C233($value;"-.300-4575608";"Spell-checking.300-4575608";*)
								
							: ($value="@SQL.300-4575466@")
								$value:=Replace string:C233($value;"SQL.300-4575466";"SQL-page.300-4575466";*)
								
							: ($value="@-.300-4575476@")
								$value:=Replace string:C233($value;"-.300-4575476";"Compatibility-page.300-4575476";*)
								
							: ($value="@-.300-4672425@")
								$value:=Replace string:C233($value;"-.300-4672425";"Network-and-Client-Server-options.300-4672425";*)
								
							: ($value="@-.300-4575704@")
								$value:=Replace string:C233($value;"-.300-4575704";"Command-Line-Interface.300-4575704";*)
								
							: ($value="@4D-Server.300-4672439@")
								$value:=Replace string:C233($value;"4D-Server.300-4672439";"Connecting-to-a-4D-Server-Database.300-4672439";*)
								
							: ($value="@-.300-4505257@")
								$value:=Replace string:C233($value;"-.300-4505257";"Window-Types-compatibility.300-4505257";*)
								
							: ($value="@LDAP-LOGIN@")
								$value:=Replace string:C233($value;"2005970";"4505637";*)
								
							: ($value="@collectionsort@")
								$value:=Replace string:C233($value;"collectionsort.305-4505853";"collectionsort.300-4505853";*)
								
							: ($value="@Overview-of-SQL-Commands@")
								$value:=Replace string:C233($value;"977496";"4505595";*)
								
							: ($value="@SQL.302-977600@")
								$value:=Replace string:C233($value;"SQL.302-977600";"SQL.302-4504445";*)
								
							: ($value="%20http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html")
								$value:="http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html"
								  //WA-GET-LAST-URL-ERROR.301-4504842.en.html
								
							: ($value="@4D-HTML-Tags@")
								$value:=Replace string:C233($value;"4D-HTML-Tags.300-1342175";"4D-Transformation-Tags.300-4505674";*)
								
							: ($value="@Multi-style-Rich-text-area@")
								$value:=Replace string:C233($value;"1477147";"4575616";*)
								
							: ($value="@Text-mit-Stil-Rich-Text@")
								$value:=Replace string:C233($value;"1477147";"4575616";*)
								
							: ($value="@QUERY-BY-ATTRIBUTE@")
								$value:=Replace string:C233($value;"1477147";"4575616";*)
								
							: ($value="@/Storing-4D-Write-Pro-documents-in-4D-Object-fields@")
								$value:=Replace string:C233($value;"300-2584906";"200-4522987";*)
								
							: ($value="@/4D-Write-Pro-Dokumente-in-4D-Objektfeldern-speichern@")
								$value:=Replace string:C233($value;"300-2584906";"200-4522987";*)
								
							: ($value="@collectionpush@")
								$value:=Replace string:C233($value;"305-4505847";"300-4505847";*)
								
							: ($value="@collectioninsert@")
								$value:=Replace string:C233($value;"305-4505848";"300-4505848";*)
								
							: ($value="@C-INTEGER@")
								$value:=Replace string:C233($value;"C-INTEGER.301-206201";"o-C-INTEGER.301-4506033";*)
								
							: ($value="@LOCKED-ATTRIBUTES@")
								$value:=Replace string:C233($value;"LOCKED-ATTRIBUTES.301-977687";"LOCKED-BY.301-4505158";*)
								
							: ($value="@OUTPUT-FORM@")
								$value:=Replace string:C233($value;"OUTPUT-FORM.301-206115";"FORM-SET-OUTPUT.301-4505760";*)
								
							: ($value="@PAGE-SETUP@")
								$value:=Replace string:C233($value;"PAGE-SETUP.301-977802";"o-PAGE-SETUP.301-4505822";*)
								
							: ($value="@INPUT-FORM@")
								$value:=Replace string:C233($value;"INPUT-FORM.301-206114";"FORM-SET-INPUT.301-4505766";*)
								
							: ($value="@System-Documents@")
								$value:=Replace string:C233($value;"System-Documents.201-4504290";"System-Documents.300-4504519";*)
								
							: ($value="@ADD-SUBRECORD@")
								$value:=Replace string:C233($value;"ADD-SUBRECORD.301-206192";"o-ADD-SUBRECORD.301-4506007";*)
								
							: ($value="@MODIFY-SUBRECORD@")
								$value:=Replace string:C233($value;"MODIFY-SUBRECORD.301-206191";"o-MODIFY-SUBRECORD.301-4506008";*)
								
							: ($value="@FORM-GET-PARAMETER@")
								$value:=Replace string:C233($value;"FORM-GET-PARAMETER.301-978100";"o-FORM-GET-PARAMETER.301-4506030";*)
								
							: ($value="@folderfiles@")
								$value:=Replace string:C233($value;"305-4506056";"300-4506056";*)
								
							: ($value="@folderfile@")
								$value:=Replace string:C233($value;"305-4506054";"300-4506054";*)
								
							: ($value="@folderfolders@")
								$value:=Replace string:C233($value;"305-4506055";"300-4506055";*)
								
							: ($value="@folderfolder@")
								$value:=Replace string:C233($value;"305-4506053";"300-4506053";*)
								
							: ($value="@filecopyTo@")
								$value:=Replace string:C233($value;"305-4506082";"300-4506082";*)
								
							: ($value="@filecreateAlias@")
								$value:=Replace string:C233($value;"305-4506090";"300-4506090";*)
								
							: ($value="@filecreate@")
								$value:=Replace string:C233($value;"305-4506085";"300-4506085";*)
								
							: ($value="@filedelete@")
								$value:=Replace string:C233($value;"305-4506084";"300-4506084";*)
								
							: ($value="@filegetContent@")
								$value:=Replace string:C233($value;"305-4506086";"300-4506086";*)
								
							: ($value="@filegetIcon@")
								$value:=Replace string:C233($value;"305-4506065";"300-4506065";*)
								
							: ($value="@filegetText@")
								$value:=Replace string:C233($value;"305-4506088";"300-4506088";*)
								
							: ($value="@filemoveTo@")
								$value:=Replace string:C233($value;"305-4506083";"300-4506083";*)
								
							: ($value="@filerename@")
								$value:=Replace string:C233($value;"305-4506081";"300-4506081";*)
								
							: ($value="@filesetContent@")
								$value:=Replace string:C233($value;"305-4506087";"300-4506087";*)
								
							: ($value="@filesetText@")
								$value:=Replace string:C233($value;"305-4506089";"300-4506089";*)
								
							: ($value="@foldercopyTo@")
								$value:=Replace string:C233($value;"305-4506059";"300-4506059";*)
								
							: ($value="@foldercreateAlias@")
								$value:=Replace string:C233($value;"305-4506063";"300-4506063";*)
								
							: ($value="@foldercreate@")
								$value:=Replace string:C233($value;"305-4506062";"300-4506062";*)
								
							: ($value="@folderdelete@")
								$value:=Replace string:C233($value;"305-4506061";"300-4506061";*)
								
							: ($value="@foldergetIcon@")
								$value:=Replace string:C233($value;"305-4506057";"300-4506057";*)
								
							: ($value="@foldermoveTo@")
								$value:=Replace string:C233($value;"305-4506060";"300-4506060";*)
								
							: ($value="@folderrename@")
								$value:=Replace string:C233($value;"305-4506058";"300-4506058";*)
								
							: ($value="@folderfolders@")
								$value:=Replace string:C233($value;"305-4506055";"300-4506055";*)
								
							: ($value="@formulaapply@")
								$value:=Replace string:C233($value;"305-4505752";"300-4505752";*)
								
							: ($value="@formulacall@")
								$value:=Replace string:C233($value;"305-4505751";"300-4505751";*)
								
							: ($value="@signalwait@")
								$value:=Replace string:C233($value;"305-4505568";"300-4505568";*)
								
							: ($value="@signaltrigger@")
								$value:=Replace string:C233($value;"305-4505567";"300-4505567";*)
								
							: ($value="@CALL-WORKER@")
								$value:=Replace string:C233($value;"301-2896253";"301-4505558";*)
								
							: ($value="@PROCESS-PROPERTIES@")
								$value:=Replace string:C233($value;"300-2896277";"301-4505296";*)
								
							: ($value="@transportersend@")
								$value:=Replace string:C233($value;"transportersend.305-4505974";"SMTP-transportersend.300-4505974";*)
								
							: ($value="@attachmentgetContent@")
								$value:=Replace string:C233($value;"305-4611486";"300-4611486";*)
								
							: ($value="@LISTBOX-INSERT-ROW@")
								$value:=Replace string:C233($value;"LISTBOX-INSERT-ROW.301-977992";"LISTBOX-INSERT-ROWS.301-4505211";*)
								
							: ($value="@LISTBOX-DELETE-ROW@")
								$value:=Replace string:C233($value;"LISTBOX-DELETE-ROW.301-977991";"LISTBOX-DELETE-ROWS.301-4505174";*)
								
							: ($value="@OBJECT-GET-COORDINATES@")
								$value:=Replace string:C233($value;"300-1740286";"301-4505413";*)
								
							: ($value="@SET-LISTBOX-COLUMN-WIDTH@")
								$value:=Replace string:C233($value;"SET-LISTBOX-COLUMN-WIDTH.301-206005";"LISTBOX-SET-COLUMN-WIDTH.301-4505222";*)
								
							: ($value="@Using-SSL-Protocol@")
								$value:=Replace string:C233($value;"Using-SSL-Protocol.200-4650693";"Using-TLS-Protocol-HTTPS.300-4504740";*)
								$value:=Replace string:C233($value;"Using-SSL-Protocol.300-205392";"Using-TLS-Protocol-HTTPS.300-4504740";*)
								
							: ($value="@4D-Environment@")
								$value:=Replace string:C233($value;"302-4504402";"201-4504340";*)
								
							: ($value="@collectionquery@")
								$value:=Replace string:C233($value;"305-4505864";"300-4505864";*)
								
							: ($value="@Overview-of-XML-DOM-Commands@")
								$value:=Replace string:C233($value;"300-205309";"300-4504762";*)
								
							: ($value="@4D-SQL-engine-implementation.300-4650700.de.html@")
								$value:=Replace string:C233($value;".de.";".en.";*)
								
							: ($value="@Installationshandbuch@")
								$value:=Replace string:C233($value;"100-4844794";"100-4688909";*)
								
							: ($value="@18/Anderungen-und-Aktualisierungen@")
								$value:=Replace string:C233($value;"18/Anderungen-und-Aktualisierungen.200-4822816";"18.2/Anderungen-und-Aktualisierungen.200-5049566";*)
								$value:=Replace string:C233($value;"18/Anderungen-und-Aktualisierungen.200-4969975";"18.2/Anderungen-und-Aktualisierungen.200-5049566";*)
								
								  //: ($value="@Anderungen-und-Aktualisierungen@")
								  //$value:=Replace string($value;"200-4822816";"200-5049566";*)
								  //$value:=Replace string($value;"200-4969975";"200-5049566";*)
								
							: ($value="@Anderungen-in-der-Produktreihe@")
								$value:=Replace string:C233($value;"Anderungen-in-der-Produktreihe-v18.200-4605463";"Anwendungen-in-Projekte-umwandeln.300-4606146";*)
								
							: ($value="@18/Uberholte-und-entfernte-Funktionalitaten@")
								$value:=Replace string:C233($value;"18/Uberholte-und-entfernte-Funktionalitaten.200-4822814";"18.2/Uberholte-und-entfernte-Funktionalitaten.200-5049565";*)
								$value:=Replace string:C233($value;"18/Uberholte-und-entfernte-Funktionalitaten.200-4969974";"18.2/Uberholte-und-entfernte-Funktionalitaten.200-5049565";*)
								
							: ($value="@4D-Write-Pro-Oberflache@")
								$value:=Replace string:C233($value;"4D-Write-Pro-Oberflache.300-1864323";"4D-Write-Pro-Bereich-verwenden.200-4522988";*)
								
							: ($value="@Anhang-Hilfsmittel-beim-Konvertieren@")
								$value:=Replace string:C233($value;"Anhang-Hilfsmittel-beim-Konvertieren.200-2291163";"Anhang-Hilfreiche-Methoden-fur-die-Konvertierung.200-4688878";*)
								
							: ($value="@LDAP-LOGOUT@")
								$value:=Replace string:C233($value;"LDAP-LOGOUT.301-2005971";"LDAP-LOGOUT.301-4505638";*)
								
							: ($value="@Neue-Eigenschaft-Eckradius-fur-abgerundete-Vierecke@")
								$value:=Replace string:C233($value;"Neue-Eigenschaft-Eckradius-fur-abgerundete-Vierecke.300-1629349";"Objekteigenschaften-setzen.300-4575725";*)
								
							: ($value="@OBJECT-SET-CORNER-RADIUS.301-1629493@")
								$value:=Replace string:C233($value;"OBJECT-SET-CORNER-RADIUS.301-1629493";"OBJECT-SET-CORNER-RADIUS.301-4505427";*)
								
								
						End case 
						
						$targetFile:=Null:C1517
						
						Case of 
							: ($suffix#$lang)  //language switcher
							: ($value="@Changing-from-32-bit-versions-to-64-bit-versions@")
							: ($value="@Using-4D-Server-64-bit-version-OS-X@")
							: ($value="@Using-a-64-bit-4D-Server-Windows@")
							: ($value="@4D-Server-64-bit-fur-OS-X-verwenden@")
							: ($value="@Einen-64-bit-4D-Server-Windows-einsetzen@")
							: ($value="@Gruppierte-rollbare-Bereiche@")
							: ($value="@Von-32-bit-Versionen-auf-64-bit-Versionen-wechseln@")
							: ($value="@Einfuhrung-in-Benutzerformulare.300-1342077@")
							: ($value="@Hierarchische-Listboxen-verwalten@")
							: ($value="@Erweiterte-Command-Line-Interface-CLI@") & ($file.name="@300-4575466@")
							: ($value="@Command-Line-Interface-extended@") & ($file.name="@300-4575466@")
								
							: ($value="@Die-4D-Datenbank-konfigurieren@")
							: ($value="@Listbox-Objekt-Arrays-in-Spalten-verwenden-4D-View-Pro@")
							: ($value="@Benutzerformulare.200-1477106@")
							: ($value="@User-forms.200-1477106@")
							: ($value="@Overview-of-user-forms.300-1342077@")
							: ($value="@Get-memory-leaks@")
							: ($value="@4D-View-Pro.300-3069585@")
							: ($value="@4D-Mobile@")
							: ($value="@Using-Relations@")
							: ($value="@Verknupfungen-verwenden@")
							: ($value="@List-box-Using-object-arrays-in-columns-4D-View-Pro@")
							: ($value="@Open-external-window@")
							: ($value="@Managing-Hierarchical-List-Boxes@")
							: ($value="@4D-ODBC-Driver@")
							: ($value="@4D-ODBC-Pro@")
							: ($value="@Deprecated-or-removed-features@")
							: ($value="@Deprecated-and-removed-features@")
							: ($value="@4D-for-OCI@")
							: ($value="@4D-Chart-Language@")
							: ($value="@4D-Chart-Programmiersprache@")
							: ($value="@4D-Programmiersprache-18@")
							: (Match regex:C1019(".*Vorherige-Dokumente.*";$value))
							: (Match regex:C1019(".*4D-Language-Reference.*";$value))
							: ($value="@4D-v18x-Release-Notes@")
							: (Match regex:C1019("[^?]+\\?&sort=.*";$value))
							: (Match regex:C1019("ftp.+";$value))
							: (Match regex:C1019("http.+";$value))
							: (Match regex:C1019("#.*";$value))
							: (Match regex:C1019("\\/Home\\.[a-z]{2}\\.html";$value))  //bad link to index
								
								$log:=New object:C1471
								$log.path:=$file.path
								$log.href:=$value
								$params.LOG_PUSH("warning_link_to_home";$log)
								
							: (Match regex:C1019("\\/[^/]+\\/index\\.[a-z]{2}\\.html";$value))  //bad link to index
								
								$log:=New object:C1471
								$log.path:=$file.path
								$log.href:=$value
								$params.LOG_PUSH("warning_link_to_home";$log)
								
							: (Match regex:C1019("\\.\\.\\/\\.\\.\\/index\\.[a-z]{2}\\.html";$value))  //bad link to index
								
								$log:=New object:C1471
								$log.path:=$file.path
								$log.href:=$value
								$params.LOG_PUSH("warning_link_to_home";$log)
								
							: (Match regex:C1019("[.]+\\/.+";$value))
								
								$targetFile:=$file.parent.file($value)  //e.g. ../../path
								
								If (Not:C34($targetFile.exists))
									$_value:=Split string:C1554($value;"/").join("/";ck ignore null or empty:K85:5)
									$targetFile:=$file.parent.file($_value)
									If ($targetFile.exists)
										
										$log:=New object:C1471
										$log.path:=$file.path
										$log.href:=$value
										$params.LOG_PUSH("warning_empty_path_component";$log)
										
										$value:=$_value
									Else 
										
										$pathComponents:=Split string:C1554($value;"/")
										$pathComponents.shift()
										$pathComponents.shift()
										$pathComponents.shift()
										$pathComponents.shift()
										$value:=$pathComponents.join("/";ck ignore null or empty:K85:5)
										$targetFile:=$file.parent.file($value)
										
									End if 
								End if 
								
							: (Match regex:C1019("[^/]+\\/[^/]+\\/.+";$value))  //e.g. 4D/18/path
								
								$pathComponents:=Split string:C1554($value;"/")
								$pathComponents.shift()
								$pathComponents.shift()
								$value:=$pathComponents.join("/";ck ignore null or empty:K85:5)
								
								$targetFile:=$file.parent.file($value)  //relative path
								
							: (Match regex:C1019("\\/[^/]+\\/[^/]+\\/[^/]+\\/.+";$value))  //e.g. //4Dv18/4D/18/path
								
								$pathComponents:=Split string:C1554($value;"/")
								$pathComponents.shift()
								$pathComponents.shift()
								$value:=$pathComponents.join("/";ck ignore null or empty:K85:5)
								$targetFile:=$rootFolder.file($value)
								
								If (Not:C34($targetFile.exists))
									$_o_targetFile:=$targetFile.parent.file("o-"+$targetFile.name+$targetFile.extension)
									If ($_o_targetFile.exists)
										
										$log:=New object:C1471
										$log.path:=$file.path
										$log.href:=$value
										$params.LOG_PUSH("warning_link_to_o_command";$log)
										
										$targetFile:=$_o_targetFile
									Else 
										
										Case of 
											: ($value="@SVG-SET-CLIP-PATH@")
												$value:=Replace string:C233($value;"888661";"4611817";*)
											: ($value="@SVG-SET-SHAPE-RENDERING@")
												$value:=Replace string:C233($value;"888659";"4611815";*)
											: ($value="@SVGTool-SHOW-IN-VIEWER@")
												$value:=Replace string:C233($value;"888752";"4611845";*)
											: ($value="4D-Write-Pro/@")
												$value:=Replace string:C233($value;"4D-Write-Pro/";"../../";*)
											: ($value="4D-Write-Pro-Language/@")
												$value:=Replace string:C233($value;"4D-Write-Pro-Language/";"../../";*)
											: ($value="-/@")
												$value:=Replace string:C233($value;"-/";"../../";*)
											: ($value="Language/@")
												$value:=Replace string:C233($value;"Language/";"../../";*)
										End case 
										
										$pathComponents:=Split string:C1554($value;"/")
										$pathComponents.shift()
										$pathComponents.shift()
										
										$_value:=$pathComponents.join("/";ck ignore null or empty:K85:5)
										$targetFile:=$file.parent.file($_value)
										
										If ($targetFile.exists)
											
											$log:=New object:C1471
											$log.path:=$file.path
											$log.href:=$value
											$params.LOG_PUSH("warning_link_to_wrong_version";$log)
											
											$value:=$_value
										Else 
											$_o_targetFile:=$targetFile.parent.file("o-"+$targetFile.name+$targetFile.extension)
											If ($_o_targetFile.exists)
												
												$log:=New object:C1471
												$log.path:=$file.path
												$log.href:=$value
												$params.LOG_PUSH("warning_link_to_wrong_version";$log)
												
												$targetFile:=$_o_targetFile
											Else 
												TRACE:C157
											End if 
										End if 
									End if 
								End if 
								
							: (Match regex:C1019("\\/[^/]+\\/[^/]+\\/.+";$value))  //e.g. /--18/-/path, /4D/18/path
								
								$pathComponents:=Split string:C1554($value;"/")
								$pathComponents.shift()
								$pathComponents.shift()
								$pathComponents.shift()
								$value:=$pathComponents.join("/";ck ignore null or empty:K85:5)
								
								$targetFile:=$file.parent.file($value)  //relative path
								
							: (Match regex:C1019("\\/[^/]+\\/.+";$value))  //e.g. /4D/path
								$pathComponents:=Split string:C1554($value;"/")
								$pathComponents.shift()
								$value:=$pathComponents.join("/";ck ignore null or empty:K85:5)
								$targetFile:=$rootFolder.file($value)
								
							: (Match regex:C1019("\\/[^/]+";$value))  //e.g. /file
								$targetFile:=$rootFolder.file($value)
								
							Else   //relative path that starts with a folder
								$targetFile:=$file.parent.file($value)  //relative path
						End case 
						
						If ($targetFile#Null:C1517)
							If ($targetFile.exists)
								$link:="#"+anchor_name_for_file ($targetFile)
								DOM SET XML ATTRIBUTE:C866($dom;"href";$link)
								DOM SET XML ATTRIBUTE:C866($dom;"xml:href";$targetFile.path)
							Else 
								TRACE:C157  //$targetFile.exists
							End if 
						Else 
							Case of 
								: ($suffix#$lang)  //language switcher
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Changing-from-32-bit-versions-to-64-bit-versions@")  //obsolete document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Von-32-bit-Versionen-auf-64-bit-Versionen-wechseln@")  //obsolete document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Using-4D-Server-64-bit-version-OS-X@")  //obsolete document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-Server-64-bit-fur-OS-X-verwenden@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Using-a-64-bit-4D-Server-Windows@")  //obsolete document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Einen-64-bit-4D-Server-Windows-einsetzen@")  //obsolete document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@User-forms.200-1477106@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Overview-of-user-forms.300-1342077@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Einfuhrung-in-Benutzerformulare.300-1342077@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Get-memory-leaks@")  //invalid document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-View-Pro.300-3069585@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-Mobile@")  //obsolete document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Using-Relations@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@List-box-Using-object-arrays-in-columns-4D-View-Pro@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Listbox-Objekt-Arrays-in-Spalten-verwenden-4D-View-Pro@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Open-external-window@")  //invalid document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Managing-Hierarchical-List-Boxes@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Hierarchische-Listboxen-verwalten@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Gruppierte-rollbare-Bereiche@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Benutzerformulare.200-1477106@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Erweiterte-Command-Line-Interface-CLI@") & ($file.name="@300-4575466@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Command-Line-Interface-extended@") & ($file.name="@300-4575466@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Die-4D-Datenbank-konfigurieren@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Verknupfungen-verwenden@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
									  //-------------
									
								: ($value="@4D-ODBC-Driver@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Deprecated-or-removed-features@")  //external document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Deprecated-and-removed-features@")  //external document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-ODBC-Pro@")  //external document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-for-OCI@")  //external document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-Installation-Guide@")  //external document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-Chart-Language@")  //external document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-Chart-Programmiersprache@")  //external document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-Programmiersprache-18@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: (Match regex:C1019(".*4D-Language-Reference.*";$value))  //external document (not to be confused with SQL chapter which is lower case)
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: (Match regex:C1019(".*Vorherige-Dokumente.*";$value))  //external document (not to be confused with SQL chapter which is lower case)
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-v18x-Release-Notes@")  //external document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
									  //-------------
									
								: (Match regex:C1019("[^?]+\\?&sort=.*";$value))
								: (Match regex:C1019("ftp.+";$value))  //keep "as is"
								: (Match regex:C1019("http.+";$value))  //keep "as is"
								: (Match regex:C1019("#.*";$value))  //keep "as is"
								: (Match regex:C1019("\\/Home\\.[a-z]{2}\\.html";$value))  //remove
								: (Match regex:C1019("\\/[^/]+\\/index\\.[a-z]{2}\\.html";$value))  //remove
								: (Match regex:C1019("\\.\\.\\/\\.\\.\\/index\\.[a-z]{2}\\.html";$value))  //remove
								Else 
									TRACE:C157  //$targetFile#Null
							End case 
						End if 
					End if 
				End if 
			End if 
		End for 
		parse_href ($dom;$file;$rootFolder;$params)
	End if 
End for 