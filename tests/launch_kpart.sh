#!/bin/bash

function join_by { local IFS="$1"; shift; echo "$*"; }

## APPS Files ##
declare -A appSKEL=(["bzip2"]="/home/benchmarks/spec2006/401.bzip2/data-ref/*" ["calculix"]="/home/benchmarks/spec2006/454.calculix/data-ref/*" ["povray_r"]="/home/benchmarks/spec2017/benchspec/CPU/511.povray_r/data/refrate/input/* /home/benchmarks/spec2017/benchspec/CPU/511.povray_r/data/all/input/*" ["cam4_r"]="/home/benchmarks/spec2017/benchspec/CPU/527.cam4_r/data/refrate/input/* /home/benchmarks/spec2017/benchspec/CPU/527.cam4_r/data/all/input/*" ["h264ref"]="/home/benchmarks/spec2006/464.h264ref/data-ref/*" ["libquantum"]="/home/benchmarks/spec2006/462.libquantum/data-ref/*" ["namd"]="/home/benchmarks/spec2006/444.namd/data-ref/*" ["povray"]="/home/benchmarks/spec2006/453.povray/data-ref/*" ["omnetpp_r"]="/home/benchmarks/spec2017/benchspec/CPU/520.omnetpp_r/data/refrate/input/* /home/benchmarks/spec2017/benchspec/CPU/520.omnetpp_r/data/all/input/*" ["perlbench"]="/home/benchmarks/spec2006/400.perlbench/data-ref/*" ["bwaves"]="/home/benchmarks/spec2006/410.bwaves/data-ref/*" ["gamess"]="/home/benchmarks/spec2006/416.gamess/data-ref/*" ["mcf"]="/home/benchmarks/spec2006/429.mcf/data-ref/*" ["milc"]="/home/benchmarks/spec2006/433.milc/data-ref/*" ["zeusmp"]="/home/benchmarks/spec2006/434.zeusmp/data-ref/*" ["gromacs"]="/home/benchmarks/spec2006/435.gromacs/data-ref/*" ["cactusADM"]="/home/benchmarks/spec2006/436.cactusADM/data-ref/*" ["leslie3d"]="/home/benchmarks/spec2006/437.leslie3d/data-ref/*" ["gobmk"]="/home/benchmarks/spec2006/445.gobmk/data-ref/*" ["dealII"]="/home/benchmarks/spec2006/447.dealII/data-ref/*" ["soplex"]="/home/benchmarks/spec2006/450.soplex/data-ref/*" ["hmmer"]="/home/benchmarks/spec2006/456.hmmer/data-ref/*" ["sjeng"]="/home/benchmarks/spec2006/458.sjeng/data-ref/*" ["GemsFDTD"]="/home/benchmarks/spec2006/459.GemsFDTD/data-ref/*" ["tonto"]="/home/benchmarks/spec2006/465.tonto/data-ref/*" ["lbm"]="/home/benchmarks/spec2006/470.lbm/data-ref/*" ["omnetpp"]="/home/benchmarks/spec2006/471.omnetpp/data-ref/*" ["astar"]="/home/benchmarks/spec2006/473.astar/data-ref/*" ["wrf"]="/home/benchmarks/spec2006/481.wrf/data-ref/*" ["sphinx3"]="/home/benchmarks/spec2006/482.sphinx3/data-ref/*" ["xalancbmk"]="/home/benchmarks/spec2006/483.xalancbmk/data-ref/*" ["perlbench_r"]="/home/benchmarks/spec2017/benchspec/CPU/500.perlbench_r/data/refrate/input/* /home/benchmarks/spec2017/benchspec/CPU/500.perlbench_r/data/all/input/*" ["gcc_r"]="/home/benchmarks/spec2017/benchspec/CPU/502.gcc_r/data/refrate/input/*" ["bwaves_r"]="/home/benchmarks/spec2017/benchspec/CPU/503.bwaves_r/data/refrate/input/*" ["mcf_r"]="/home/benchmarks/spec2017/benchspec/CPU/505.mcf_r/data/refrate/input/*" ["cactuBSSN_r"]="/home/benchmarks/spec2017/benchspec/CPU/507.cactuBSSN_r/data/refrate/input/*" ["namd_r"]="/home/benchmarks/spec2017/benchspec/CPU/508.namd_r/data/refrate/input/* /home/benchmarks/spec2017/benchspec/CPU/508.namd_r/data/all/input/*" ["parest_r"]="/home/benchmarks/spec2017/benchspec/CPU/510.parest_r/data/refrate/input/*" ["lbm_r"]="/home/benchmarks/spec2017/benchspec/CPU/519.lbm_r/data/refrate/input/*" ["wrf_r"]="/home/benchmarks/spec2017/benchspec/CPU/521.wrf_r/data/refrate/input/* /home/benchmarks/spec2017/benchspec/CPU/521.wrf_r/data/all/input/*" ["xalancbmk_r"]="/home/benchmarks/spec2017/benchspec/CPU/523.xalancbmk_r/data/refrate/input/*" ["x264_r"]="/home/benchmarks/spec2017/benchspec/CPU/525.x264_r/data/refrate/input/*" ["blender_r"]="/home/benchmarks/spec2017/benchspec/CPU/526.blender_r/data/refrate/input/*" ["leela_r"]="/home/benchmarks/spec2017/benchspec/CPU/541.leela_r/data/refrate/input/*" ["deepsjeng_r"]="/home/benchmarks/spec2017/benchspec/CPU/531.deepsjeng_r/data/refrate/input/*" ["imagick_r"]="/home/benchmarks/spec2017/benchspec/CPU/538.imagick_r/data/refrate/input/*" ["nab_r"]="/home/benchmarks/spec2017/benchspec/CPU/544.nab_r/data/refrate/input/*" ["exchange2_r"]="/home/benchmarks/spec2017/benchspec/CPU/548.exchange2_r/data/refrate/input/* /home/benchmarks/spec2017/benchspec/CPU/548.exchange2_r/data/all/input/*" ["fotonik3d_r"]="/home/benchmarks/spec2017/benchspec/CPU/549.fotonik3d_r/data/refrate/input/*" ["roms_r"]="/home/benchmarks/spec2017/benchspec/CPU/554.roms_r/data/refrate/input/* /home/benchmarks/spec2017/benchspec/CPU/554.roms_r/data/all/input/*")

