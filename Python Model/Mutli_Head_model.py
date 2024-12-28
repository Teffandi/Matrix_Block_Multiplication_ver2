import numpy as np

#matrix parameter (note : B will be tranversed)
size_row = 512
size_coloumn = 64

array_A = np.random.randint(1,20,size=(size_row,size_coloumn)) #random array A with size 512 and 64
array_B = np.random.randint(1,20,size=(size_coloumn,size_row)) #random array B with size 64 and 512
array_C = np.zeros((size_row,size_row)) #array multiplication output buffer
array_D = np.zeros((size_row,size_row)) #test array


buffer_A = np.zeros((4,4)) #buffer for selecting partition block form matrix A
buffer_B = np.zeros((4,4)) #buffer for selecting partition block form matrix B
buffer_temp = np.zeros((4,4)) #temporary buffer for calculating 4x4 multiplication
buffer_accumulator = np.zeros((4,4)) #temporary buffer for accumulating 4x4 multplication to produce a singular partition 

#note : for matrix A and B, there will be 2048 4x4 matrix partition
# to handle such, we will be trying modulo 4 to traverse both matrix
print(array_A)
print(array_B)
print("==================")

#for out_row in range(0,size_row//4):
#    for out_col in range(0,size_row//4):

for row_out in range(0,size_row//4):
    for col_out in range(0,size_row//4):
        for scan_col in range (0,size_coloumn//4):
            for row_buff in range (0,4):
                for col_buff in range (0,4):
                    buffer_A[row_buff,col_buff] = array_A[row_out*4+row_buff,scan_col*4+col_buff]
                    buffer_B[col_buff,row_buff] = array_B[scan_col*4+col_buff,col_out*4+row_buff]           

            buffer_accumulator = np.add(buffer_accumulator,np.matmul(buffer_A,buffer_B))

        #print(buffer_accumulator)

        for row_buff in range (0,4):
            for col_buff in range (0,4):
                array_C[4*row_out+row_buff,4*col_out+col_buff] = buffer_accumulator[row_buff,col_buff]       

        buffer_accumulator = np.zeros((4,4)) #temporary buffer for accumulating 4x4 multplication to produce a singular partition 

array_D = np.matmul(array_A,array_B)

print(array_C == array_D)
