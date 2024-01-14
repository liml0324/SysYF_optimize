int glob=1;

int main() {
    int i=0, j=0, k=0;
    int a[10];
    while(i<10) {
        a[i] = 0;
        a[1] = 1;
        i = i + 1;
    }
    return a[1];
}