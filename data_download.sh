#!/bin/bash

# extract index from passed arguments
while getopts "i:" opt;
do
	case "${opt}"
		in
		i) idx_passed=${OPTARG};;
	esac
done

# alpha vantage variables
aa_function='TIME_SERIES_DAILY_ADJUSTED';
aa_apikey='AF3QF94XJ69S5TPI';
aa_datatype='csv';
aa_outputsize='full';

# we can also download the index itself, it will be appended at the end of the symbols list
download_idx_data=true;

# if we download a .csv and it is smaller than minimumsize in byte, we assume there was an error
# we wait a few second until we start a retry
minimumsize=1000;
wait_time=3;

# compare passed argument with any known index and make sure it is valid, then create the list of symbols
if [ "${idx_passed}" = "nasdaq100" ]; then

	idx='nasdaq100';
	idx_symbol='^NDX';
	
	# source: https://www.nasdaq.com/quotes/nasdaq-100-stocks.aspx

	symbols[0]='AAL';
	symbols[1]='AAPL';
	symbols[2]='ADBE';
	symbols[3]='ADI';
	symbols[4]='ADP';
	symbols[5]='ADSK';
	symbols[6]='ALGN';
	symbols[7]='ALXN';
	symbols[8]='AMAT';
	symbols[9]='AMGN';
	symbols[10]='AMZN';
	symbols[11]='ASML';
	symbols[12]='ATVI';
	symbols[13]='AVGO';
	symbols[14]='BIDU';
	symbols[15]='BIIB';
	symbols[16]='BKNG';
	symbols[17]='BMRN';
	symbols[18]='CA';
	symbols[19]='CDNS';
	symbols[20]='CELG';
	symbols[21]='CERN';
	symbols[22]='CHKP';
	symbols[23]='CHTR';
	symbols[24]='CMCSA';
	symbols[25]='COST';
	symbols[26]='CSCO';
	symbols[27]='CSX';
	symbols[28]='CTAS';
	symbols[29]='CTRP';
	symbols[30]='CTSH';
	symbols[31]='CTXS';
	symbols[32]='DLTR';
	symbols[33]='EA';
	symbols[34]='EBAY';
	symbols[35]='ESRX';
	symbols[36]='EXPE';
	symbols[37]='FAST';
	symbols[38]='FB';
	symbols[39]='FISV';
	symbols[40]='FOX'; #Twenty-First Century Fox, Inc.
	symbols[41]='FOXA'; #Twenty-First Century Fox, Inc.
	symbols[42]='GILD';
	symbols[43]='GOOG'; #Alphabet Inc.
	symbols[44]='GOOGL'; #Alphabet Inc.
	symbols[45]='HAS';
	symbols[46]='HOLX';
	symbols[47]='HSIC';
	symbols[48]='IDXX';
	symbols[49]='ILMN';
	symbols[50]='INCY';
	symbols[51]='INTC';
	symbols[52]='INTU';
	symbols[53]='ISRG';
	symbols[54]='JBHT';
	symbols[55]='JD';
	symbols[56]='KHC';
	symbols[57]='KLAC';
	symbols[58]='LBTYA'; #Liberty Global plc
	symbols[59]='LBTYK'; #Liberty Global plc
	symbols[60]='LRCX';
	symbols[61]='MAR';
	symbols[62]='MCHP';
	symbols[63]='MDLZ';
	symbols[64]='MELI';
	symbols[65]='MNST';
	symbols[66]='MSFT';
	symbols[67]='MU';
	symbols[68]='MXIM';
	symbols[69]='MYL';
	symbols[70]='NFLX';
	symbols[71]='NTES';
	symbols[72]='NVDA';
	symbols[73]='ORLY';
	symbols[74]='PAYX';
	symbols[75]='PCAR';
	symbols[76]='PEP';	
	symbols[77]='PYPL';
	symbols[78]='QCOM';
	symbols[79]='QRTEA';
	symbols[80]='REGN';
	symbols[81]='ROST';
	symbols[82]='SBUX';
	symbols[83]='SHPG';
	symbols[84]='SIRI';
	symbols[85]='SNPS';
	symbols[86]='STX';
	symbols[87]='SWKS';
	symbols[88]='SYMC';
	symbols[89]='TMUS';
	symbols[90]='TSLA';
	symbols[91]='TTWO';
	symbols[92]='TXN';
	symbols[93]='ULTA';
	symbols[94]='VOD';
	symbols[95]='VRSK';
	symbols[96]='VRTX';
	symbols[97]='WBA';
	symbols[98]='WDAY';
	symbols[99]='WDC';
	symbols[100]='WYNN';
	symbols[101]='XLNX';
	symbols[102]='XRAY';

	# download index data if we are interested in it
	if [ $download_idx_data = true ] ; then
		symbols[103]=$idx_symbol;
	fi

