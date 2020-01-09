#!/bin/bash

## APPS Files ##
declare -A appSKEL=(["bzip2"]="/home/benchmarks/spec2006/401.bzip2/data-ref/*" ["calculix"]="/home/benchmarks/spec2006/454.calculix/data-ref/*" ["povray_r"]="/home/benchmarks/spec2017/benchspec/CPU/511.povray_r/data/refrate/input/* /home/benchmarks/spec2017/benchspec/CPU/511.povray_r/data/all/input/*" ["cam4_r"]="/home/benchmarks/spec2017/benchspec/CPU/527.cam4_r/data/refrate/input/* /home/benchmarks/spec2017/benchspec/CPU/527.cam4_r/data/all/input/*" ["h264ref"]="/home/benchmarks/spec2006/464.h264ref/data-ref/*" ["libquantum"]="/home/benchmarks/spec2006/462.libquantum/data-ref/*" ["namd"]="/home/benchmarks/spec2006/444.namd/data-ref/*" ["povray"]="/home/benchmarks/spec2006/453.povray/data-ref/*" ["omnetpp_r"]="/home/benchmarks/spec2017/benchspec/CPU/520.omnetpp_r/data/refrate/input/* /home/benchmarks/spec2017/benchspec/CPU/520.omnetpp_r/data/all/input/*")

## APPS dirs ##
declare -A appDIR=(["bzip2"]="/home/benchmarks/spec2006/401.bzip2/bzip2_base.i386" ["calculix"]="/home/benchmarks/spec2006/454.calculix/calculix_base.i386" ["povray_r"]="/home/benchmarks/spec2017/benchspec/CPU/511.povray_r/exe/povray_r_base.InitialTest-m64" ["cam4_r"]="/home/benchmarks/spec2017/benchspec/CPU/527.cam4_r/exe/cam4_r_base.InitialTest-m64" ["h264ref"]="/home/benchmarks/spec2006/464.h264ref/h264ref_base.i386" ["libquantum"]="/home/benchmarks/spec2006/462.libquantum/libquantum_base.i386" ["namd"]="/home/benchmarks/spec2006/444.namd/namd_base.i386" ["povray"]="/home/benchmarks/spec2006/453.povray/povray_base.i386" ["omnetpp_r"]="/home/benchmarks/spec2017/benchspec/CPU/520.omnetpp_r/exe/omnetpp_r_base.InitialTest-m64")

## APPS input ##
declare -A appINPUT=(["bzip2"]="/home/benchmarks/spec2006/401.bzip2/data-ref/input.source 280" ["calculix"]="-i /home/benchmarks/spec2006/454.calculix/data-ref/hyperviscoplastic" ["povray_r"]="/home/benchmarks/spec2017/benchspec/CPU/511.povray_r/data/refrate/input/SPEC-benchmark-ref.ini" ["cam4_r"]="" ["h264ref"]="-d sss_encoder_main.cfg" ["libquantum"]="1397 8" ["namd"]="--input namd.input --iterations 38" ["povray"]="SPEC-benchmark-ref.ini" ["omnetpp_r"]="-c General -r 0")

# hardware counters to sample periodicially
# will be used for constructing KPart's online app cache profiles
perfCounters='INST_RETIRED,LONGEST_LAT_CACHE:REFERENCE,UNHALTED_CORE_CYCLES'

# KPart parameters:
phaseLen=20000000  #sample HW counters every 20M instr.
numPhases=1000 #measure the first 2000 phases in each running program
logFile="perfCtrs" #prefix for log file where hardware counters are stored
warmupPeriod=10  #start profiling after this init period (unit: B cycles)
profilingPeriod=10 #profile co-running applications every this much B cycles


# WORKLOAD TO EXECUTE
declare -a appsArray=("povray_r" "cam4_r" "calculix" "h264ref" "libquantum" "namd" "povray" "omnetpp_r")
processStr=""

echo "Creating folders and copying files..."
for pid in ${!appsArray[@]}; do

	mkdir -p "p"$pid
	
	# Create folders to store input files 
	declare -a skel=(${appSKEL[${appsArray[pid]}]})
	for dir in ${skel[@]}; do
		cp -r $dir "p"$pid
	done

	processStr=$processStr" -- "$numPhases" - "$pid" "${appDIR[${appsArray[pid]}]}" "${appINPUT[${appsArray[pid]}]}
	
done
echo "Done copying!"

echo "$perfCounters $phaseLen $logFile $warmupPeriod $profilingPeriod $processStr"

# Pin KPart thread to core 15 (hyperthreading enabled)
STARTTIME=$(($(date +%s%N)/1000000))

numactl -C 2 ../src/kpart $perfCounters $phaseLen $logFile $warmupPeriod $profilingPeriod $processStr

ENDTIME=$(($(date +%s%N)/1000000))
echo "Elapsed time = $(($ENDTIME - $STARTTIME)) milliseconds."

for pid in ${!appsArray[@]}; do
	# Delete folders to store input files 
	rm -r "p"$pid
done

