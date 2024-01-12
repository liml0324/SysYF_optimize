int pure_func(int a, int b){
    return a+b;
}

int main() {
    int j = pure_func(1, 2);
    int k = pure_func(1, 2);
    return j+k;
}