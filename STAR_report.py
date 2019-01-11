import glob, os

#guillem ylla January 2019
##python2.7

outfile = open("Mapping_Summary.txt","w") 
 
outfile.write('\t'.join(["Sample","#Reads","# Mapped reads", "% mapped reads","%Unmapped - too short","\n"]))

for file in os.listdir("."):
    if file.endswith(".final.out"):
        #print(os.path.join("/mydir", file))
	samplename=file.split("Log")[0]
	filepath=os.path.join(file)
	with open(filepath) as f:
		for line in f:
			if "Number of input reads" in line:
				inputreads=line.split("\t")[1].rstrip()
				#print(inputreads)
			if "Uniquely mapped reads number" in line:
				uniqmapped=line.split("\t")[1].rstrip()
				#print(uniqmapped)
			if "Number of reads mapped to multiple loci" in line:
				multiplemapped=line.split("\t")[1].rstrip()
				#print(multiplemapped)
			if "% of reads unmapped: too short " in line:
				tooshort=line.split("\t")[1].rstrip()
				#print(multiplemapped)
		totalmappedreads=(float(uniqmapped)+float(multiplemapped))
		percentmapped=(float(totalmappedreads)/float(inputreads))*100
		percentmappedround= str(round(percentmapped, 2))
		percentmappedtoprint= "".join([percentmappedround,"%"])

		outline=[str(samplename),str(inputreads),str(int(totalmappedreads)), percentmappedtoprint ,tooshort]
		
		outfile.write('\t'.join(outline))
		outfile.write('\n')
 
outfile.close() 
