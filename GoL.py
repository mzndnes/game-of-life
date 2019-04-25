import pyopencl as cl
import sys
import numpy as np
import matplotlib.pyplot as plt
import time

def colorize(img) :
	img_f = 1-img.astype(np.float32)
	return np.dstack([img_f, img_f, img_f])

## main
if __name__ == "__main__" :

        if len(sys.argv) < 3 :
                print("usage : {} seed_file iteration".format(sys.argv[0]))
                exit(1)

        SeedFile = sys.argv[1]
        Iteration = sys.argv[2]
        OutFile = "out.txt"
        rw=8
        cm=8
        img = np.loadtxt(SeedFile, dtype=np.int32)
        

        platforms = cl.get_platforms()
        devices = platforms[0].get_devices(device_type = cl.device_type.ALL)
        context = cl.Context(devices = [devices[0]], properties = None)
        queue = cl.CommandQueue(context = context, device = devices[0], properties = 0)

        szType = np.dtype(np.float32).itemsize
        livebuf = cl.Buffer(context = context, flags = cl.mem_flags.READ_WRITE, size=rw*cm*szType)
        producebuf = cl.Buffer(context = context, flags = cl.mem_flags.READ_WRITE, size=rw*cm*szType)
        alivebuf = cl.Buffer(context = context, flags = cl.mem_flags.READ_WRITE, size=rw*cm*szType)

        cl.enqueue_copy(queue=queue, dest=livebuf, src=img, is_blocking=False)

        prg1 = cl.Program(context, open('krnel.cl').read()).build()
        prg2 = cl.Program(context, open('krnel1.cl').read()).build()
        prg3 = cl.Program(context, open('krnel2.cl').read()).build()

        fig = plt.figure(frameon=False, figsize=(6,6))
        plt.axis('off')
        plt.axis('equal')
        plt.margins(x=0, y=0, tight=True)
        im = plt.imshow(colorize(img), interpolation='nearest')
        plt.show()
        
        for i in range(np.int32(Iteration)):
                
                prg1.produce(queue, (rw,cm), None, livebuf,producebuf )#execute kernel
                prg2.remainalive(queue, (rw,cm), None, livebuf,alivebuf )
                prg3.resultlive(queue, (rw,cm), None, livebuf,alivebuf,producebuf )

                cl.enqueue_copy(queue=queue, dest=img, src=livebuf, is_blocking=False)
               
                fig = plt.figure(frameon=False, figsize=(6,6))
                plt.axis('off')
                plt.axis('equal')
                plt.margins(x=0, y=0, tight=True)
                im = plt.imshow(colorize(img), interpolation='nearest')
                plt.draw()
                plt.pause(1e-17)
                time.sleep(0.1)
                
        plt.show()
        np.savetxt(OutFile, img, fmt='%d')
"""
        for i in range(np.int32(Iteration)):
                program.produce(queue, (rw,cm), None, livebuf,producebuf )
                program.remainalive(queue, (rw,cm), None, livebuf,alivebuf )
                program.resultlive(queue, (rw,cm), None, livebuf,alivebuf,producebuf)
                            
                cl.enqueue_copy(queue=queue, dest=img, src=livebuf, is_blocking=False)

                fig = plt.figure(frameon=False, figsize=(6,6))
                plt.axis('off')
                plt.axis('equal')
                plt.margins(x=0, y=0, tight=True)
                im = plt.imshow(colorize(img), interpolation='nearest')
                plt.show()
                
                #if i<Iteration:
                plt.close()
"""

        


	
