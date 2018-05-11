#---------------------------------------------------------
# 
#  Project #3: Drawing grid lines in an image
#
#  April 30, 2018
#
#  Jin-Soo Kim (jinsoo.kim@snu.ac.kr)
#  Systems Software & Architecture Laboratory
#  Dept. of Computer Science and Engineering
#  Seoul National University
#
#---------------------------------------------------------

CC	= gcc
AS	= as
CFLAGS	= -g -Og -Wall
ASFLAGS	= -g
LDFLAGS	= 
RM	= rm
CMP = cmp

CSRCS	= bmp.c 
ASRCS	= bmpgrid.s
TARGET	= bmpgrid
OBJECTS	= $(CSRCS:.c=.o) $(ASRCS:.s=.o)
INBMP	= bts.bmp
OUTBMP	= btsout.bmp
ANSBMP	= bts-ans.bmp
GAP		= 100

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

.s.o:
	$(AS) $(ASFLAGS) $< -o $@

clean:
	$(RM) -f $(OBJECTS) $(TARGET) $(OUTBMP) *~

run:
	@$(RM) -f $(OUTBMP)
	./$(TARGET)	$(INBMP) $(OUTBMP) $(GAP)

test:
	$(CMP) $(OUTBMP) $(ANSBMP)
