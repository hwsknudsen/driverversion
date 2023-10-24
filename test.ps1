$driverversion = Get-PrinterDriver | where {$_.Manufacturer -like "HP"} | Select-Object Name,@{
    n="DriverVersion";e={

        $ver = $_.DriverVersion
        $rev = $ver -band 0xffff
        $build = ($ver -shr 16) -band 0xffff
        $minor = ($ver -shr 32) -band 0xffff
        $major = ($ver -shr 48) -band 0xffff
        "$major.$minor.$build.$rev"

    }
}

$hash = @{ HPUPDDriverVersion = $driverversion.DriverVersion}
return $hash | ConvertTo-Json -Compress
