
const int BLOCK_SIZE = 255;
const int MAX_N_INODE = 256;
const int MAX_N_DATA_BLOCK = 256;

struct SuperBlock {
	int n_inode : 8;
	int n_data_block : 8;
	int inode_bitmap[64];
	int data_block_bitmap[64];
} Superblock;

struct DataBlock {
	char space[BLOCK_SIZE];
} DataBlock;

struct Inode {
	int used : 1;
	int inode_number : 8;
	int file_size;
	int block_index;
	int create_t;
	int modify_t;
} Inode;


typedef struct FileSystem {
	struct SuperBlock super_block;
	struct Inode inode_list[256];
	struct DataBlock data_block[256];
} FileSystem;

