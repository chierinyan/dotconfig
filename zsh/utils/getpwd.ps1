# > getpwd.ps1 0 0 0
# Ay00-7Ofr/mL0J-cpEB

if ($args.Length -ne 3) { return }
$b64 = [Convert]::ToBase64String([System.Security.Cryptography.SHA256]::Create().ComputeHash(
    [Text.Encoding]::UTF8.GetBytes("$args Ciallo~")))
return "Ay00-$($b64.Substring(0, 4))/$($b64.Substring(4, 4))-$($b64.Substring(8, 4))"