## APPS dirs ##
declare -A appDIR=(["bzip2"]="/home/benchmarks/spec2006/401.bzip2/bzip2_base.i386" ["calculix"]="/home/benchmarks/spec2006/454.calculix/calculix_base.i386" ["povray_r"]="/home/benchmarks/spec2017/benchspec/CPU/511.povray_r/exe/povray_r_base.InitialTest-m64" ["cam4_r"]="/home/benchmarks/spec2017/benchspec/CPU/527.cam4_r/exe/cam4_r_base.InitialTest-m64" ["h264ref"]="/home/benchmarks/spec2006/464.h264ref/h264ref_base.i386" ["libquantum"]="/home/benchmarks/spec2006/462.libquantum/libquantum_base.i386" ["namd"]="/home/benchmarks/spec2006/444.namd/namd_base.i386" ["povray"]="/home/benchmarks/spec2006/453.povray/povray_base.i386" ["omnetpp_r"]="/home/benchmarks/spec2017/benchspec/CPU/520.omnetpp_r/exe/omnetpp_r_base.InitialTest-m64" ["perlbench"]="/home/benchmarks/spec2006/400.perlbench/perlbench_base.i386" ["bwaves"]="/home/benchmarks/spec2006/410.bwaves/bwaves_base.i386" ["gamess"]="/home/benchmarks/spec2006/416.gamess/gamess_base.i386" ["mcf"]="/home/benchmarks/spec2006/429.mcf/mcf_base.i386" ["milc"]="/home/benchmarks/spec2006/433.milc/milc_base.i386" ["zeusmp"]="/home/benchmarks/spec2006/434.zeusmp/zeusmp_base.i386" ["gromacs"]="/home/benchmarks/spec2006/435.gromacs/gromacs_base.i386" ["cactusADM"]="/home/benchmarks/spec2006/436.cactusADM/cactusADM_base.i386" ["leslie3d"]="/home/benchmarks/spec2006/437.leslie3d/leslie3d_base.i386" ["gobmk"]="/home/benchmarks/spec2006/445.gobmk/gobmk_base.i386" ["dealII"]="/home/benchmarks/spec2006/447.dealII/dealII_base.i386" ["soplex"]="/home/benchmarks/spec2006/450.soplex/soplex_base.i386" ["hmmer"]="/home/benchmarks/spec2006/456.hmmer/hmmer_base.i386" ["sjeng"]="/home/benchmarks/spec2006/458.sjeng/sjeng_base.i386" ["GemsFDTD"]="/home/benchmarks/spec2006/459.GemsFDTD/GemsFDTD_base.i386" ["tonto"]="/home/benchmarks/spec2006/465.tonto/tonto_base.i386" ["lbm"]="/home/benchmarks/spec2006/470.lbm/lbm_base.i386" ["omnetpp"]="/home/benchmarks/spec2006/471.omnetpp/omnetpp_base.i386" ["astar"]="/home/benchmarks/spec2006/473.astar/astar_base.i386" ["wrf"]="/home/benchmarks/spec2006/481.wrf/wrf_base.i386" ["sphinx3"]="/home/benchmarks/spec2006/482.sphinx3/sphinx3_base.i386" ["xalancbmk"]="/home/benchmarks/spec2006/483.xalancbmk/xalancbmk_base.i386" ["perlbench_r"]="/home/benchmarks/spec2017/benchspec/CPU/500.perlbench_r/launch_perlbench_r.sh" ["gcc_r"]="/home/benchmarks/spec2017/benchspec/CPU/502.gcc_r/launch_gcc_r.sh" ["bwaves_r"]="/home/benchmarks/spec2017/benchspec/CPU/503.bwaves_r/launch_bwaves_r.sh" ["mcf_r"]="/home/benchmarks/spec2017/benchspec/CPU/505.mcf_r/exe/mcf_r_base.InitialTest-m64" ["cactuBSSN_r"]="/home/benchmarks/spec2017/benchspec/CPU/507.cactuBSSN_r/exe/cactusBSSN_r_base.InitialTest-m64" ["namd_r"]="/home/benchmarks/spec2017/benchspec/CPU/508.namd_r/exe/namd_r_base.InitialTest-m64" ["parest_r"]="/home/benchmarks/spec2017/benchspec/CPU/510.parest_r/exe/parest_r_base.InitialTest-m64" ["lbm_r"]="/home/benchmarks/spec2017/benchspec/CPU/519.lbm_r/exe/lbm_r_base.InitialTest-m64" ["wrf_r"]="/home/benchmarks/spec2017/benchspec/CPU/521.wrf_r/exe/wrf_r_base.InitialTest-m64" ["xalancbmk_r"]="/home/benchmarks/spec2017/benchspec/CPU/523.xalancbmk_r/exe/cpuxalan_r_base.InitialTest-m64" ["x264_r"]="/home/benchmarks/spec2017/benchspec/CPU/525.x264_r/launch_x264_r.sh" ["blender_r"]="/home/benchmarks/spec2017/benchspec/CPU/526.blender_r/exe/blender_r_base.InitialTest-m64" ["leela_r"]="/home/benchmarks/spec2017/benchspec/CPU/541.leela_r/exe/leela_r_base.InitialTest-m64" ["deepsjeng_r"]="/home/benchmarks/spec2017/benchspec/CPU/531.deepsjeng_r/exe/deepsjeng_r_base.InitialTest-m64" ["imagick_r"]="/home/benchmarks/spec2017/benchspec/CPU/538.imagick_r/exe/imagick_r_base.InitialTest-m64" ["nab_r"]="/home/benchmarks/spec2017/benchspec/CPU/544.nab_r/exe/nab_r_base.InitialTest-m64" ["exchange2_r"]="/home/benchmarks/spec2017/benchspec/CPU/548.exchange2_r/exe/exchange2_r_base.InitialTest-m64" ["fotonik3d_r"]="/home/benchmarks/spec2017/benchspec/CPU/549.fotonik3d_r/exe/fotonik3d_r_base.InitialTest-m64" ["roms_r"]="/home/benchmarks/spec2017/benchspec/CPU/554.roms_r/exe/roms_r_base.InitialTest-m64") 

