#!/bin/bash -l
#SBATCH --partition milano
#SBATCH --account rubin:developers
#SBATCH --nodes 1
#SBATCH --mem=200G
#SBATCH --cpus-per-task=18
#SBATCH -t 10:00:00
#SBATCH --job-name comcam_exp_time_wcs-gaia-pipeline
#SBATCH --output=/sdf/home/b/brycek/aos_repo/brycek/WET-013/sitcomtn-133/notebooks/scripts/wcs-gaia.out
echo "starting at `date` on `hostname`"
pwd
source /sdf/home/b/brycek/setup_aos.sh
cd /sdf/home/b/brycek/aos_repo/brycek/WET-013/sitcomtn-133/notebooks/scripts
pipetask run -b /sdf/group/rubin/repo/aos_imsim/ -i refcats,WET-013 --instrument lsst.obs.lsst.LsstComCamSim --register-dataset-types -o WET-013/wcsGaiaCatalog -p science_gaia_pipeline.yaml -d "detector IN (0..9) AND instrument='LSSTComCamSim'" -j 18
echo "ended at `date` on `hostname`"
