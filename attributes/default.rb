# directories to be created
default["dir"]["software"] = "/opt/software"
default["dir"]["archive"]  = "/opt/archive"
default["dir"]["jar"]      = "#{default["dir"]["software"]}/jar"
default["dir"]["data"]     = "/opt/data"
default["dir"]["etc"]      = "/usr/local/etc"

# directories existent by default
default["dir"]["bin"]      = "/usr/local/bin"



# squid
default["dir"]["squid"]    = "#{default["dir"]["software"]}/squid-1.9g"




# HG19
default["hg19"]["dirname"] = "hg19"
default["hg19"]["idlarge"] = [
"chr1",
"chr2",
"chr3",
"chr4",
"chr5",
"chr6",
"chr7",
"chr8",
"chr9",
"chr10",
"chr11",
"chr12",
"chr13",
"chr14",
"chr15",
"chr16",
"chr17",
"chr18",
"chr19",
"chr20",
"chr21",
"chr22",
"chrX",
"chrY"
]
default["hg19"]["smallname"] = "small.fa"
default["hg19"]["fullname"] = "hg19.tar"



