$ruleName = "External Senders with matching Display Names"
$ruleHtml = "<table class="MsoNormalTable" style="width: 100.0%; mso-cellspacing: 0cm; mso-yfti-tbllook: 1184; mso-table-lspace: 2.25pt; mso-table-rspace: 2.25pt; mso-table-anchor-vertical: paragraph; mso-table-anchor-horizontal: column; mso-table-left: left; mso-padding-alt: 0cm 0cm 0cm 0cm;" border="0" width="&#96;&quot;100%&#96;&quot;" cellspacing="0" cellpadding="0" align="left"><tbody><tr style="mso-yfti-irow: 0; mso-yfti-firstrow: yes; mso-yfti-lastrow: yes;"><td style="background: #FF0000; padding: 5.25pt 1.5pt 5.25pt 1.5pt;">&nbsp;</td><td style="width: 100.0%; background: #BEFF9B; padding: 5.25pt 3.75pt 5.25pt 11.25pt; word-wrap: break-word;" width="&#96;&quot;100%&#96;&quot;"><div><p class="MsoNormal" style="mso-element: frame; mso-element-frame-hspace: 2.25pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-height-rule: exactly;"><span style="font-size: 9.0pt; font-family: &#96;'Segoe UI&#96;',sans-serif; mso-fareast-font-family: &#96;'Times New Roman&#96;'; color: #212121;"><strong>This message was sent from outside the company by someone with a display name matching a user in your organisation. Please do not click links or open attachments unless you recognise the source of this email and know the content is safe. </strong></span></p></div></td></tr></tbody></table>" 
$rule = Get-TransportRule | Where-Object {$_.Identity -contains $ruleName}

$exclude = ("Display names", "to exclude")
$displayNames = (Get-Mailbox -ResultSize unlimited | where {$_.displayname -notin $exclude}).DisplayName

$x = 0
$y = 150
$i = 1
 
do
{
    $dn = $displayNames[$x..$y]
    New-TransportRule -Name ($ruleName + " - Part " +$i) -Priority 0 -FromScope "NotInOrganization" -ApplyHtmlDisclaimerLocation "Prepend" `
        -HeaderMatchesMessageHeader From -HeaderMatchesPatterns $dn -ApplyHtmlDisclaimerText $ruleHtml
    $i++
    $x = $y + 1
    $y = $y + 150
}
until (!$dn)