elif [ "${idx_passed}" = "tecdax" ]; then

	idx='tecdax';
	idx_symbol='^TECDAX';
	
	# source: Guidants
	
	symbols[0]='AIXA.DE'; 	# Aixtron
	symbols[1]='BC8.DE';	# Bechtle AG
	symbols[2]='COK.DE';	# Cancom
	symbols[3]='AFX.DE';	# Carl Zeiss
	symbols[4]='COP.DE';	# CompuGroup Medical
	symbols[5]='DLG.DE';	# Dialog
	symbols[6]='DRW3.DE';	# Draegerwerk
	symbols[7]='DRI.DE';	# 1&1 Drillisch
	symbols[8]='EVT.DE'; 	# Evotec
	symbols[9]='FNTN.DE';	# freenet AG
	symbols[10]='ISR.DE';	# ISRA
	symbols[11]='JEN.DE';	# Jenoptik
	symbols[12]='MDG1.DE';	# Medigene
	symbols[13]='MOR.DE';	# Morphosys
	symbols[14]='NEM.DE';	# Nemetschek
	symbols[15]='NDX1.DE';	# Nordex
	symbols[16]='PFV.DE'; 	# Pfeiffer
	symbols[17]='QIA.DE';	# Qiagen
	symbols[18]='RIB.DE';	# RIB Software
	symbols[19]='SANT.DE';	# S&T
	symbols[20]='SRT3.DE';	# Satorius
	symbols[21]='SHL.DE';	# Siemens Healthliner
	symbols[22]='WAF.DE';	# Siltronic AG
	symbols[23]='AM3D.DE';	# SLM Solutions
	symbols[24]='S92.DE';	# SMA Solar Technology AG
	symbols[25]='SOW.DE';	# Software AG
	symbols[26]='O2D.DE';	# Telefonica
	symbols[27]='UTDI.DE';	# United Internet
	symbols[28]='WDI.DE';	# Wirecard
	symbols[29]='O1BC.DE';	# XING

	# download index data if we are interested in it
	if [ $download_idx_data = true ] ; then
		symbols[30]=$idx_symbol;
	fi

else

	echo " ";
	echo "Unknown index type: ${idx_passed}."
	echo " ";
	exit 1;

fi

# determine the size of the array
array_size=${#symbols[@]};

# determine date
d=$(date +'%Y_%m_%d_%H_%M_%S');

# create directory were data will be saved
directory="${idx}_${d}";
mkdir $directory;

# now download all symbols one by one
echo " ";
echo " ";
echo "Downloading individual stock data for index ${idx} with symbol ${idx_symbol}:";
echo " ";
echo " ";

# iterate though all symbols and download data
cnt=0;
for current_symbol in ${symbols[@]}
do
	progress=$((100*$cnt/$array_size));

	# show progess
	echo " ";
	echo "###############################################################################";
	echo "###############################################################################";
	echo "Stocksymbol: $current_symbol --- Index in array (starting with 0): $cnt/$array_size --- Progress:  $progress %";
	echo " ";

	# try downloading file until it's larger than minimumsize, otherwise there was an error
	tries=0;
	file_downloaded_correctly=false;
	while [ ${file_downloaded_correctly} != true ]
	do
		tries=$(($tries+1));

		# create query string
		aa_query="https://www.alphavantage.co/query?function=${aa_function}&symbol=${current_symbol}&apikey=${aa_apikey}&datatype=${aa_datatype}&outputsize=${aa_outputsize}";

		# path to current file where data is downloaded to
		current_file="$directory/${current_symbol}.csv";

		# query and write to file
		curl $aa_query -o $current_file;

		# detemine size of file in byte
		actualsize=$(wc -c <$current_file);

		# check if file reaches minimum size
		if [ $actualsize -ge $minimumsize ]; then
			echo " ";
			echo "File downloaded successfully for symbol $current_symbol (idx in list=$cnt).";
			echo "Filesize: $actualsize";
			echo "Try: $tries";
			file_downloaded_correctly=true;
		else
			echo " ";
			echo "File too small for symbol $current_symbol (idx in list=$cnt).";
			echo "Filesize: $actualsize";
			echo "Try: $tries";
			echo "Removing file.";
			#sleep 3; # debugging: check if file is actually deleted
			rm $current_file;
			echo "Going to short sleep before retry.";
			echo " ";
			sleep $wait_time;
		fi
	done

	# increase counter
	cnt=$(($cnt+1));
done

echo " ";
echo "done downloading";
echo " ";
echo " ";

# compress folder with data
tar -zcf ${directory}.tar.gz ${directory}

echo " ";
echo "done compressing";
echo " ";
echo " ";

