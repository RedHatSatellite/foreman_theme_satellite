# File that covers update of bootdisk help page. Bootdisk plugin allows four types of bootdisk. Satellite supports only
# two of them.

# removing Host image from bootdisk help page

Deface::Override.new(:virtual_path  => "foreman_bootdisk/disks/help",
                     :name          => "remove header for host image",
                     :replace        => "div#welcome h3:nth-of-type(1)",
                     :text => '')

Deface::Override.new(:virtual_path  => "foreman_bootdisk/disks/help",
                     :name          => "remove first paragraph of host image",
                     :replace        => "div#welcome p:nth-of-type(4)",
                     :text => '')

Deface::Override.new(:virtual_path  => "foreman_bootdisk/disks/help",
                     :name          => "remove second paragraph of host image",
                     :replace       => "div#welcome p:nth-of-type(4)",
                     :text => '')


# removing Generic image from bootdisk help page

Deface::Override.new(:virtual_path  => "foreman_bootdisk/disks/help",
                     :name          => "remove header of generic image",
                     :replace       => "div#welcome h3:nth-of-type(2)",
                     :text => '')

Deface::Override.new(:virtual_path  => "foreman_bootdisk/disks/help",
                     :name          => "remove first paragraph of generic image",
                     :replace       => "div#welcome p:nth-of-type(6)",
                     :text => '')

Deface::Override.new(:virtual_path  => "foreman_bootdisk/disks/help",
                     :name          => "remove second paragraph of generic image",
                     :replace       => "div#welcome p:nth-of-type(6)",
                     :text => '')

# removing note about disabled bootdisk types

Deface::Override.new(:virtual_path  => "foreman_bootdisk/disks/help",
                     :name          => "remove * note",
                     :replace       => "div#welcome p:nth-of-type(8)",
                     :text => '')
