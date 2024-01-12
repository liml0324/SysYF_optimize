void pure_func(int a[]){
    a[0] = 1;
    return;
}

int main() {
    int a[2];
    pure_func(a);
    return a[0];
}