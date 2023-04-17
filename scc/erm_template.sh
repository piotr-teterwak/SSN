#!/bin/bash -l



#$ -P ivc-ml

# Specify hard time limit for the job.
#   The job will be aborted if it runs longer than this time.
#   The default time is 12 hours
#$ -l h_rt=336:00:00

# Send an email when the job finishes or if it is aborted (by default no email is sent).
#$ -m ea


# Give job a name

# Combine output and error files into a single file
#$ -j y


#$ -pe omp 4

# Specify gpu number and type2
#$ -l gpus=4
#$ -l gpu_c=7.5




#Set up conda env here


echo $HOSTNAME
echo $CUDA_VISIBLE_DEVICES

./train_imagenet.sh 2 imagenet none imagenet_test