## APPS input ##
declare -A appINPUT=(["bzip2"]="input.source 280" ["calculix"]="-i hyperviscoplastic" ["povray_r"]="SPEC-benchmark-ref.ini" ["cam4_r"]="" ["h264ref"]="-d sss_encoder_main.cfg" ["libquantum"]="1397 8" ["namd"]="--input namd.input --iterations 38" ["povray"]="SPEC-benchmark-ref.ini" ["omnetpp_r"]="-c General -r 0" ["perlbench"]="checkspam.pl 2500 5 25 11 150 1 1 1 1" ["bwaves"]="" ["gamess"]="" ["mcf"]="inp.in" ["milc"]="" ["zeusmp"]="" ["gromacs"]="-silent -deffnm gromacs -nice 0" ["cactusADM"]="benchADM.par" ["leslie3d"]="" ["gobmk"]="--quiet --mode gtp" ["dealII"]="23" ["soplex"]="-s1 -e -m45000 pds-50.mps" ["hmmer"]="--fixed 0 --mean 500 --num 500000 --sd 350 --seed 0 retro.hmm" ["sjeng"]="ref.txt" ["GemsFDTD"]="" ["tonto"]="" ["lbm"]="3000 reference.dat 0 0 100_100_130_ldc.of" ["omnetpp"]="omnetpp.ini" ["astar"]="rivers.cfg" ["wrf"]="namelist.input" ["sphinx3"]="ctlfile . args.an4" ["xalancbmk"]="-v t5.xml xalanc.xsl" ["perlbench_r"]="" ["gcc_r"]="" ["bwaves_r"]="" ["mcf_r"]="np.in" ["cactuBSSN_r"]="spec_ref.par" ["namd_r"]="--input apoa1.input --output apoa1.ref.output --iterations 65" ["parest_r"]="ref.prm" ["lbm_r"]="3000 reference.dat 0 0 100_100_130_ldc.of" ["wrf_r"]="" ["xalancbmk_r"]="-v t5.xml xalanc.xsl" ["x264_r"]="" ["blender_r"]="sh3_no_char.blend --render-output sh3_no_char_ --threads 1 -b -F RAWTGA -s 849 -e 849 -a" ["leela_r"]="ref.sgf" ["deepsjeng_r"]="ref.txt" ["imagick_r"]="-limit disk 0 refrate_input.tga -edge 41 -resample 181% -emboss 31 -colorspace YUV -mean-shift 19x19+15% -resize 30% refrate_output.tga" ["nab_r"]="1am0 1122214447 122" ["exchange2_r"]="6" ["fotonik3d_r"]="" ["roms_r"]="")

