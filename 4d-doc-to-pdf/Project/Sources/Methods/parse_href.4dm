//%attributes = {"invisible":true,"preemptive":"capable"}
/*
convert file url to href of anchor names
the name formula is applied in anchor_name_for_file
the original href is preserved in a namespaced attribute
*/

C_TEXT:C284($1;$dom)
C_OBJECT:C1216($2;$file;$targetFile;$3;$rootFolder)
C_TEXT:C284($4;$lang)

$dom:=$1
$file:=$2
$rootFolder:=$3
$lang:=$4

ARRAY TEXT:C222($doms;0)
ARRAY LONGINT:C221($types;0)

C_OBJECT:C1216($log)
C_COLLECTION:C1488($col)

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
								
							: ($value="@Quick-Report-editor-redesign@")
								$value:=Replace string:C233($value;"Quick-Report-editor-redesign.300-2899027";"Quick-reports.200-4575452";*)
								
							: ($value="@Quick-reports@")
								$value:=Replace string:C233($value;"3962803";"4575452";*)
								
							: ($value="@VP-EXPORT-DOCUMENT@")
								$value:=Replace string:C233($value;"3426196";"4522260";*)
								
							: ($value="@VP-IMPORT-DOCUMENT@")
								$value:=Replace string:C233($value;"3426190";"4522259";*)
								
							: ($value="@Principles-for-integrating-4D-and-the-4D-SQL-engine@")
								$value:=Replace string:C233($value;"Principles-for-integrating-4D-and-the-4D-SQL-engine.300-72604";"4D-SQL-engine-implementation.300-4650700";*)
								
							: ($value="@transportersend@")
								$value:=Replace string:C233($value;"transportersend.305-4505974";"SMTP-transportersend.300-4505974";*)
								
							: ($value="@Field-properties@")
								$value:=Replace string:C233($value;"1477337";"4575567";*)
								
							: ($value="@IP-Configuration@")
								$value:=Replace string:C233($value;"IP-Configuration.300-845391";"IP-Settings.300-4672424";*)
								
							: ($value="@Web-server-configuration-and-connection-management@")
								$value:=Replace string:C233($value;"977167";"4504720";*)
								
							: ($value="@Command-Line-Interface-extended@")
								$value:=Replace string:C233($value;"Command-Line-Interface-extended.300-1570420";"Command-Line-Interface.300-4575704";*)
								
							: ($value="@dataStoreprovideDataKey@")
								$value:=Replace string:C233($value;"dataStoreprovideDataKey.305-4505925";"dataStoreprovideDataKey.300-4505925";*)
								
							: ($value="@Connection-Security@")
								$value:=Replace string:C233($value;"205401";"4504721";*)
								$value:=Replace string:C233($value;"977166";"4504721";*)
								
							: ($value="@4D-field-types@")
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
								
							: ($value="@SQL-Server-Page@")
								$value:=Replace string:C233($value;"845377";"4672435";*)
								
						End case 
						
						$targetFile:=Null:C1517
						
						Case of 
							: ($suffix#$lang)  //language switcher
								
							: ($value="@Using-4D-Server-64-bit-version-OS-X@")  //obsolete document
							: ($value="@Using-a-64-bit-4D-Server-Windows@")  //obsolete document
							: ($value="@User-forms@")
							: ($value="@Get-memory-leaks@")
							: ($value="@4D-Mobile@")
							: ($value="@Using-Relations@")
							: ($value="@List-box-Using-object-arrays-in-columns-4D-View-Pro@")
								
								
								
							: ($value="@4D-ODBC-Driver@")
							: ($value="@4D-ODBC-Pro@")  //external document
							: ($value="@Deprecated-or-removed-features@")  //external document
							: ($value="@4D-for-OCI@")  //external document
							: ($value="@4D-Chart-Language@")  //external document
								
							: (Match regex:C1019(".*4D-Language-Reference.*";$value))  //external document (not to be confused with $anchor
								
							: ($value="@4D-v18x-Release-Notes@")  //external document
								
							: (Match regex:C1019("ftp.+";$value))
							: (Match regex:C1019("http.+";$value))
							: (Match regex:C1019("#.*";$value))
								
							: (Match regex:C1019("\\/Home\\.[a-z]{2}\\.html";$value))  //bad link to index
								
							: (Match regex:C1019("\\/[^/]+\\/index\\.[a-z]{2}\\.html";$value))  //bad link to index
								
								$log:=Folder:C1567(fk logs folder:K87:17).file("bad_link_to_home_page.txt")
								$col:=JSON Parse:C1218($log.getText();Is collection:K8:32)
								$col.push(New object:C1471("file";$file.name;"href";$value))
								$log.setText(JSON Stringify:C1217($col))
								
							: (Match regex:C1019("\\.\\.\\/\\.\\.\\/index\\.[a-z]{2}\\.html";$value))  //bad link to index
								
								$log:=Folder:C1567(fk logs folder:K87:17).file("bad_link_to_home_page.txt")
								$col:=JSON Parse:C1218($log.getText();Is collection:K8:32)
								$col.push(New object:C1471("file";$file.name;"href";$value))
								$log.setText(JSON Stringify:C1217($col))
								
							: (Match regex:C1019("[^?]+\\?&sort=.*";$value))  //table header
								
							: (Match regex:C1019("[.]+\\/.+";$value))
								
								$targetFile:=$file.parent.file($value)  //e.g. ../../path
								
								If (Not:C34($targetFile.exists))
									$_value:=Split string:C1554($value;"/").join("/";ck ignore null or empty:K85:5)
									$targetFile:=$file.parent.file($_value)
									If ($targetFile.exists)
										$log:=Folder:C1567(fk logs folder:K87:17).file("bad_link_double_slash.txt")
										$col:=JSON Parse:C1218($log.getText();Is collection:K8:32)
										$col.push(New object:C1471("file";$file.name;"href";$value))
										$log.setText(JSON Stringify:C1217($col))
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
								$targetFile:=$rootFolder.file($value)
								
							: (Match regex:C1019("\\/[^/]+\\/[^/]+\\/.+";$value))  //e.g. /4D/18/path
								$pathComponents:=Split string:C1554($value;"/")
								$pathComponents.shift()
								$pathComponents.shift()
								$value:=$pathComponents.join("/";ck ignore null or empty:K85:5)
								$targetFile:=$rootFolder.file($value)
								
								If (Not:C34($targetFile.exists))
									$_o_targetFile:=$targetFile.parent.file("o-"+$targetFile.name+$targetFile.extension)
									If ($_o_targetFile.exists)
										$log:=Folder:C1567(fk logs folder:K87:17).file("bad_link_to_obsolete_command.txt")
										$col:=JSON Parse:C1218($log.getText();Is collection:K8:32)
										$col.push(New object:C1471("file";$file.name;"href";$value))
										$log.setText(JSON Stringify:C1217($col))
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
											$log:=Folder:C1567(fk logs folder:K87:17).file("bad_link_wrong_version.txt")
											$col:=JSON Parse:C1218($log.getText();Is collection:K8:32)
											$col.push(New object:C1471("file";$file.name;"href";$value))
											$log.setText(JSON Stringify:C1217($col))
											$value:=$_value
										Else 
											$_o_targetFile:=$targetFile.parent.file("o-"+$targetFile.name+$targetFile.extension)
											If ($_o_targetFile.exists)
												$log:=Folder:C1567(fk logs folder:K87:17).file("bad_link_to_obsolete_command.txt")
												$col:=JSON Parse:C1218($log.getText();Is collection:K8:32)
												$col.push(New object:C1471("file";$file.name;"href";$value))
												$log.setText(JSON Stringify:C1217($col))
												$targetFile:=$_o_targetFile
											Else 
												TRACE:C157
											End if 
										End if 
									End if 
								End if 
								
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
									
									
								: ($value="@Using-4D-Server-64-bit-version-OS-X@")  //obsolete document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Using-a-64-bit-4D-Server-Windows@")  //obsolete document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@User-forms@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Get-memory-leaks@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-Mobile@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Using-Relations@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@List-box-Using-object-arrays-in-columns-4D-View-Pro@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
									  //-------------
									
								: ($value="@4D-ODBC-Driver@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Deprecated-or-removed-features@")  //external document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-ODBC-Pro@")  //external document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-for-OCI@")  //external document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-Installation-Guide@")  //external document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-Chart-Language@")  //external document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: (Match regex:C1019(".*4D-Language-Reference.*";$value))  //external document (not to be confused with $anchor
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-v18x-Release-Notes@")  //external document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: (Match regex:C1019("ftp.+";$value))
								: (Match regex:C1019("http.+";$value))
								: (Match regex:C1019("#.*";$value))
									
								: (Match regex:C1019("\\/Home\\.[a-z]{2}\\.html";$value))
								: (Match regex:C1019("\\/[^/]+\\/index\\.[a-z]{2}\\.html";$value))
								: (Match regex:C1019("\\.\\.\\/\\.\\.\\/index\\.[a-z]{2}\\.html";$value))
								: (Match regex:C1019("[^?]+\\?&sort=.*";$value))
								Else 
									TRACE:C157  //$targetFile#Null
							End case 
						End if 
					End if 
				End if 
			End if 
		End for 
		parse_href ($dom;$file;$rootFolder;$lang)
	End if 
End for 