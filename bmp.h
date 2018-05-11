//---------------------------------------------------------
// 
// Project #3: Drawing grid lines in an image
//
// April 30, 2018
//
// Jin-Soo Kim (jinsoo.kim@snu.ac.kr)
// Systems Software & Architecture Laboratory
// Dept. of Computer Science and Engineering
// Seoul National University
//
//---------------------------------------------------------


#define	BMP_MAGIC		((unsigned short) 0x4d42)


#define BITMAPCOREHEADER	(12)
#define BITMAPCOREHEADER2	(64)
#define BITMAPINFOHEADER	(40)
#define BITMAPV4HEADER		(108)
#define BITMAPV5HEADER		(124)

#define BI_RGB			0
#define BI_RLE8			1
#define BI_RLE4			2
#define BI_BITFIELDS	3
#define BI_JPEG			4
#define BI_PNG			5



typedef struct {
	unsigned short 	magic;
	unsigned short	length_low;
	unsigned short	length_high;
	unsigned short	pad1;
	unsigned short 	pad2;
	unsigned short	offset_low;
	unsigned short 	offset_high;
} bmp_header;


typedef struct {
	unsigned int	size;
	int				width;
	int				height;
	unsigned short	planes;
	unsigned short	bitcount;
	unsigned int	compression;
	unsigned int	size_image;
	int				xpixels_per_meter;
	int				ypixels_per_meter;
	unsigned int	colors_used;
	unsigned int	colors_important;
} bi_header;

struct bmp_info {
	unsigned char	*memptr;
	unsigned char	*imgptr;
	int				filesize;
	int				offset;
	long long		width;
	long long		height;
	long long 		gap;
};

void bmp_grid (unsigned char *imgptr, long long width, long long height, long long gap);


