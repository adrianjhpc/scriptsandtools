CC=cc
CFLAGS=-DPYTHON2 -dynamic ${PYTHON_INCLUDE_OPTS}
#CFLAGS=-DPYTHON35 -dynamic ${PYTHON_INCLUDE_OPTS}
LDFLAGS=-L/work/y07/y07/cse/python/2.7.6/lib -lpython2.7
#LDFLAGS=-L/work/y07/y07/cse/python/3.5/lib -lpython3.5m


taskfarm: taskfarm.c 
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