declare -A appSTDIN=(["bzip2"]="-" ["calculix"]="-" ["povray_r"]="-" ["cam4_r"]="-" ["h264ref"]="-" ["libquantum"]="-" ["namd"]="-" ["povray"]="-" ["omnetpp_r"]="-" ["perlbench"]="-" ["bwaves"]="-" ["gamess"]="triazolium.config" ["mcf"]="-" ["milc"]="su3imp.in" ["zeusmp"]="-" ["gromacs"]="-" ["cactusADM"]="-" ["leslie3d"]="leslie3d.in" ["gobmk"]="13x13.tst" ["dealII"]="-" ["soplex"]="-" ["hmmer"]="-" ["sjeng"]="-" ["GemsFDTD"]="-" ["tonto"]="-" ["lbm"]="-" ["omnetpp"]="omnetpp.ini" ["astar"]="-" ["wrf"]="-" ["sphinx3"]="-" ["xalancbmk"]="-" ["perlbench_r"]="-" ["gcc_r"]="-" ["bwaves_r"]="bwaves_1.in bwaves_2.in bwaves_3.in bwaves_4.in" ["mcf_r"]="-" ["cactuBSSN_r"]="-" ["namd_r"]="-" ["parest_r"]="-" ["lbm_r"]="-" ["wrf_r"]="-" ["xalancbmk_r"]="-" ["x264_r"]="-" ["blender_r"]="-" ["leela_r"]="-" ["deepsjeng_r"]="-" ["imagick_r"]="-" ["nab_r"]="-" ["exchange2_r"]="-" ["fotonik3d_r"]="-" ["roms_r"]="ocean_benchmark2.in.x")


