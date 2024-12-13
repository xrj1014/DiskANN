
BUILD_DIR=build
K_GT=100 # K for groundtruth

${BUILD_DIR}/apps/utils/compute_groundtruth  --data_type float --dist_fn l2 --base_file data/sift/sift_learn.fbin --query_file  data/sift/sift_query.fbin --gt_file data/sift/sift_query_learn_gt$K_GT --K $K_GT

R_BUILD=32 
L_BUILD=50
A_BUILD=1.2

INDEX_PATH_PREFIX=data/sift/disk_index_sift_learn_R${R_BUILD}_L${L_BUILD}_A${A_BUILD}

${BUILD_DIR}/apps/build_memory_index --data_type float --dist_fn l2 --data_path data/sift/sift_learn.fbin --index_path_prefix ${INDEX_PATH_PREFIX} -R ${R_BUILD} -L${L_BUILD} --alpha ${A_BUILD} 


K_SEARCH=10
L_SEARCH="10 20 30 40 50 100"
RESULT_PATH=data/sift/res

${BUILD_DIR}/apps/search_memory_index  --data_type float --dist_fn l2 --index_path_prefix ${INDEX_PATH_PREFIX} --query_file data/sift/sift_query.fbin  --gt_file data/sift/sift_query_learn_gt$K_GT -K ${K_SEARCH} -L ${L_SEARCH} --result_path ${RESULT_PATH}