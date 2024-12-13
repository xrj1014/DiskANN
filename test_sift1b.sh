
BUILD_DIR=build
DATATYPE=uint8
R_BUILD=32
L_BUILD=50
A_BUILD=1.2
INDEX_PATH_PREFIX=data/sift1B/test/disk_index_sift1B_learn_R${R_BUILD}_L${L_BUILD}_A${A_BUILD}
QUERY_FILE=data/sift1B/bigann_query.bbin
GT_FILE=data/sift1B/bigann_gt100_learn
DATA_PATH=data/sift1B/bigann_learn.bbin


# generate the ground truth
# ${BUILD_DIR}/apps/utils/compute_groundtruth  --data_type ${DATATYPE} --dist_fn l2 --base_file ${DATA_PATH} --query_file ${QUERY_FILE} --gt_file data/sift1B/bigann_gt100_learn --K 100


# Build the index

# B_BUILD=10.0
# M_BUILD=10.0

# ${BUILD_DIR}/apps/build_disk_index --data_type ${DATATYPE} --dist_fn l2 --data_path ${DATA_PATH} --index_path_prefix ${INDEX_PATH_PREFIX} -R ${R_BUILD} -L${L_BUILD} -B ${B_BUILD} -M ${M_BUILD} -A ${A_BUILD} 

# Search 
K_SEARCH=10
L_SEARCH="10 20 30 40 50 100"
RESULT_PATH=data/sift1B/test/res

${BUILD_DIR}/apps/search_disk_index  --data_type ${DATATYPE} --dist_fn l2 --index_path_prefix ${INDEX_PATH_PREFIX} --query_file ${QUERY_FILE} --gt_file ${GT_FILE} -K ${K_SEARCH} -L ${L_SEARCH} --result_path ${RESULT_PATH} --num_nodes_to_cache 0