# hardware counters to sample periodicially
# will be used for constructing KPart's online app cache profiles
perfCounters='INST_RETIRED,LONGEST_LAT_CACHE:REFERENCE,UNHALTED_CORE_CYCLES'

# KPart parameters:
phaseLen=20000000  #sample HW counters every 20M instr.
numPhases=10000  # all applications complete at leaste 200 B instructions
logFile="perfCtrs" #prefix for log file where hardware counters are stored
warmupPeriod=60  # 60B instructions ---> start profiling after this init period (unit: B cycles)
profilingPeriod=40 #40B cycles ----> profile co-running applications every this much B cycles

# Enable prefetchers
wrmsr -a 0x1A4 0x0

# Set performance governor
echo performance | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
echo 2200000 | tee /sys/devices/system/cpu/cpufreq/policy*/scaling_min_freq > /dev/null

WORKLOADS=$1
while read WL; do
	WL=$(echo $WL | tr '\-[],' " ")
	echo $WL
	
	WLfolder=$(join_by - ${WL[@]})
	mkdir $WLfolder
	
	cd $WLfolder

	# WORKLOAD TO EXECUTE
	declare -a appsArray=($WL)
	processStr=""

	echo "Creating folders and copying files..."
	for pid in ${!appsArray[@]}; do

		mkdir -p "p"$pid
		
		# Create folders to store input files 
		declare -a skel=(${appSKEL[${appsArray[pid]}]})
		for dir in ${skel[@]}; do
			cp -r $dir "p"$pid
		done

		processStr=$processStr" -- "$numPhases" "${appSTDIN[${appsArray[pid]}]}" "$pid" "${appDIR[${appsArray[pid]}]}" "${appINPUT[${appsArray[pid]}]}
		
	done
	echo "Done copying!"

	echo "Start execution..."

	echo "$perfCounters $phaseLen $logFile $warmupPeriod $profilingPeriod $processStr" | tee output.log

	# Pin KPart thread to core 15 (hyperthreading enabled)
	STARTTIME=$(($(date +%s%N)/1000000))

	numactl -C 2 /home/lupones/kpart/src/kpart $perfCounters $phaseLen $logFile $warmupPeriod $profilingPeriod $processStr 2>&1 | tee -a output.log

	ENDTIME=$(($(date +%s%N)/1000000))
	echo "Finished! Elapsed time = $(($ENDTIME - $STARTTIME)) milliseconds."
	echo "Elapsed time = $(($ENDTIME - $STARTTIME)) milliseconds." | tee -a output.log

	for pid in ${!appsArray[@]}; do
		# Delete folders to store input files 
		rm -r "p"$pid
	done

	cd ..

done < $WORKLOADS 

echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy*/scaling_min_freq > /dev/null

