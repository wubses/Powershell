$tags = "0AAAA00", "1AAAA00" #etc

foreach ($tag in $tags)
{
    $url = "http://www.dell.com/support/home/us/en/04/product-support/servicetag/$tag/research"
    $wrq = Invoke-WebRequest -uri $url -UserAgent ([Microsoft.PowerShell.Commands.PSUserAgent]::InternetExplorer) | select -ExpandProperty rawcontent
    $rgx = [regex]'support.topics.for.your(.+?)(?=\.)'
    $mat = ([regex]::Match($wrq, $rgx) | % { $_.Value })
    $mat.replace('support topics for your', '')
}

#idea taken from https://www.reddit.com/r/PowerShell/comments/49pgaw/i_was_given_a_list_of_dell_asset_tags_they_wanted/
