unsigned int fa[48];
void fibon(void)
{
    unsigned int t1=1, t2=1, nextTerm; 
    for (int i=0; i<48; i++)
    {   
        fa[i] = t1;
        nextTerm = t1 + t2;
        t1 = t2;
        t2 = nextTerm;
    }
}
