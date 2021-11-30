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
							: ($value="@On-Server-Startup.301-845407@")
								
								$value:=Replace string:C233($value;"On-Server-Startup.301-845407";"On-Server-Startup-Database-Method.301-5422453";*)
								
							: ($value="@LDAP-LOGIN@")
								
								$value:=Replace string:C233($value;"2005970";"4505637";*)
								$value:=Replace string:C233($value;"/15/LDAP-LOGIN.301-4505637";"/19/LDAP-LOGIN.301-5392297";*)
								
							: ($value="@4D-Environment@")
								
								$value:=Replace string:C233($value;"5652669";"5391560";*)
								
							: ($value="@OBJECT-SET-COLOR@")
								
								$value:=Replace string:C233($value;"OBJECT-SET-COLOR.301-977900";"o-OBJECT-SET-COLOR.301-5391980";*)
								
							: ($value="@Debugger-Shortcuts@")
								
								$value:=Replace string:C233($value;"5652921";"5391868";*)
								
							: ($value="@Custom-Watch-Pane@")
								
								$value:=Replace string:C233($value;"5652915";"5391862";*)
								
							: ($value="@Is-data-file-locked@")
								
								$value:=Replace string:C233($value;"5653564";"5392509";*)
								
							: ($value="@OPEN-DATA-FILE@")
								
								$value:=Replace string:C233($value;"5653584";"5392529";*)
								
							: ($value="@VERIFY-CURRENT-DATA-FILE@")
								
								$value:=Replace string:C233($value;"5653575";"5392520";*)
								
							: ($value="@VERIFY-DATA-FILE@")
								
								$value:=Replace string:C233($value;"5653571";"5392516";*)
								
							: ($value="@entitySelectionisAlterable@")
								$value:=Replace string:C233($value;"305-5290413";"300-5391690";*)
								$value:=Replace string:C233($value;"/4Dv19/4D/18-R5/";"/4Dv19/4D/19/";*)
								
							: ($value="@dataStoremakeSelectionsAlterable@")
								$value:=Replace string:C233($value;"305-5276536";"300-5392032";*)
								$value:=Replace string:C233($value;"/4Dv19/4D/18-R5/";"/4Dv19/4D/19/";*)
								
							: ($value="@Operators@")
								$value:=Replace string:C233($value;"5168924";"5534118";*)
								$value:=Replace string:C233($value;"/4Dv19/4D/18-R4/";"/4Dv19/4D/19/";*)
								
							: ($value="@4D-Installation-Guide@")
								
								  //redirect to current version
								$value:=Replace string:C233($value;"3151284";"54617552";*)
								$value:=Replace string:C233($value;"4844794";"4688909";*)
								
							: ($value="@Deprecated-or-removed-features@")
								  //redirect to current version
								$value:=Replace string:C233($value;"-in-v18-product-range";"";*)
								$value:=Replace string:C233($value;"4822814";"5049565";*)
								$value:=Replace string:C233($value;"4969974";"5049565";*)
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
								
							: ($value="@Documents-precedents@")
								  //redirect to current version
								$value:=Replace string:C233($value;"4822815";"5049567";*)
								$value:=Replace string:C233($value;"4969976";"5049567";*)
								
							: ($value="@WP-EXPORT-DOCUMENT@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"1863636";"5390186";*)
									Else 
										$value:=Replace string:C233($value;"1863636";"4523015";*)
								End case 
								
							: ($value="@WP-EXPORTER-DOCUMENT@")
								$value:=Replace string:C233($value;"1863636";"4523015";*)
								
							: ($value="@WP-EXPORT-VARIABLE@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"1863643";"5390190";*)
									Else 
										$value:=Replace string:C233($value;"1863643";"4523019";*)
								End case 
								
							: ($value="@WP-EXPORTER-VARIABLE@")
								$value:=Replace string:C233($value;"1863643";"4523019";*)
								
							: ($value="@WP-Import-document@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"1863649";"5390187";*)
									Else 
										$value:=Replace string:C233($value;"1863649";"4523016";*)
								End case 
								
							: ($value="@WP-Importer-document@")
								$value:=Replace string:C233($value;"1863649";"4523016";*)
								
							: ($value="@WP-New@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"1863656";"5390203";*)
									Else 
										$value:=Replace string:C233($value;"1863656";"4523032";*)
								End case 
								
							: ($value="@WP-Nouveau@")
								$value:=Replace string:C233($value;"1863656";"4523032";*)
								
							: ($value="@WP-Create-subsection@")
								$value:=Replace string:C233($value;"WP-Create-subsection";"WP-New-subsection";*)
								
							: ($value="@WP-CREATE-BOOKMARK@")
								$value:=Replace string:C233($value;"WP-CREATE-BOOKMARK";"WP-NEW-BOOKMARK";*)
								
							: ($value="@WP-GET-ATTRIBUTES@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"2706357";"5390184";*)
									Else 
										$value:=Replace string:C233($value;"2706357";"4523013";*)
								End case 
								
							: ($value="@WP-LIRE-ATTRIBUTS@")
								$value:=Replace string:C233($value;"2706357";"4523013";*)
								
							: ($value="@WP-SET-ATTRIBUTES@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"2706358";"5390185";*)
									Else 
										$value:=Replace string:C233($value;"2706358";"4523014";*)
								End case 
								
							: ($value="@WP-FIXER-ATTRIBUTS@")
								$value:=Replace string:C233($value;"2706358";"4523014";*)
								
							: ($value="@IC-IMAP-Review-Mail@")
								$value:=Replace string:C233($value;"IC-IMAP-Review-Mail.201-73668";"IC-IMAP-Review-Mail-deprecated.201-5454665";*)
								
							: ($value="@IC-POP3-Review-Mail@")
								$value:=Replace string:C233($value;"IC-POP3-Review-Mail.201-73678";"IC-POP3-Review-Mail-deprecated.201-5454662";*)
								
							: ($value="@Using-4D-Write-Pro-standard-actions@")
								
								$value:=Replace string:C233($value;"200-5390157";"201-5390157";*)
								
							: ($value="@FONT-STYLE-LIST@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"2787404";"5391713";*)
									Else 
										$value:=Replace string:C233($value;"2787404";"4505606";*)
								End case 
								
							: ($value="@4D-Write-Pro-Reference@")
								
								$value:=Replace string:C233($value;"5514109";"5390146";*)
								
							: ($value="@LISTE-STYLES-POLICE@")
								$value:=Replace string:C233($value;"2787404";"4505606";*)
								
							: ($value="@On-Server-Open-Connection-Database-Method@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"4672408";"5422454";*)
										$value:=Replace string:C233($value;"67450";"5422454";*)
									Else 
										$value:=Replace string:C233($value;"67450";"4672408";*)  //lc:4505000
								End case 
								
							: ($value="@On-Server-Close-Connection-Database-Method@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"4672409";"5422455";*)
										$value:=Replace string:C233($value;"67449";"5422455";*)
									Else 
										$value:=Replace string:C233($value;"67449";"4672409";*)  //lc:4505009
								End case 
								
							: ($value="@On-Web-Authentication-Database-Method@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"300-1342178";"301-5392848";*)
										$value:=Replace string:C233($value;"300-977165";"301-5392848";*)
									Else 
										$value:=Replace string:C233($value;"300-977165";"301-4505012";*)  //lowercase:4505012
								End case 
								
							: ($value="@On-Server-Startup-Database-Method@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"67452";"5422453";*)
										$value:=Replace string:C233($value;"4672407";"5422453";*)
									Else 
										$value:=Replace string:C233($value;"67452";"4672407";*)  //lowercase:4505006
								End case 
								
							: ($value="@Creating-a-Server-Database@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"4672444";"5422491";*)
										$value:=Replace string:C233($value;"845398";"5422491";*)
									Else 
										$value:=Replace string:C233($value;"845398";"4672444";*)
								End case 
								
							: ($value="@Checking-Your-Installation@")
								$value:=Replace string:C233($value;"845399";"4672440";*)
								
							: ($value="@Connecting-to-the-Server-Database-with-a-Remote@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"4672445";"5422492";*)
										$value:=Replace string:C233($value;"4672439";"5422492";*)
										$value:=Replace string:C233($value;"845397";"5422492";*)
									Else 
										$value:=Replace string:C233($value;"845397";"4672445";*)
								End case 
								
							: ($value="@Connecting-to-a-4D-Server-Database@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"4672439";"5422486";*)
										$value:=Replace string:C233($value;"845385";"5422486";*)
									Else 
										$value:=Replace string:C233($value;"845385";"4672439";*)
								End case 
								
							: ($value="@Defining-the-Database-Structure@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"4672441";"5422488";*)
										$value:=Replace string:C233($value;"845403";"5422488";*)
									Else 
										$value:=Replace string:C233($value;"845403";"4672441";*)
								End case 
								
							: ($value="@Data-Manipulation-with-4D-Server@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"4672442";"5422489";*)
										$value:=Replace string:C233($value;"845402";"5422489";*)
									Else 
										$value:=Replace string:C233($value;"845402";"4672442";*)
								End case 
								
							: ($value="@Adding-a-Custom-Menu-Bar@")
								$value:=Replace string:C233($value;"845401";"4672446";*)
								
							: ($value="@Exiting-4D-Server@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"4672423";"5422469";*)
										$value:=Replace string:C233($value;"845393";"5422469";*)
									Else 
										$value:=Replace string:C233($value;"845393";"4672423";*)
								End case 
								
							: ($value="@Creating-a-New-4D-Server-Database@")
								$value:=Replace string:C233($value;"845394";"4672422";*)
								
							: ($value="@Registering-a-Database-as-a-Service@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"4672427";"5422473";*)
										$value:=Replace string:C233($value;"845388";"5422473";*)
									Else 
										$value:=Replace string:C233($value;"845388";"4672427";*)
								End case 
								
							: ($value="@Stored-procedures-on-client-machines@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"845413";"5422461";*)
										$value:=Replace string:C233($value;"4672415";"5422461";*)
									Else 
										$value:=Replace string:C233($value;"845413";"4672415";*)
								End case 
								
							: ($value="@Configuration-preferences@")
								$value:=Replace string:C233($value;"Configuration-preferences.300-845386";"Network-and-Client-Server-options.300-4672425";*)
								
							: ($value="@Options-reseau-et-Client-serveur@")
								$value:=Replace string:C233($value;"Options-reseau-et-Client-serveur.300-845386";"Options-reseau-et-Client-serveur.300-4672425";*)
								
							: ($value="@Monitor-Page@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"4672430";"5422476";*)
										$value:=Replace string:C233($value;"845382";"5422476";*)
									Else 
										$value:=Replace string:C233($value;"845382";"4672430";*)
								End case 
								
							: ($value="@Users-Page@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"4672436";"5422482";*)
										$value:=Replace string:C233($value;"845381";"5422482";*)
									Else 
										$value:=Replace string:C233($value;"845381";"4672436";*)
								End case 
								
							: ($value="@GET-ACTIVITY-SNAPSHOT@")
								$value:=Replace string:C233($value;"300-1526735";"301-4504929";*)
								
							: ($value="@LIRE-APERCU-ACTIVITE@")
								$value:=Replace string:C233($value;"300-1526735";"301-4504929";*)
								
							: ($value="@Stored-Procedures@")
								
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"4672416";"5422462";*)
										$value:=Replace string:C233($value;"216966";"5422462";*)
									Else 
										$value:=Replace string:C233($value;"216966";"4672416";*)
										$value:=Replace string:C233($value;"300-67459";"300-4672416";*)
								End case 
								
							: ($value="@Encrypting-ClientServer-Connections@")
								
								Case of 
									: ($rootFolder.fullName="4Dv19")
										$value:=Replace string:C233($value;"4672419";"5422465";*)
										$value:=Replace string:C233($value;"67435";"5422465";*)
									Else 
										$value:=Replace string:C233($value;"67435";"4672419";*)
								End case 
								
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
								
							: ($value="@Etats-rapides@")
								$value:=Replace string:C233($value;"3962803";"4575452";*)
								
							: ($value="@Schnellberichte@")
								$value:=Replace string:C233($value;"3962803";"4575452";*)
								
							: ($value="@VP-EXPORT-DOCUMENT@")
								$value:=Replace string:C233($value;"3426196";"4522260";*)
								
							: ($value="@VP-IMPORT-DOCUMENT@")
								$value:=Replace string:C233($value;"3426190";"4522259";*)
								
							: ($value="@Principles-for-integrating-4D-and-the-4D-SQL-engine@")
								$value:=Replace string:C233($value;"Principles-for-integrating-4D-and-the-4D-SQL-engine.300-72604";"4D-SQL-engine-implementation.300-4650700";*)
								
							: ($value="@Implementations-du-moteur-SQL-de-4D@")
								$value:=Replace string:C233($value;"Implementations-du-moteur-SQL-de-4D.300-72604";"Implementations-du-moteur-SQL-de-4D.300-4650700";*)
								
							: ($value="@SMTP-transportersend@")
								$value:=Replace string:C233($value;"SMTP-transportersend.305-4505974";"SMTP-transportersend.300-4505974";*)
								
							: ($value="@SMTP-transporteursend@")
								$value:=Replace string:C233($value;"SMTP-transporteursend.305-4505974";"SMTP-transporteursend.300-4505974";*)
								
							: ($value="@SMTP-transportercheckConnection.305-4505971@")
								$value:=Replace string:C233($value;"SMTP-transportercheckConnection.305-4505971";"SMTP-transportercheckConnection.300-4505971";*)
								
							: ($value="@SMTP-transporteurcheckConnection.305-4505971@")
								$value:=Replace string:C233($value;"SMTP-transporteurcheckConnection.305-4505971";"SMTP-transporteurcheckConnection.300-4505971";*)
								
							: ($value="@transportercheckConnection.305-4505971@")
								$value:=Replace string:C233($value;"transportercheckConnection.305-4505971";"SMTP-transportercheckConnection.300-4505971";*)
								
							: ($value="@transporteurcheckConnection.305-4505971@")
								$value:=Replace string:C233($value;"transporteurcheckConnection.305-4505971";"SMTP-transporteurcheckConnection.300-4505971";*)
								
							: ($value="@Field-properties@")
								$value:=Replace string:C233($value;"1477337";"4575567";*)
								
							: ($value="@Feldeigenschaften@")
								$value:=Replace string:C233($value;"1477337";"4575567";*)
								
							: ($value="@Proprietes-des-champs@")
								$value:=Replace string:C233($value;"1477337";"4575567";*)
								
							: ($value="@Proprietes-des-tables@")
								$value:=Replace string:C233($value;"4575566";"4575566";*)
								
							: ($value="@IP-Configuration@")
								$value:=Replace string:C233($value;"IP-Configuration.300-845391";"IP-Settings.300-4672424";*)
								
							: ($value="@Configuration-IP@")
								$value:=Replace string:C233($value;"Configuration-IP.300-845391";"Reglages-IP.300-4672424";*)
								
							: ($value="@Web-server-configuration-and-connection-management@")
								$value:=Replace string:C233($value;"977167";"4504720";*)
								$value:=Replace string:C233($value;"300-205403";"300-4504720";*)
								
							: ($value="@Mise-en-route-du-serveur-Web-et-gestion-des-connexions@")
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
								
							: ($value="@Interface-ligne-de-commande-CLI-etendue.300-1570420@")
								
								If ($file.name="@300-4575466@")
									  //bad link in source
								Else 
									$value:=Replace string:C233($value;"Interface-ligne-de-commande-CLI-etendue.300-1570420";"Interface-ligne-de-commande.300-4575704";*)
								End if 
								
							: ($value="@dataStoreprovideDataKey@")
								$value:=Replace string:C233($value;"dataStoreprovideDataKey.305-4505925";"dataStoreprovideDataKey.300-4505925";*)
								$value:=Replace string:C233($value;"dataStoreprovideDataKey.305-5392029";"dataStoreprovideDataKey.300-5392029";*)
								
							: ($value="@Connection-Security@")
								$value:=Replace string:C233($value;"205401";"4504721";*)
								$value:=Replace string:C233($value;"977166";"4504721";*)
								
							: ($value="@Securite-des-connexions@")
								$value:=Replace string:C233($value;"205401";"4504721";*)
								$value:=Replace string:C233($value;"977166";"4504721";*)
								
							: ($value="@4D-field-types@")
								$value:=Replace string:C233($value;"1477338";"4575568";*)
								
							: ($value="@4D-Datenfeldtypen@")
								$value:=Replace string:C233($value;"1477338";"4575568";*)
								
							: ($value="@Types-de-champs-4D@")
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
								
							: ($value="@Editeur-d-etiquettes@")
								$value:=Replace string:C233($value;"1477096";"4575451";*)
								
							: ($value="@Exploitation-des-liens@")
								$value:=Replace string:C233($value;"Exploitation-des-liens.200-1517499";"Proprietes-des-liens.300-4575565";*)
								
							: ($value="@List-subforms@")
								$value:=Replace string:C233($value;"1016001";"4575635";*)
								
							: ($value="@Unterformulare-als-Liste@")
								$value:=Replace string:C233($value;"1016001";"4575635";*)
								
							: ($value="@Sous-formulaires-en-liste@")
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
								
							: ($value="@Parametrages-du-serveur-Web.300-4504709@")
								
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
								
							: ($value="@Methode-base-Sur-authentification-Web.300-977165@")
								$value:=Replace string:C233($value;"Methode-base-Sur-authentification-Web.300-977165";"Methode-base-Sur-authentification-Web.301-4505012";*)
								
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
								
							: ($value="@Page-SQL.300-4575466.@")
								
							: ($value="@SQL.300-4575466@")
								$value:=Replace string:C233($value;"SQL.300-4575466";"SQL-page.300-4575466";*)
								
							: ($value="@-.300-4575476@")
								$value:=Replace string:C233($value;"-.300-4575476";"Compatibility-page.300-4575476";*)
								
							: ($value="@-.300-4672425@")
								$value:=Replace string:C233($value;"-.300-4672425";"Network-and-Client-Server-options.300-4672425";*)
								
							: ($value="@-.300-4575704@")
								$value:=Replace string:C233($value;"-.300-4575704";"Command-Line-Interface.300-4575704";*)
								
							: ($value="@Connexion-a-une-base-4D-Server.300-4672439@")
								
							: ($value="@4D-Server.300-4672439@")
								$value:=Replace string:C233($value;"4D-Server.300-4672439";"Connecting-to-a-4D-Server-Database.300-4672439";*)
								
							: ($value="@Ressources.300-977556@")
								$value:=Replace string:C233($value;"300-977556";"300-4505047";*)
								
							: ($value="@-.300-4505257@")
								$value:=Replace string:C233($value;"-.300-4505257";"Window-Types-compatibility.300-4505257";*)
								
							: ($value="@collectionsort@")
								$value:=Replace string:C233($value;"collectionsort.305-4505853";"collectionsort.300-4505853";*)
								$value:=Replace string:C233($value;"collectionsort.305-5392076";"collectionsort.300-5392076";*)
								
							: ($value="@Overview-of-SQL-Commands@")
								$value:=Replace string:C233($value;"977496";"4505595";*)
								
							: ($value="@SQL.302-977600@")
								$value:=Replace string:C233($value;"SQL.302-977600";"SQL.302-4504445";*)
								
							: ($value="%20http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html")
								$value:="http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html"
								  //WA-GET-LAST-URL-ERROR.301-4504842.en.html
								
							: ($value="@4D-HTML-Tags@")
								$value:=Replace string:C233($value;"4D-HTML-Tags.300-1342175";"4D-Transformation-Tags.300-4505674";*)
								
							: ($value="@Balises-HTML-4D@")
								$value:=Replace string:C233($value;"Balises-HTML-4D.300-1342175";"Balises-de-transformation-4D.300-4505674";*)
								
							: ($value="@Multi-style-Rich-text-area@")
								$value:=Replace string:C233($value;"1477147";"4575616";*)
								
							: ($value="@Text-mit-Stil-Rich-Text@")
								$value:=Replace string:C233($value;"1477147";"4575616";*)
								
							: ($value="@Multistyle-Zone-de-texte-riche@")
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
								
							: ($value="@UTILISER-PARAMETRES-IMPRESSION@")
								$value:=Replace string:C233($value;"UTILISER-PARAMETRES-IMPRESSION.301-977802";"o-UTILISER-PARAMETRES-IMPRESSION.301-4505822";*)
								
							: ($value="@FORMULAIRE-ENTREE@")
								$value:=Replace string:C233($value;"FORMULAIRE-ENTREE.301-206114";"FORM-FIXER-ENTREE.301-4505766";*)
								
							: ($value="@INPUT-FORM@")
								$value:=Replace string:C233($value;"INPUT-FORM.301-206114";"FORM-SET-INPUT.301-4505766";*)
								
							: ($value="@System-Documents@")
								$value:=Replace string:C233($value;"System-Documents.201-4504290";"System-Documents.300-4504519";*)
								
							: ($value="@ADD-SUBRECORD@")
								$value:=Replace string:C233($value;"ADD-SUBRECORD.301-206192";"o-ADD-SUBRECORD.301-4506007";*)
								
							: ($value="@AJOUTER-SOUS-ENREGISTREMENT@")
								$value:=Replace string:C233($value;"AJOUTER-SOUS-ENREGISTREMENT.301-206192";"o-AJOUTER-SOUS-ENREGISTREMENT.301-4506007";*)
								
							: ($value="@C-GRAPHE@")
								$value:=Replace string:C233($value;"C-GRAPHE.301-206209";"o-C-GRAPHE.301-4506032";*)
								
							: ($value="@MODIFY-SUBRECORD@")
								$value:=Replace string:C233($value;"MODIFY-SUBRECORD.301-206191";"o-MODIFY-SUBRECORD.301-4506008";*)
								
							: ($value="@MODIFIER-SOUS-ENREGISTREMENT@")
								$value:=Replace string:C233($value;"MODIFIER-SOUS-ENREGISTREMENT.301-206191";"o-MODIFIER-SOUS-ENREGISTREMENT.301-4506008";*)
								
							: ($value="@FORM-GET-PARAMETER@")
								$value:=Replace string:C233($value;"FORM-GET-PARAMETER.301-978100";"o-FORM-GET-PARAMETER.301-4506030";*)
								
							: ($value="@folderfiles@")
								$value:=Replace string:C233($value;"305-4506056";"300-4506056";*)
								
							: ($value="@dossierfiles@")
								$value:=Replace string:C233($value;"305-4506056";"300-4506056";*)
								
							: ($value="@folderfile@")
								$value:=Replace string:C233($value;"305-4506054";"300-4506054";*)
								
							: ($value="@dossierfile@")
								$value:=Replace string:C233($value;"305-4506054";"300-4506054";*)
								
							: ($value="@folderfolders@")
								$value:=Replace string:C233($value;"305-4506055";"300-4506055";*)
								
							: ($value="@dossierfolders@")
								$value:=Replace string:C233($value;"305-4506055";"300-4506055";*)
								
							: ($value="@folderfolder@")
								$value:=Replace string:C233($value;"305-4506053";"300-4506053";*)
								
							: ($value="@dossierfolder@")
								$value:=Replace string:C233($value;"305-4506053";"300-4506053";*)
								
							: ($value="@filecopyTo@")
								$value:=Replace string:C233($value;"305-4506082";"300-4506082";*)
								
							: ($value="@fichiercopyTo@")
								$value:=Replace string:C233($value;"305-4506082";"300-4506082";*)
								
							: ($value="@filecreateAlias@")
								$value:=Replace string:C233($value;"305-4506090";"300-4506090";*)
								
							: ($value="@fichiercreateAlias@")
								$value:=Replace string:C233($value;"305-4506090";"300-4506090";*)
								
							: ($value="@filecreate@")
								$value:=Replace string:C233($value;"305-4506085";"300-4506085";*)
								
							: ($value="@fichiercreate@")
								$value:=Replace string:C233($value;"305-4506085";"300-4506085";*)
								
							: ($value="@filedelete@")
								$value:=Replace string:C233($value;"305-4506084";"300-4506084";*)
								
							: ($value="@fichierdelete@")
								$value:=Replace string:C233($value;"305-4506084";"300-4506084";*)
								
							: ($value="@filegetContent@")
								$value:=Replace string:C233($value;"305-4506086";"300-4506086";*)
								
							: ($value="@fichiergetContent@")
								$value:=Replace string:C233($value;"305-4506086";"300-4506086";*)
								
							: ($value="@filegetIcon@")
								$value:=Replace string:C233($value;"305-4506065";"300-4506065";*)
								
							: ($value="@fichiergetIcon@")
								$value:=Replace string:C233($value;"305-4506065";"300-4506065";*)
								
							: ($value="@filegetText@")
								$value:=Replace string:C233($value;"305-4506088";"300-4506088";*)
								
							: ($value="@fichiergetText@")
								$value:=Replace string:C233($value;"305-4506088";"300-4506088";*)
								
							: ($value="@filemoveTo@")
								$value:=Replace string:C233($value;"305-4506083";"300-4506083";*)
								
							: ($value="@fichiermoveTo@")
								$value:=Replace string:C233($value;"305-4506083";"300-4506083";*)
								
							: ($value="@filerename@")
								$value:=Replace string:C233($value;"305-4506081";"300-4506081";*)
								
							: ($value="@fichierrename@")
								$value:=Replace string:C233($value;"305-4506081";"300-4506081";*)
								
							: ($value="@filesetContent@")
								$value:=Replace string:C233($value;"305-4506087";"300-4506087";*)
								
							: ($value="@fichiersetContent@")
								$value:=Replace string:C233($value;"305-4506087";"300-4506087";*)
								
							: ($value="@filesetText@")
								$value:=Replace string:C233($value;"305-4506089";"300-4506089";*)
								
							: ($value="@fichiersetText@")
								$value:=Replace string:C233($value;"305-4506089";"300-4506089";*)
								
							: ($value="@foldercopyTo@")
								$value:=Replace string:C233($value;"305-4506059";"300-4506059";*)
								
							: ($value="@dossiercopyTo@")
								$value:=Replace string:C233($value;"305-4506059";"300-4506059";*)
								
							: ($value="@foldercreateAlias@")
								$value:=Replace string:C233($value;"305-4506063";"300-4506063";*)
								
							: ($value="@dossiercreateAlias@")
								$value:=Replace string:C233($value;"305-4506063";"300-4506063";*)
								
							: ($value="@foldercreate@")
								$value:=Replace string:C233($value;"305-4506062";"300-4506062";*)
								
							: ($value="@dossiercreate@")
								$value:=Replace string:C233($value;"305-4506062";"300-4506062";*)
								
							: ($value="@folderdelete@")
								$value:=Replace string:C233($value;"305-4506061";"300-4506061";*)
								
							: ($value="@dossierdelete@")
								$value:=Replace string:C233($value;"305-4506061";"300-4506061";*)
								
							: ($value="@foldergetIcon@")
								$value:=Replace string:C233($value;"305-4506057";"300-4506057";*)
								
							: ($value="@dossiergetIcon@")
								$value:=Replace string:C233($value;"305-4506057";"300-4506057";*)
								
							: ($value="@foldermoveTo@")
								$value:=Replace string:C233($value;"305-4506060";"300-4506060";*)
								
							: ($value="@dossiermoveTo@")
								$value:=Replace string:C233($value;"305-4506060";"300-4506060";*)
								
							: ($value="@folderrename@")
								$value:=Replace string:C233($value;"305-4506058";"300-4506058";*)
								
							: ($value="@dossierrename@")
								$value:=Replace string:C233($value;"305-4506058";"300-4506058";*)
								
							: ($value="@folderfolders@")
								$value:=Replace string:C233($value;"305-4506055";"300-4506055";*)
								
							: ($value="@dossierfolders@")
								$value:=Replace string:C233($value;"305-4506055";"300-4506055";*)
								
							: ($value="@formulaapply@")
								$value:=Replace string:C233($value;"305-4505752";"300-4505752";*)
								
							: ($value="@formuleapply@")
								$value:=Replace string:C233($value;"305-4505752";"300-4505752";*)
								
							: ($value="@formulacall@")
								$value:=Replace string:C233($value;"305-4505751";"300-4505751";*)
								
							: ($value="@formulecall@")
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
								
							: ($value="@transporteursend@")
								$value:=Replace string:C233($value;"transporteursend.305-4505974";"SMTP-transporteursend.300-4505974";*)
								
							: ($value="@attachmentgetContent@")
								$value:=Replace string:C233($value;"305-4611486";"300-4611486";*)
								
							: ($value="@piecejointegetContent@")
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
								
							: ($value="@Presentation-des-commandes-XML-DOM@")
								$value:=Replace string:C233($value;"300-205309";"300-4504762";*)
								
							: ($value="@4D-SQL-engine-implementation.300-4650700@")
								  //"Next page"
								
							: ($value="@Implementations-du-moteur-SQL-de-4D.300-4650700@")
								  //"Next page"
								
							: ($value="@Installationshandbuch@")
								$value:=Replace string:C233($value;"100-4844794";"100-4688909";*)
								
							: ($value="@Installation@")
								$value:=Replace string:C233($value;"100-4844794";"100-4688909";*)
								
							: ($value="@18/Anderungen-und-Aktualisierungen@")
								$value:=Replace string:C233($value;"18/Anderungen-und-Aktualisierungen.200-4822816";"18.2/Anderungen-und-Aktualisierungen.200-5049566";*)
								$value:=Replace string:C233($value;"18/Anderungen-und-Aktualisierungen.200-4969975";"18.2/Anderungen-und-Aktualisierungen.200-5049566";*)
								
							: ($value="@18/Modifications-et-mises-a-jour@")
								$value:=Replace string:C233($value;"18/Modifications-et-mises-a-jour.200-4822816";"18.2/Modifications-et-mises-a-jour.200-5049566";*)
								$value:=Replace string:C233($value;"18/Modifications-et-mises-a-jour.200-4969975";"18.2/Modifications-et-mises-a-jour.200-5049566";*)
								
							: ($value="@18.1/Modifications-et-mises-a-jour@")
								$value:=Replace string:C233($value;"18.1/Modifications-et-mises-a-jour.200-4822816";"18.2/Modifications-et-mises-a-jour.200-5049566";*)
								$value:=Replace string:C233($value;"18.1/Modifications-et-mises-a-jour.200-4969975";"18.2/Modifications-et-mises-a-jour.200-5049566";*)
								
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
								
							: ($value="@Proprietes-des-objets.300-977887@")
								$value:=Replace string:C233($value;"Proprietes-des-objets.300-977887";"Objets-de-formulaires.300-4505419";*)
								
							: ($value="@Transaction-active@")
								$value:=Replace string:C233($value;"301-2773925";"301-4504561";*)
								
							: ($value="@Methode-base-Sur-authentification-Web.300-976978@")
								$value:=Replace string:C233($value;"300-976978";"300-4504707";*)
								
							: ($value="@o-OBJET-FIXER-COULEUR@")
								
							: ($value="@OBJET-FIXER-COULEUR@")
								$value:=Replace string:C233($value;"OBJET-FIXER-COULEUR.301-4505453";"o-OBJET-FIXER-COULEUR.301-4505453";*)
								
							: ($value="@APPELER-PROCESS@")
								$value:=Replace string:C233($value;"APPELER-PROCESS.301-977781";"GENERER-APPEL-EXTERIEUR.301-4505034";*)
								
							: ($value="@OBJET-FIXER-NOM-ENUMERATION@")
								$value:=Replace string:C233($value;"OBJET-FIXER-NOM-ENUMERATION.301-977902";"OBJET-FIXER-LISTE-PAR-NOM.301-4505451";*)
								
							: ($value="@Pendant@")
								$value:=Replace string:C233($value;"Pendant.301-978118";"o-Pendant.301-4506000";*)
								
							: ($value="@REDESSINER-LISTE.301-978086@")
								$value:=Replace string:C233($value;"REDESSINER-LISTE.301-978086";"o-REDESSINER-LISTE.301-4506029";*)
								
							: ($value="@Configuration-and-trace-files.300-4575598.de@")
								$value:=Replace string:C233($value;"Configuration-and-trace-files.300-4575598";"Konfiguration-und-Dateien-verfolgen.300-4575598";*)
								
							: ($value="@Introduction@")
								
								$value:=Replace string:C233($value;"200-5652664";"300-5447438";*)
								
							: ($value="@Copyrights-and-Legal-notices@")
								
								$value:=Replace string:C233($value;"300-5653413";"300-5392358";*)
								
							: ($value="@Preface@")
								
								$value:=Replace string:C233($value;"5653412";"5454680";*)
								
							: ($value="@Debugging@")
								
								$value:=Replace string:C233($value;"5652637";"5391527";*)
								
								
								
								
							: ($value="@Syntax-Error-Window@")
								
								$value:=Replace string:C233($value;"5652919";"5391866";*)
								
							: ($value="@Debugger@")
								
								$value:=Replace string:C233($value;"5652917";"5391864";*)
								$value:=Replace string:C233($value;"5652911";"5391858";*)
								
							: ($value="@Watch-Pane@")
								
								$value:=Replace string:C233($value;"5652916";"5391863";*)
								
							: ($value="@Call-Chain-Pane@")
								
								$value:=Replace string:C233($value;"5652920";"5391867";*)
								
							: ($value="@Source-Code-Pane@")
								
								$value:=Replace string:C233($value;"5652912";"5391859";*)
								
							: ($value="@Break-Points@")
								
								$value:=Replace string:C233($value;"5652918";"5391865";*)
								
							: ($value="@Break-List@")
								
								$value:=Replace string:C233($value;"5652914";"5391861";*)
								
							: ($value="@Catching-Commands@")
								
								$value:=Replace string:C233($value;"5652913";"5391860";*)
								
							: ($value="@System-Variables@")
								
								$value:=Replace string:C233($value;"5653558";"5392503";*)
								
							: ($value="@Application-file@")
								
								$value:=Replace string:C233($value;"5653581";"5392526";*)
								
							: ($value="@Application-type@")
								
								$value:=Replace string:C233($value;"5653565";"5392510";*)
								
							: ($value="@Application-version@")
								
								$value:=Replace string:C233($value;"5653582";"5392527";*)
								
							: ($value="@BUILD-APPLICATION@")
								
								$value:=Replace string:C233($value;"5653578";"5392523";*)
								
							: ($value="@Compact-data-file@")
								
								$value:=Replace string:C233($value;"5653577";"5392522";*)
								
							: ($value="@COMPONENT-LIST@")
								
								$value:=Replace string:C233($value;"5653576";"5392521";*)
								
							: ($value="@CREATE-DATA-FILE@")
								
								$value:=Replace string:C233($value;"5653559";"5392504";*)
								
							: ($value="@Data-file@")
								
								$value:=Replace string:C233($value;"5653580";"5392525";*)
								
							: ($value="@DROP-REMOTE-USER@")
								
								$value:=Replace string:C233($value;"5653595";"5392540";*)
								
							: ($value="@Export-structure-file@")
								
								$value:=Replace string:C233($value;"5653561";"5392506";*)
								
							: ($value="@Get-4D-file@")
								
								$value:=Replace string:C233($value;"5653563";"5392508";*)
								
							: ($value="@Get-4D-folder@")
								
								$value:=Replace string:C233($value;"5653583";"5392528";*)
								
							: ($value="@Get-application-info@")
								
								$value:=Replace string:C233($value;"5653562";"5392507";*)
								
							: ($value="@Get-database-localization@")
								
								$value:=Replace string:C233($value;"5653589";"5392534";*)
								
							: ($value="@Get-database-measures@")
								
								$value:=Replace string:C233($value;"5653586";"5392531";*)
								
							: ($value="@Get-database-parameter@")
								
								$value:=Replace string:C233($value;"5653579";"5392524";*)
								
							: ($value="@Get-last-update-log-path@")
								
								$value:=Replace string:C233($value;"5653591";"5392536";*)
								
							: ($value="@Get-table-fragmentation@")
								
								$value:=Replace string:C233($value;"5653569";"5392514";*)
								
							: ($value="@Is-compiled-mode@")
								
								$value:=Replace string:C233($value;"5653560";"5392505";*)
								
							: ($value="@NOTIFY-RESOURCES-FOLDER-MODIFICATION@")
								
								$value:=Replace string:C233($value;"5653573";"5392518";*)
								
							: ($value="@OPEN-ADMINISTRATION-WINDOW@")
								
								$value:=Replace string:C233($value;"5653572";"5392517";*)
								
								
							: ($value="@OPEN-DATABASE@")
								
								$value:=Replace string:C233($value;"5653587";"5392532";*)
								
							: ($value="@OPEN-SECURITY-CENTER@")
								
								$value:=Replace string:C233($value;"5653574";"5392519";*)
								
							: ($value="@OPEN-SETTINGS-WINDOW@")
								
								$value:=Replace string:C233($value;"5653593";"5392538";*)
								
							: ($value="@PLUGIN-LIST@")
								
								$value:=Replace string:C233($value;"5653592";"5392537";*)
								
							: ($value="@QUIT@")
								
								$value:=Replace string:C233($value;"5653588";"5392533";*)
								
							: ($value="@REJECT-NEW-REMOTE-CONNECTIONS@")
								
								$value:=Replace string:C233($value;"5653596";"5392541";*)
								
							: ($value="@RELOAD-PROJECT@")
								
								$value:=Replace string:C233($value;"5653597";"5392542";*)
								
							: ($value="@RESTART-4D@")
								
								$value:=Replace string:C233($value;"5653568";"5392513";*)
								
							: ($value="@SEND-MESSAGE-TO-REMOTE-USER@")
								
								$value:=Replace string:C233($value;"5653594";"5392539";*)
								
							: ($value="@SET-DATABASE-LOCALIZATION@")
								
								$value:=Replace string:C233($value;"5653567";"5392512";*)
								
							: ($value="@SET-DATABASE-PARAMETER@")
								
								$value:=Replace string:C233($value;"5653585";"5392530";*)
								
							: ($value="@SET-UPDATE-FOLDER@")
								
								$value:=Replace string:C233($value;"5653570";"5392515";*)
								
							: ($value="@Structure-file@")
								
								$value:=Replace string:C233($value;"5653590";"5392535";*)
								
							: ($value="@Version-type@")
								
								$value:=Replace string:C233($value;"5653566";"5392511";*)
								
							: ($value="@BLOB@")
								
								$value:=Replace string:C233($value;"5652673";"5391564";*)
								
						End case 
						
						$targetFile:=Null:C1517
						
						Case of 
							: ($suffix#$lang)  //language switcher
							: ($value="@Language-definition@")
							: ($value="@INVERSER-FOND@")
							: ($value="@AJOUTER-SEGMENT-DE-DONNEES@")
							: ($value="@Utiliser-4D-Server-64-bits-Windows@")
							: ($value="@Changing-from-32-bit-versions-to-64-bit-versions@")
							: ($value="@Utiliser-4D-Server-64-bits-OS-X@")
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
							: ($value="@Interface-ligne-de-commande-CLI-etendue@") & ($file.name="@300-4575466@")
							: ($value="@Fonctionnalites-obsoletes-ou-supprimees@")
							: ($value="@Plugins.300-3610991@")
							: ($value="@Presentation-des-formulaires-utilisateurs.300-1342077@")
							: ($value="@Passer-de-32-bits-a-64-bits@")
							: ($value="@Gestion-des-List-box-hierarchiques@")
							: ($value="@Formulaires-utilisateurs.200-1477106@")
							: ($value="@List-box-Utiliser-des-tableaux-objets-dans-les-colonnes-4D-View-Pro@")
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
							: ($value="@Creer-fenetre-externe@")
							: ($value="@Managing-Hierarchical-List-Boxes@")
							: ($value="@4D-ODBC-Driver@")
							: ($value="@4D-ODBC-Pro@")
							: ($value="@Alignement-objet.302-977619@")
							: ($value="@Deprecated-and-removed-features@")
							: ($value="@4D-for-OCI@")
							: ($value="@4D-Chart.100-70986@")
							: ($value="@4D-Chart-Language@")
							: ($value="@4D-Chart-Programmiersprache@")
							: ($value="@4D-Programmiersprache-18@")
							: (Match regex:C1019(".*Vorherige-Dokumente.*";$value))
							: (Match regex:C1019(".*4D-Language-Reference.*";$value))
							: ($value="@4D-v18x-Release-Notes@")
							: ($value="@4D-v19x-Release-Notes@")
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
												
												Case of 
													: ($rootFolder.fullName="4Dv19")
														$value:=Replace string:C233($value;"888661";"5462039";*)
													Else 
														$value:=Replace string:C233($value;"888661";"4611817";*)
												End case 
												
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
											
											Case of 
												: ($value="@UseEnd-use@")
												: ($value="@Connection-Security@")
												: ($value="@Information-about-the-Web-Site@")
												: ($value="@URLs-and-Form-Actions@")
												: ($value="@Semi-dynamic-pages@")
												: ($value="@IMAP-transportercheckConnection@")
												: ($value="@IMAP-transportergetMail@")
												: ($value="@POP3-transportercheckConnection@")
												: ($value="@SMTP-transportercheckConnection@")
												: ($value="@Web-Server-Settings@")
												: ($value="@Deprecated-or-removed-features@")
												: ($value="@Project-Methods@")
												: ($value="@Web-Server-Overview@")
												: ($value="@transportersend@")
												: ($value="@POP3-transportergetMail@")
												: ($value="@Support-of-IPv6@")
												: ($value="@UseEnd-use@")
												: ($value="@Comparison-Operators@")
												: ($value="@BLOB-Commands@")
												: ($value="@Web-server-configuration-and-connection-management@")
												: ($value="@Identifiers@")
													
													  //external site
													
												Else 
													$_o_targetFile:=$targetFile.parent.file("o-"+$targetFile.name+$targetFile.extension)
													If ($_o_targetFile.exists)
														
														$log:=New object:C1471
														$log.path:=$file.path
														$log.href:=$value
														$params.LOG_PUSH("warning_link_to_wrong_version";$log)
														
														$targetFile:=$_o_targetFile
													Else 
														
														$found:=False:C215
														
														$value:=File:C1566($value).name+File:C1566($value).extension
														
														If (Match regex:C1019("(.+\\.)[^.]+(\\.[a-z]{2})\\.html";$value;1;$pos;$len))
															$command:=Substring:C12($value;$pos{1};$len{1})
															$language:=Substring:C12($value;$pos{2};$len{2})
															$files:=$file.parent.files().query("name == :1";$command+"@"+$language)
															If ($files.length#0)
																$targetFile:=$files[0]
																$found:=True:C214
															End if 
														End if 
														
														If (Not:C34($found))
															TRACE:C157  //$targetFile.exists
														End if 
														
													End if 
											End case 
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
								Case of 
									: ($value="@Connection-Security@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@Information-about-the-Web-Site@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@URLs-and-Form-Actions@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@Semi-dynamic-pages@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@Deprecated-or-removed-features@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@Language-definition@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@Project-Methods@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@Web-Server-Overview@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@transportersend@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@POP3-transportergetMail@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@Support-of-IPv6@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@Web-Server-Settings@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@SMTP-transportercheckConnection@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@POP3-transportercheckConnection@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@IMAP-transportergetMail@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@IMAP-transportercheckConnection@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@UseEnd-use@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									: ($value="@Comparison-Operators@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@BLOB-Commands@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@Web-server-configuration-and-connection-management@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@Identifiers@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@-.300-5416795@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@-.300-5416917@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@-.300-5416903@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@Web.300-5391806@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@Web.300-5391824@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@Web.300-5391818@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@Maintenance-Security-Center.200-5416620@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@D.300-3561799@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@-.300-3630358@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@-.300-1477320@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									: ($value="@B-4D.300-1477413@")
										DOM SET XML ATTRIBUTE:C866($dom;"href";"")
										
									Else 
										
										$found:=False:C215
										
										$value:=File:C1566($value).name+File:C1566($value).extension
										
										If (Match regex:C1019("(.+\\.)[^.]+(\\.[a-z]{2})\\.html";$value;1;$pos;$len))
											$command:=Substring:C12($value;$pos{1};$len{1})
											$language:=Substring:C12($value;$pos{2};$len{2})
											$files:=$file.parent.files().query("name == :1";$command+"@"+$language)
											If ($files.length#0)
												$targetFile:=$files[0]
												$found:=True:C214
											End if 
										End if 
										
										If (Not:C34($found))
											TRACE:C157  //$targetFile.exists
										End if 
								End case 
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
									
								: ($value="@Presentation-des-formulaires-utilisateurs.300-1342077@")
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
									
								: ($value="@Gestion-des-List-box-hierarchiques@")
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
									
								: ($value="@Plugins.300-3610991@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Passer-de-32-bits-a-64-bits@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-ODBC-Driver@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@List-box-Utiliser-des-tableaux-objets-dans-les-colonnes-4D-View-Pro@")  //external document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Deprecated-and-removed-features@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Fonctionnalites-obsoletes-ou-supprimees@")  //external document
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
									
								: ($value="@Interface-ligne-de-commande-CLI-etendue@") & ($file.name="@300-4575466@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-Programmiersprache-18@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-Chart.100-70986@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Utiliser-4D-Server-64-bits-OS-X@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Utiliser-4D-Server-64-bits-Windows@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Creer-fenetre-externe@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@INVERSER-FOND@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: (Match regex:C1019(".*4D-Language-Reference.*";$value))  //external document (not to be confused with SQL chapter which is lower case)
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: (Match regex:C1019(".*Vorherige-Dokumente.*";$value))  //external document (not to be confused with SQL chapter which is lower case)
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@4D-v18x-Release-Notes@")  //external document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
								: ($value="@4D-v19x-Release-Notes@")  //external document
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Formulaires-utilisateurs.200-1477106@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Alignement-objet.302-977619@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@AJOUTER-SEGMENT-DE-DONNEES@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Deprecated-or-removed-features@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Language-definition@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Web-Server-Settings@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@SMTP-transportercheckConnection@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@POP3-transportercheckConnection@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@IMAP-transportergetMail@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@IMAP-transportercheckConnection@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Information-about-the-Web-Site@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@URLs-and-Form-Actions@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Semi-dynamic-pages@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Connection-Security@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@UseEnd-use@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Comparison-Operators@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@BLOB-Commands@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Web-server-configuration-and-connection-management@")
									DOM SET XML ATTRIBUTE:C866($dom;"href";"")
									
								: ($value="@Identifiers@")
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